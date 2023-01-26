"""
SpyDrNet Example Original
--------------------------
"""
import networkx as nx
import spydrnet as sdn
import csv
import os
from collections import deque
from itertools import chain
import copy

blackboxes = {
    'gmii_mac_top_HD31',
    'gmii_mac_top 1'
}

exclude_primitives = {
    'BUFG',
    'BUFGCTRL',
    'BUFIO',
    'BUFR',
    'OBUF',
    'ODDR',
    'MMCME2_ADV',
    'IBUF',
    'IBUFDS',
    'IDDR',
    'IDELAYCTRL',
    'IDELAYE2',
    'IOBUF',
    'BSCANE2',
    
    'BUFH',
    'BUFMR',
    'FRAME_ECCE2',
    'GTHE2_CHANNEL',
    'GTHE2_COMMON',
    'IBUF',
    'IBUFDS',
    'IBUFDS_DIFF_OUT',
    'IBUFDS_GTE2',
    'ICAPE2',
    'ISERDESE2',
    'OBUFDS',
    'ODELAYE2',
    'OSERDESE2',
    'PCIE_3_0',
    'PLLE2_ADV',
    'STARTUPE2'
}

power_primives = {
    'VCC',
    'GND'
}

combinational_primitives = {
    'LUT1',
    'LUT2',
    'LUT3',
    'LUT4',
    'LUT5',
    'LUT6',
    'LUT6_2',
    'MUXF7',
    'MUXF8',
    'AND2B1L',
    'CARRY4'
}

sequential_primitives = {
    'FDCE': ['C'],
    'FDPE': ['C'],
    'FDRE': ['C'],
    'FDSE': ['C'],
    'RAM32M': ['WCLK'],
    'RAM32X1S': ['WCLK'],
    'RAMB18E1': ["CLKARDCLK", "CLKBWRCLK"],
    'RAMB36E1': ["CLKARDCLK", "CLKBWRCLK"],
    'SRL16E': ["CLK"],
    'SRLC16E': ["CLK"],

    'DSP48E1': ['CLK'],
    'FDCE': ['C'],
    'FDPE': ['C'],
    'FDRE': ['C'],
    'FDSE': ['C'],
    'FIFO18E1': ['RDCLK', 'WRCLK'],
    'FIFO36E1': ['RDCLK', 'WRCLK'],
    'RAM128X1D': ['WCLK'],
    'RAM128X1S': ['WCLK'],
    'RAM16X4S': ['WCLK'],
    'RAM32M': ['WCLK'],
    'RAM32X1D': ['WCLK'],
    'RAM32X1S': ['WCLK'],
    'RAM64M': ['WCLK'],
    'RAM64X1D': ['WCLK'],
    'RAM64X1S': ['WCLK'],
    'SRL16E': ['CLK'],
    'SRLC32E': ['CLK']
}

lut_sensitivity = None
sensitive_lut_names = None
sensitive_luts = None
connectivity_graph = None
sequential_graph = None
feedback_hierarchy = None

nodes_to_replicate = None
nodes_to_vote_on = None

def run():
    print("Welcome")
    parse_lut_sensitivities()
    parse_netlist()
    find_sensitive_luts()
    inclusion_report()
    primitive_usage_report()
    generate_sequential_graph()
    fold_feedback()
    print_fold_hierarchy()
    #select_target_nodes()
    #determine_voters()
    #apply_tmr()
    #export_sequential_graph_dot(sequential_graph, feedback_hierarchy)
    
def parse_lut_sensitivities():
    global lut_sensitivity
    lut_sensitivity = dict()
    filename = 'sensitivity_data/overall_classification.csv'
    if os.path.isfile(filename):
        with open(filename) as fi:
            reader = csv.reader(fi)
            for row in reader:
                lut_sensitivity[row[0]] = int(row[1])
            
def parse_netlist():
    global connectivity_graph
    sdn.parse("vivado_no_ptmr_2012.09syn_orig_withSEMIP.edf")#("reference_switch-baseline-pblock-20180511.edf")#("b13.edf")#
    connectivity_graph = sdn.create_connectivity_graph()

