"""
Decompose_v2
------------
"""

import spydrnet as sdn
import networkx as nx
from collections import deque

connectivity_graph = None
sequential_graph = None
feedback_hierarchy = None

def run():
    global connectivity_graph
    print("Welcome")
    netlist = sdn.parse("b13.edf")
    report_primitive_usage()
    create_connectivity_graph()
    create_sequential_graph()
    fold_feedback()
    export_sequential_graph_dot()
    print("Complete")
    
def report_primitive_usage():
    primitive_usage = dict()
    search_stack = [sdn.current_netlist().top_instance]
    while search_stack:
        current_instance = search_stack.pop()
        reference_def = current_instance.definition
        if len(reference_def.instances) == 0 and len(reference_def.cables) == 0:
            ref_name = reference_def['EDIF.identifier']
            primitive_usage[ref_name] = primitive_usage.get(ref_name, 0) + 1
        else:
            search_stack += reference_def.instances
    for name, count in sorted(primitive_usage.items(), key=lambda item: item[0]):
        print(name, count)
        
def create_connectivity_graph():
    global connectivity_graph
    connectivity_graph = sdn.create_connectivity_graph()
    
def create_sequential_graph():
    global sequential_graph
    sequential_graph = connectivity_graph.copy()
    nodes = list(sequential_graph.nodes)
    for node in nodes:
        if isinstance(node, sdn.VirtualInstance) and node.instance.definition['EDIF.identifier'].startswith("FD") is False:
            predecessors = list(sequential_graph.predecessors(node))
            successors = list(sequential_graph.successors(node))
            for predecessor in predecessors:
                for successor in successors:
                    sequential_graph.add_edge(predecessor, successor)
            sequential_graph.remove_node(node)
    print("Nodes in connectivity graph:", connectivity_graph.number_of_nodes())
    print("Nodes in sequential graph:", sequential_graph.number_of_nodes())
    
def fold_feedback():
    global feedback_hierarchy
    feedback_hierarchy = set()
    # find all SCCs
    for scc in nx.strongly_connected_components(sequential_graph):
        if scc_has_feedback(scc) is False:
            feedback_hierarchy |= scc
            continue
        print("Found SCC with feedback", len(scc))
        feedback_finder = FeedbackFinder.from_graph_and_subset(sequential_graph, scc)
        scc_hierarchy = feedback_finder.find()
        feedback_hierarchy.add(scc_hierarchy)
    print(feedback_hierarchy)
        
def scc_has_feedback(scc):
    return len(scc) > 1 or all(x in sequential_graph.successors(x) for x in scc)
    
    
class FeedbackFinder:
    @staticmethod
    def from_graph_and_subset(graph, subset):
        feedback_finder = FeedbackFinder()
        feedback_finder.graph = graph.subgraph(subset).copy()
        return feedback_finder
    
    def __init__(self):
        self.graph = None
        self.return_distances_to_nodes = None
        self.nodes_to_return_distance = None
        
    def find(self):
        print("Find")
        self.find_return_distances()
        new_node = None
        while self.return_distances_to_nodes:
            min_return_distance = min(self.return_distances_to_nodes)
            nodes_with_min_return_distance = self.return_distances_to_nodes[min_return_distance]
            print("Return Distance:", min_return_distance, "Count:", len(nodes_with_min_return_distance))
            for node in nodes_with_min_return_distance:
                del self.nodes_to_return_distance[node]
            del self.return_distances_to_nodes[min_return_distance]
            if min_return_distance == 1:
                nodes_to_update = list()
                for node in nodes_with_min_return_distance:
                    new_node = self.collapse_group([node])
                    nodes_to_update.append(new_node)
                self.update_return_distances(nodes_to_update)
            else:
                subgraph = self.graph.subgraph(nodes_with_min_return_distance)
                sccs = list(nx.strongly_connected_components(subgraph))
                nodes_to_update = list()
                for scc in sccs:
                    assert len(scc) > 1
                    new_node = self.collapse_group(scc)
                    nodes_to_update.append(new_node)
                self.update_return_distances(nodes_to_update)
            print("node count:", self.graph.number_of_nodes())
        assert new_node
        return new_node
        
    def find_return_distances(self):
        self.return_distances_to_nodes = dict()
        self.nodes_to_return_distance = dict()
        count = 0
        for node in self.graph.nodes:
            count += 1
            return_distance = self.find_return_distance(node)
            self.nodes_to_return_distance[node] = return_distance
            if return_distance not in self.return_distances_to_nodes:
                self.return_distances_to_nodes[return_distance] = set()
            self.return_distances_to_nodes[return_distance].add(node)
            if count == 100:
                print(".", end="")
                count = 0
    
    def find_return_distance(self, node):
        found = set(self.graph.successors(node))
        search_queue = deque()
        search_queue += map(lambda x: (x,1), found)
        while search_queue:
            current_node, depth = search_queue.popleft()
            if current_node is node:
                return depth
            else:
                for successor in self.graph.successors(current_node):
                    if successor not in found:
                        found.add(successor)
                        search_queue.append((successor, depth+1))
        return -1
        
    def collapse_group(self, nodes):
        new_node = frozenset(nodes)
        predecessors = set()
        successors = set()
        for node in new_node:
            for predecessor in self.graph.predecessors(node):
                if predecessor not in new_node:
                    predecessors.add(predecessor)
            for successor in self.graph.successors(node):
                if successor not in new_node:
                    successors.add(successor)
        for predecessor in predecessors:
            self.graph.add_edge(predecessor, new_node)
        for successor in successors:
            self.graph.add_edge(new_node, successor)
        self.graph.remove_nodes_from(new_node)
        self.graph.add_node(new_node)
        return new_node
        
    def update_return_distances(self, nodes):
        for node in nodes:
            self.update_return_distance(node)
            
    def update_return_distance(self, node):
        # find return distance and nodes within that distance of the node
        return_distance = self.find_return_distance(node)
        if return_distance > 0:
            # find nodes along a path with minimal distance to node
            within_return_distance = self.get_nodes_within_return_distance(node, return_distance)
            # update return distance if it does not exist or is larger than the found return_distance
            # original_node = node
            for node in within_return_distance:
                #print(" ", node, self.nodes_to_return_distance.get(node, None))
                #assert nx.shortest_path_length(self.graph, node, original_node) < return_distance, f"{node} is not within return distance of {original_node}"
                if node not in self.nodes_to_return_distance:
                    self.nodes_to_return_distance[node] = return_distance
                    if return_distance not in self.return_distances_to_nodes:
                        self.return_distances_to_nodes[return_distance] = set()
                    self.return_distances_to_nodes[return_distance].add(node)
                else:
                    node_return_distance = self.nodes_to_return_distance[node]
                    if node_return_distance > return_distance:
                        self.return_distances_to_nodes[node_return_distance].remove(node)
                        if len(self.return_distances_to_nodes[node_return_distance]) == 0:
                            del self.return_distances_to_nodes[node_return_distance]
                        self.nodes_to_return_distance[node] = return_distance
                        if return_distance not in self.return_distances_to_nodes:
                            self.return_distances_to_nodes[return_distance] = set()
                        self.return_distances_to_nodes[return_distance].add(node)
    
    def get_nodes_within_return_distance(self, node, return_distance):
        result = {node}
        found = self.get_nearby_successors(node, return_distance)
        search_stack = list(x for x in self.graph.predecessors(node) if x in found)
        while search_stack:
            item = search_stack.pop()
            if item not in result:
                result.add(item)
                for predecssor in self.graph.predecessors(item):
                    if predecssor in found and found[predecssor] < found[item]:
                        search_stack.append(predecssor)
        return result
    
    def get_nearby_successors(self, node, depth):
        return self.surround(node, depth, self.graph.successors)

    def get_nearby_predecessors(self, node, depth):
        return self.surround(node, depth, self.graph.successors)

    @staticmethod
    def surround(node, depth, adj_func):
        found_nodes = {node:0}
        search_queue = deque()
        search_queue.append((node, 0))
        while search_queue:
            cur_node, cur_depth = search_queue.popleft()
            if cur_depth < depth - 1:
                for successor in adj_func(cur_node):
                    if successor not in found_nodes:
                        found_nodes[successor] = cur_depth + 1
                        search_queue.append((successor, cur_depth + 1))
        return found_nodes
                        