def find_sensitive_luts():
    global sensitive_lut_names
    global sensitive_luts
    sensitive_lut_names = list(name for name, value in lut_sensitivity.items() if value > 0)
    sensitive_luts = list(sdn.get_virtual_instances(sensitive_lut_names))
    
def inclusion_report():
    len_total = len(sensitive_lut_names)
    len_included = len(sensitive_luts)
    if len_total > 0:
        print("There are {} sensitive luts identified through fault injection.".format(len_total))
        print("There are {} included in the netlist ({:.02f}%).".format(len_included, len_included/len_total*100))
    
def primitive_usage_report():
    prim_library = sdn.current_netlist().get_library('hdi_primitives')
    for definition in sorted(prim_library.definitions, key=lambda x: x['EDIF.identifier']):
        print("{} {}".format(definition['EDIF.identifier'], len(definition.virtual_instances)))
    for library in (x for x in sdn.current_netlist().libraries if x['EDIF.identifier'] != 'hdi_primitives'):
        for definition in (x for x in library.definitions if x.is_leaf()):
            print("{} {}".format(definition['EDIF.identifier'], len(definition.virtual_instances)))
        
def generate_sequential_graph():
    global sequential_graph
    sequential_graph = connectivity_graph.copy()
    nodes = list(sequential_graph.nodes)
    for node in nodes:
        if isinstance(node, sdn.VirtualInstance) and node.instance.definition['EDIF.identifier'] not in sequential_primitives:
            for predecessor in sequential_graph.predecessors(node):
                for successor in sequential_graph.successors(node):
                    sequential_graph.add_edge(predecessor, successor)
            sequential_graph.remove_node(node)
       
def fold_feedback():
    global feedback_hierarchy
    if os.path.isfile('feedback_hierarchy_report.txt'):
        sets_stack = [set()]
        quick_name_lookup = dict()
        for vi in sdn.get_virtual_instances(hierarchical=True):
            quick_name_lookup[vi.get_hierarchical_name()] = vi
        with open('feedback_hierarchy_report.txt') as fi:
            cur_level = 0
            for line_number, line in enumerate(fi,1):
                parts = line.strip().split(' ')
                level = int(parts[0])
                name = parts[1]
                while level < cur_level:
                    top_set = sets_stack.pop()
                    sets_stack[-1].add(frozenset(top_set))
                    cur_level -= 1
                if name == "Feedback_node":
                    cur_level += 1
                    sets_stack.append(set())
                else:
                    vi = quick_name_lookup[name]
                    sets_stack[-1].add(vi)
            top_set = sets_stack.pop()
            feedback_hierarchy = frozenset(top_set)
    else:
        feedback_hierarchy = _fold_feedback()


def _fold_feedback():
    folded_graph = sequential_graph.copy()
    for scc in sorted(nx.strongly_connected_components(sequential_graph), key=len, reverse=True):
        if len(scc) == 1 and not any(ss in sequential_graph.successors(ss) for ss in scc):
            print("Feed forward node")
            continue
        print("Found SCC size {}.".format(len(scc)))
        
        #Handle self loops
        selfloop_nodes = list(x for x in scc if x in sequential_graph.successors(x))
        number_of_selfloop_nodes = 0
        for node in selfloop_nodes:
            number_of_selfloop_nodes += 1
            group = frozenset((node,))
            successors = list(x for x in folded_graph.successors(node) if x is not node)
            predecessors = list(x for x in folded_graph.predecessors(node) if x is not node)
            for successor in successors:
                folded_graph.add_edge(group, successor)
            for predecessor in predecessors:
                folded_graph.add_edge(predecessor, group)
            folded_graph.remove_node(node)
            scc.remove(node)
            scc.add(group)
        print("SCC has {} nodes with selfloops.".format(number_of_selfloop_nodes))
        
        while len(scc) > 1:
            #find nodes with minimum return distance
            minimum_return_distances = dict()
            min_return_distance = 2
            still_looking = True
            while still_looking:
                for node in scc:
                    # find minimum return distance
                    found_nodes = {node}
                    search_queue = deque()
                    search_queue.append((node,0))
                    while search_queue:
                        item, depth = search_queue.popleft()
                        if depth < min_return_distance:
                            next_depth = depth + 1
                            for successor in folded_graph.successors(item):
                                if successor is node:
                                    still_looking = False
                                    min_return_distance = next_depth
                                    minimum_return_distances[node] = next_depth
                                else:
                                    search_queue.append((successor,next_depth))
                if still_looking:
                    min_return_distance *= 2
            print("Minimum return distance {}.".format(min_return_distance))
            nodes_of_return_distance = set(node for node, distance in minimum_return_distances.items() if distance == min_return_distance)
            print("There are {} nodes with this return distance, {} total.".format(len(nodes_of_return_distance), folded_graph.number_of_nodes()))
            
            # find tightfeedback groups
            node_to_set = dict()
            search_set = set(nodes_of_return_distance)
            while search_set:
                node = search_set.pop()
                nearby = surround(folded_graph, node, min_return_distance-1)
                filtered = list(x for x in nearby if x in nodes_of_return_distance)
                print("This many nearby nodes {}.".format(len(filtered)))
                containing_scc = next(nx.strongly_connected_components(folded_graph.subgraph(filtered)))
                search_set -= containing_scc
                node_set = set()
                for scc_node in containing_scc:
                    if scc_node in node_to_set:
                        node_set |= node_to_set[scc_node]
                    else:
                        node_set.add(scc_node)
                for node_set_node in node_set:
                    node_to_set[node_set_node] = node_set
            print("Nodes after set sort {}.".format(len(node_to_set)))
            
            groups = list()
            group_ids = set()
            for group in node_to_set.values():
                group_id = id(group)
                if group_id not in group_ids:
                    group_ids.add(group_id)
                    groups.append(frozenset(group))
            print("There are {} groups.".format(len(groups)))
            
            for group in groups:
                scc -= group
                scc.add(group)
                predecessors = set()
                successors = set()
                for node in group:
                    for predecessor in folded_graph.predecessors(node):
                        if predecessor not in group:
                            predecessors.add(predecessor)
                    for successor in folded_graph.successors(node):
                        if successor not in group:
                            successors.add(successor)
                assert (len(successors) + len(predecessors)) > 0
                for predecessor in predecessors:
                    folded_graph.add_edge(predecessor, group)
                for successor in successors:
                    folded_graph.add_edge(group, successor)
                folded_graph.remove_nodes_from(group)
    print("final number of nodes {}.".format(folded_graph.number_of_nodes()))
    return frozenset(folded_graph.nodes)
    
from collections import deque
def surround(graph, node, depth):
    found_nodes = {node}
    search_queue = deque()
    search_queue.append((node, 0))
    while search_queue:
        cur_node, cur_depth = search_queue.popleft()
        if cur_depth < depth:
            for successor in graph.successors(cur_node):
                if successor not in found_nodes:
                    found_nodes.add(successor)
                    search_queue.append((successor, cur_depth + 1))
    return found_nodes

def print_fold_hierarchy():
    #print_fold_hierarchy_recursive(feedback_hierarchy.nodes)
    print_fold_hierarchy_non_recursive(feedback_hierarchy)

def print_fold_hierarchy_recursive(nodes, prefix = 0):
    for node in sorted((x for x in nodes if not isinstance(x,sdn.VirtualPort)), key= lambda y: len(y) if isinstance(y, frozenset) else 0, reverse=True):
        if isinstance(node, frozenset):
            print("{} Feedback_node".format(prefix))
            print_fold_hierarchy_recursive(node, prefix = prefix + 1)
        else:
            print(str(prefix) + " " + node.get_hierarchical_name())