def export_sequential_graph_dot(exclude_ports=True):
    global feedback_hierarchy
    global sequential_graph
    if not feedback_hierarchy:
        feedback_hierarchy = set(sequential_graph.nodes())
    if exclude_ports:
        sequential_graph = sequential_graph.subgraph(x for x in sequential_graph.nodes if isinstance(x,sdn.VirtualInstance))
    nodeToIndex = dict()
    for index,node in enumerate(sequential_graph.nodes):
        nodeToIndex[node] = index
    subgraph_index = 0
    with open("sequential_graph.dot",'w') as fi:
        fi.write("digraph {\n")
        fi.write("  rankdir=LR;\n")
        if not exclude_ports:
            fi.write("  subgraph cluster_{}{{\n".format(subgraph_index))
            subgraph_index += 1
            fi.write('    label="INPUT PORTS";\n')
            for node in [x for x in sequential_graph.nodes if isinstance(x, sdn.VirtualPort) and x.port.direction == sdn.IN]:
                label = "{}".format(node.get_name())
                fi.write('  {}[label="{}"];\n'.format(nodeToIndex[node],label))
            fi.write("  }\n")
        subgraph_index = gen_cluster_hierarchy(fi, feedback_hierarchy, nodeToIndex, cluster_index=subgraph_index)
        subgraph_index += 1
        if not exclude_ports:
            fi.write("  subgraph cluster_{}{{\n".format(subgraph_index))
            subgraph_index += 1
            fi.write('    label="OUTPUT PORTS";\n')
            for node in [x for x in sequential_graph.nodes if isinstance(x, sdn.VirtualPort) and x.port.direction == sdn.OUT]:
                label = "{}".format(node.get_name())
                fi.write('  {}[label="{}"];\n'.format(nodeToIndex[node],label))
            fi.write("  }\n")
        for node in [x for x in sequential_graph.nodes if not isinstance(x, sdn.VirtualPort) or x.port['EDIF.identifier'] not in ["clock", "reset"]]:
            for successor in sequential_graph.successors(node):
                fi.write('  {} -> {};\n'.format(nodeToIndex[node], nodeToIndex[successor]))
        fi.write("}\n")
        
def gen_cluster_hierarchy(fi, nodes, nodeToIndex, prefix = "  ", cluster_index = 0):
    fi.write("{}subgraph cluster_{}{{\n".format(prefix, cluster_index))
    fi.write('    label="FEEDBACK_GROUP";\n')
    for node in sorted((x for x in nodes if not isinstance(x,sdn.VirtualPort)), key= lambda y: len(y) if isinstance(y, frozenset) else 0, reverse=True):
        if isinstance(node, frozenset):
            cluster_index += 1
            cluster_index = gen_cluster_hierarchy(fi, node, nodeToIndex, prefix = "  " + prefix, cluster_index= cluster_index)
        else:
            fi.write('{}  {}[label="{}"];\n'.format(prefix,nodeToIndex[node],node.get_name()))
    fi.write(prefix + "}\n")
    return cluster_index

run()