def print_fold_hierarchy_non_recursive(nodes):
    with open("feedback_hierarchy_report.txt", 'w') as fi:
        depths = dict()
        depth = 0
        found_nodes = set(nodes)
        search_stack = list(map(lambda node: (node, 0), sorted((x for x in found_nodes if not isinstance(x,sdn.VirtualPort)), key=lambda y: len(y) if isinstance(y, frozenset) else 0)))
        while search_stack:
            node, level = search_stack.pop()
            if isinstance(node, frozenset):
                fi.write("{} Feedback_node\n".format(level))
                for subnode in sorted((x for x in node if not isinstance(x,sdn.VirtualPort)), key=lambda y: len(y) if isinstance(y, frozenset) else 0):
                    search_stack.append((subnode, level+1))
            else:
                fi.write("{} {}\n".format(level, node.get_hierarchical_name()))

def select_target_nodes():
    global nodes_to_replicate
    cm, crm, parents = sort_combinational_members()
    luts_in_feedback = list(x for x in sensitive_luts if x in crm)
    print("Sensitive luts in feedback {} of {} known sensitive_luts".format(len(luts_in_feedback), len(sensitive_luts)))
    fbgs_with_sensitive_luts = set()
    for lut in luts_in_feedback:
        fbgs_with_sensitive_luts |= crm[lut]
    print("There are {} feedback groups that contain sensitive luts.".format(len(fbgs_with_sensitive_luts)))
    selfcontained = set(x for x in fbgs_with_sensitive_luts if all(not isinstance(y, frozenset) for y in x))
    print("There are {} self contained feedback groups (meaning they themselves do not contain more feedback groups).".format(len(selfcontained)))
    selfcontained_nodes = set()
    for s in selfcontained:
        selfcontained_nodes |= s
    drive = nodes_that_drive_nodes(connectivity_graph, selfcontained_nodes)
    driven = nodes_driven_by_nodes(connectivity_graph, selfcontained_nodes)
    combinational_nodes = drive & driven
    print("Selected {} sequential_nodes and {} combinational_nodes.".format(len(selfcontained_nodes), len(combinational_nodes)))
    #extend selection to include all carry_chain members:
    carry_chain_nodes = set(x for x in combinational_nodes if x.instance.definition['EDIF.identifier'] == "CARRY4")
    print("Carry chain nodes before extension {}.".format(len(carry_chain_nodes)))
    search_stack = list(carry_chain_nodes)
    others = set()
    while search_stack:
        top_node = search_stack.pop()
        for adjacent in chain(connectivity_graph.predecessors(top_node), connectivity_graph.successors(top_node)):
            if isinstance(adjacent, sdn.VirtualInstance):
                def_name = adjacent.instance.definition['EDIF.identifier']
                if def_name == "CARRY4":
                    if adjacent not in carry_chain_nodes:
                        carry_chain_nodes.add(adjacent)
                        search_stack.append(adjacent)
                elif def_name in (sequential_primitives | combinational_primitives):
                    others.add(adjacent)
    print("Carry chain nodes after extension {}.".format(len(carry_chain_nodes)))
    combinational_nodes |= carry_chain_nodes
    overall = selfcontained_nodes | combinational_nodes | others
    drive = nodes_that_drive_nodes(connectivity_graph, overall)
    driven = nodes_driven_by_nodes(connectivity_graph, overall)
    overall |= drive & driven
    print("Overall selection {} nodes.".format(len(overall)))
    nodes_to_replicate = overall
    
def expand_carry_chain_selection(selection):
    carry_chain_nodes = set(x for x in selection if x.instance.definition['EDIF.identifier'] == "CARRY4")
    print("Carry chain nodes before extension {}.".format(len(carry_chain_nodes)))
    search_stack = list(carry_chain_nodes)
    others = set()
    while search_stack:
        top_node = search_stack.pop()
        for adjacent in chain(connectivity_graph.predecessors(top_node), connectivity_graph.successors(top_node)):
            if isinstance(adjacent, sdn.VirtualInstance):
                def_name = adjacent.instance.definition['EDIF.identifier']
                if def_name == "CARRY4":
                    if adjacent not in carry_chain_nodes:
                        carry_chain_nodes.add(adjacent)
                        search_stack.append(adjacent)
                elif def_name in (sequential_primitives | combinational_primitives):
                    others.add(adjacent)
    print("Carry chain nodes after extension {}.".format(len(carry_chain_nodes)))
    return (carry_chain_nodes | others)
    
def determine_voters_backup():
    global nodes_to_vote_on
    complete = set()
    partial = set()
    search_stack = list(nodes_to_replicate)
    while search_stack:
        top_node = search_stack.pop()
        check = list(x not in nodes_to_replicate for x in connectivity_graph.successors(top_node))
        if all(check):
            complete.add(top_node)
        elif any(check):
            partial.add(top_node)
    print("Reduction Voters needed complete {} partial {}.".format(len(complete), len(partial)))
    nodes_to_vote_on = complete | partial
    subgraph = connectivity_graph.subgraph(nodes_to_replicate).copy()
    subgraph.remove_nodes_from(complete)
    subgraph.remove_nodes_from(partial)
    containing_feedback_nodes = dict()
    search_stack = list(feedback_hierarchy)
    while search_stack:
        top_node = search_stack.pop()
        if isinstance(top_node, frozenset):
            for node in top_node:
                if isinstance(node, frozenset):
                    search_stack.append(node)
                else:
                    containing_feedback_nodes[node] = top_node
    looking_for_feedback = True
    is_first_cut = True
    while looking_for_feedback:
        found_scc = False
        sequential_elements_in_sccs = set()
        for scc in (x for x in nx.strongly_connected_components(subgraph) if len(x) > 1 or any(xx in subgraph.successors(xx) for xx in x)):
            found_scc = True
            sequential_elements_in_sccs |= set(x for x in scc if x.instance.definition['EDIF.identifier'] in sequential_primitives)
        print("sequential Nodes {}.".format(len(sequential_elements_in_sccs)))
        looking_for_feedback = found_scc
        
        if is_first_cut:
            is_first_cut = False
            tightfeedback = set(x for x in sequential_elements_in_sccs if len(containing_feedback_nodes[x]) == 1)
            print("this many nodes in tightfeedback {}.".format(len(tightfeedback)))
            subgraph.remove_nodes_from(tightfeedback)
            nodes_to_vote_on |= tightfeedback
        elif found_scc:
            assert False, "Unable to break up feedback using simple tightfeedback approach."
    print("If triplicate voter placed on output, then the graph having feedback = {}.".format(looking_for_feedback))
   
def determine_voters():
    global nodes_to_vote_on
    complete = set()
    partial = set()
    search_stack = list(nodes_to_replicate)
    while search_stack:
        top_node = search_stack.pop()
        check = list(x not in nodes_to_replicate for x in connectivity_graph.successors(top_node))
        if all(check):
            complete.add(top_node)
        elif any(check):
            partial.add(top_node)
    print("Reduction Voters needed complete {} partial {}.".format(len(complete), len(partial)))
    nodes_to_vote_on = complete | partial
    subgraph = connectivity_graph.subgraph(nodes_to_replicate).copy()
    subgraph.remove_nodes_from(complete)
    subgraph.remove_nodes_from(partial)
    looking_for_feedback = True
    is_first_cut = True
    while looking_for_feedback:
        found_scc = False
        sequential_elements_in_sccs = set()
        for scc in (x for x in nx.strongly_connected_components(subgraph) if len(x) > 1 or any(xx in subgraph.successors(xx) for xx in x)):
            found_scc = True
            sequential_elements_in_sccs |= set(x for x in scc if x.instance.definition['EDIF.identifier'].startswith("FD"))
        print("sequential Nodes {}.".format(len(sequential_elements_in_sccs)))
        looking_for_feedback = found_scc
        if sequential_elements_in_sccs:
            highest_fanout = max(sequential_elements_in_sccs, key=lambda x: connectivity_graph.out_degree(x))
            nodes_to_vote_on.add(highest_fanout)
            subgraph.remove_node(highest_fanout)
        #if is_first_cut:
        #    is_first_cut = False
        #    tightfeedback = set(x for x in sequential_elements_in_sccs if x in nodes_with_selfloops)
        #    print("this many nodes in tightfeedback {}.".format(len(tightfeedback)))
        #    subgraph.remove_nodes_from(tightfeedback)
        #    nodes_to_vote_on |= tightfeedback
        #elif found_scc:
        #    assert False, "Unable to break up feedback using simple tightfeedback approach."
    print("If triplicate voter placed on output, then the graph having feedback = {}.".format(looking_for_feedback))   

def sort_combinational_members():
    parents = dict()
    combinational_mapping = dict()
    frozenset_mappings = dict()
    frozenset_count = 0
    found_nodes = set()
    search_stack = list()
    for node in feedback_hierarchy:
        found_nodes.add(node)
        search_stack.append((node,False))
    while search_stack:
        node, visited = search_stack.pop()
        if visited:
            if isinstance(node, frozenset):
                frozensets = set()
                from_frozen_sets = set()
                other = set()
                for subnode in node:
                    if isinstance(subnode, frozenset):
                        frozensets.add(subnode)
                        from_frozen_sets |= frozenset_mappings[subnode]
                    else:
                        other.add(subnode)
                all_nodes = other | from_frozen_sets
                drive = nodes_that_drive_nodes(connectivity_graph, all_nodes)
                driven = nodes_driven_by_nodes(connectivity_graph, all_nodes)
                both = drive & driven
                combinational = both - all_nodes
                all_nodes |= combinational
                for member in frozensets:
                    del frozenset_mappings[member]
                frozenset_mappings[node] = all_nodes
                combinational_mapping[node] = combinational
                print("Completed {} so far.".format(len(combinational_mapping)))
        else:
            search_stack.append((node,True))
            if isinstance(node, frozenset):
                for subnode in node:
                    if subnode not in found_nodes:
                        parents[subnode] = node
                        found_nodes.add(subnode)
                        search_stack.append((subnode, False))
        combinational_reverse_mapping = dict()
        for feedback_group, comb in combinational_mapping.items():
            for item in comb:
                if item not in combinational_reverse_mapping:
                    combinational_reverse_mapping[item] = set()
                combinational_reverse_mapping[item].add(feedback_group)
    return combinational_mapping, combinational_reverse_mapping, parents
    
def nodes_driven_by_nodes(graph, nodes):
    driven = set()
    for node in nodes:
        search_stack = [node]
        while search_stack:
            current_node = search_stack.pop()
            for next_node in graph.successors(current_node):
                if isinstance(next_node, sdn.VirtualInstance) and next_node not in driven and \
                    next_node.instance.definition['EDIF.identifier'] in combinational_primitives:
                    search_stack.append(next_node)
                    driven.add(next_node)
    return driven

def nodes_that_drive_nodes(graph, nodes):
    drive = set()
    for node in nodes:
        search_stack = [node]
        while search_stack:
            current_node = search_stack.pop()
            for next_node in graph.predecessors(current_node):
                if isinstance(next_node, sdn.VirtualInstance) and next_node not in drive and \
                    next_node.instance.definition['EDIF.identifier'] in combinational_primitives:
                    search_stack.append(next_node)
                    drive.add(next_node)
    return drive
                

def export_sequential_graph_dot(sequential_graph, folded_graph = None, exclude_ports=True):
    if not folded_graph:
        folded_graph = sequential_graph
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
        subgraph_index = gen_cluster_hierarchy(fi, folded_graph.nodes, nodeToIndex, cluster_index=subgraph_index)
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
    
def expand(group, open_feedback=False):
    seen = set()
    search_stack = [group]
    while search_stack:
        items = search_stack.pop()
        for item in items:
            if isinstance(item, frozenset):
                if item not in seen and open_feedback:
                    seen.add(item)
                    search_stack.append(item)
            else:
                yield item
            
def apply_tmr():
    triplicate_inst_map = triplicate_instances(nodes_to_replicate, uniquify_properties=["SOFT_LUTNM"])
    triplicate_port_map = triplicate_ports(based_on=nodes_to_replicate)
    triplicate_and_connect_cables(instances=triplicate_inst_map, ports=triplicate_port_map)
    insert_voters(on=nodes_to_vote_on, instances=triplicate_inst_map, ports=triplicate_port_map)
    
def triplicate_instances(nodes_to_triplicate, uniquify_properties=None):
    return replicate_instances(nodes_to_triplicate, suffix="_TMR_", count=3, uniquify_properties=uniquify_properties)
    
def replicate_instances(nodes_to_replicate, suffix="_COPY_", count=2, uniquify_properties=None):
    assert all(len(x.instance.parent_definition.virtual_instances) == 1 for x in nodes_to_replicate)
    for node in nodes_to_replicate:
        instance = node.instance
        parent_definition = instance.parent_definition
        new_instances = list()
        for ii in range(1,count):
            new_instance = sdn.Instance()
            new_instance.parent_definition = parent_definition
            for property in instance:
                new_instance[property] = copy.deepcopy(instance[property])
            # rename
            new_suffix = suffix + str(ii)
            if 'EDIF.identifier' in new_instance:
                new_instance['EDIF.identifier'] = new_instance['EDIF.identifier'] + new_suffix
            if 'EDIF.original_identifier' in new_instance:
                new_instance['EDIF.original_identifier'] = new_instance['EDIF.original_identifier'] + new_suffix
            print(new_instance['EDIF.identifier'])
            new_instances.append(new_instance)
            parent_definition.add_instance(new_instance)
        break
            
    
def triplicate_ports(based_on=None):
    return replicate_ports(based_on=based_on, suffix="_TMR_", count=3)
    
def replicate_ports(top_level_ports=None, based_on=None, suffix="_COPY_", count=2):
    driven_pins = set()
    drive_pins = set()
    if top_level_ports:
        for tlp in top_level_ports:
            if port.direction in {sdn.OUT, sdn.INOUT}:
                driven_pins |= set(port.virtualPins.values())
            if port.direction in {sdn.IN, sdn.INOUT}:
                drive_pins |= set(port.virtualPins.values())
    if based_on:
        for node in based_on:
            for port in node.virtualPorts.values():
                if port.direction in {sdn.IN, sdn.INOUT}:
                    driven_pins |= set(port.virtualPins.values())
                if port.direction in {sdn.OUT, sdn.INOUT}:
                    drive_pins |= set(port.virtualPins.values())
    drive_wires = set(sdn.get_virtual_wires(of=driven_pins, selection=sdn.ALL))
    driven_wires = set(sdn.get_virtual_wires(of=drive_pins, selection=sdn.ALL))
    common_wires = drive_wires | driven_wires
    print("This many wires need replicated {}.".format(len(common_wires)))
    virtual_pins = set()
    for wire in common_wires:
        virtual_pins |= set(wire.get_virtualPins())
    virtual_ports = set()
    for vpi in virtual_pins:
        vpo = vpi.virtualParent
        vi = vpo.virtualParent
        if not vi.is_leaf():
            virtual_ports.add(vpo)
        else:
            if vi.virtualParent is None:
                assert top_level_ports and vpo in top_level_ports
                virtual_ports.add(vpo)
    print("This many ports need replicated {}.".format(len(virtual_ports)))
    if top_level_ports:
        for tlp in top_level_ports:
            virtualPorts.add(tlp)
    for port in virtual_ports:
        if len(port.virtualParent.instance.definition.virtual_instances) > 1:
            assert False, "Parent_definition_of_ports_not_unique"
    
def triplicate_and_connect_cables(instances=None, ports=None):
    return replicate_and_connect_cables(instances=instances, ports=ports, suffix="_TMR_", count=3)
    
def replicate_and_connect_cables(instances=None, ports=None, suffix="_COPY_", count=2):
    pass
    
def insert_voters(on=None, instances=None, ports=None):
    pass

run()