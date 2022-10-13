import networkx as nx
from collections import deque

import re

def fold_feedback(connectivity_graph):
    '''
    Analyzes tight feedback in a design.

    :param connectivity_graph:
    '''
    sccs = list(sorted(nx.strongly_connected_components(connectivity_graph), key=len))
    scc_count = len(sccs)
    print("There are {} SCC nodes".format(scc_count))
    working_graph = connectivity_graph.copy()
    feedback_hierarchy = set()
    distances = dict()
    for scc in sccs:
        if len(scc) == 1:
            is_selfloop = all(working_graph.successors(x) in scc for x in scc)
            if is_selfloop:
                print("{} SCC is selfloop".format(scc_count))
                new_node = _collapse(scc, working_graph)
                distances[new_node] = 1
            else:
                print("{} SCC is feedforward".format(scc_count))
                new_node = next(iter(scc))
        else:
            print("{} SCC is multi-node".format(scc_count))
            new_node = _further_fold_scc(scc, working_graph, distances)
        feedback_hierarchy.add(new_node)
        scc_count -= 1
    return frozenset(feedback_hierarchy), distances, working_graph


def _further_fold_scc(scc, working_graph, distances):
    while len(scc) > 1:
        print("{} nodes remain".format(len(scc)))
        scc_subgraph = working_graph.subgraph(scc)
        shortest_distance = 1
        candidates = list()
        while not candidates:
            shortest_distance *= 2
            for member in scc:
                distance = _find_distance(member, scc_subgraph, shortest_distance)
                if distance:
                    if distance < shortest_distance:
                        shortest_distance = distance
                        candidates = [member]
                    elif distance == shortest_distance:
                        candidates.append(member)
        if len(scc) > len(candidates):  # subsccs are a subset of the scc
            sub_sccs = list(nx.strongly_connected_components(scc_subgraph.subgraph(candidates)))
            for subscc in sub_sccs:
                if len(subscc) >= shortest_distance:
                    new_node = _collapse(subscc, working_graph)
                    distances[new_node] = shortest_distance
                    scc.add(new_node)
        else:
            new_node = _collapse(scc, working_graph)
            distances[new_node] = shortest_distance
            scc.add(new_node)
        for candidate in candidates:
            scc.remove(candidate)
    return next(iter(scc))


def _find_distance(member, working_graph, shortest_distance):
    found = set()
    search_queue = deque()
    search_queue.append((member, 0))
    while search_queue:
        search_member, distance = search_queue.popleft()
        if not shortest_distance or distance < shortest_distance:
            for successor in working_graph.successors(search_member):
                if successor is member:
                    return distance + 1
                elif successor not in found:
                    found.add(successor)
                    search_queue.append((successor, distance + 1))


def _collapse(scc, working_graph):
    new_node = frozenset(scc)
    predecessors = set()
    successors = set()

    for member in scc:
        for predecessor in working_graph.predecessors(member):
            if predecessor not in scc:
                predecessors.add(predecessor)
        for successor in working_graph.successors(member):
            if successor not in scc:
                successors.add(successor)

    working_graph.remove_nodes_from(scc)

    for predecessor in predecessors:
        working_graph.add_edge(predecessor, new_node)
    for successor in successors:
        working_graph.add_edge(new_node, successor)

    return new_node

def export_folded_feedback(folded_feedback, filename):
    node_counts = dict()
    sub_levels = dict()
    search_stack = list()
    search_stack.append((folded_feedback, False))
    while search_stack:
        item, visited = search_stack.pop()
        if isinstance(item, frozenset):
            if not visited:
                search_stack.append((item, True))
                search_stack += ((x, False) for x in item)
            else:
                count = 0
                sub_level = 0
                for subitem in item:
                    if isinstance(subitem, frozenset):
                        count += node_counts[subitem]
                        sub_level = max(sub_levels[subitem], sub_level)
                    else:
                        count += 1
                node_counts[item] = count
                sub_levels[item] = sub_level + 1

    with open(filename, 'w') as fi:
        search_stack = list()
        search_stack.append((folded_feedback, False))
        level = 0
        while search_stack:
            item, visited = search_stack.pop()
            if isinstance(item, frozenset):
                if not visited:
                    fi.write("{} FeedbackGroup {} {}\n".format(level, sub_levels[item], node_counts[item]))
                    level += 1
                    search_stack.append((item, True))
                    search_stack += ((y, False) for y in sorted(item, key=lambda x: (node_counts[x] if
                                                                                     isinstance(x, frozenset) else -1,
                                                                                     x.name if not
                                                                                     isinstance(x, frozenset) else '')))
                else:
                    level -= 1
            else:
                fi.write("{} {}\n".format(level, item))

def import_folded_feedback(leaf_cells, filename):
    name_lookup = dict()
    for leaf_cell in leaf_cells:
        name_lookup[leaf_cell.name] = leaf_cell

    feedback_stack = list()
    level = -1
    with open(filename) as fi:
        for line in fi:
            match = re.match(r"(\d+) FeedbackGroup (\d+) (\d+)", line)
            if match:
                current_level = int(match.group(1))
                if current_level > level:
                    new_feedback_group = list()
                    feedback_stack.append(new_feedback_group)
                    level = current_level
                else:
                    while current_level <= level:
                        feedback_group = feedback_stack.pop()
                        feedback_group = frozenset(feedback_group)
                        feedback_stack[-1].append(feedback_group)
                        level -= 1
                    level = current_level
                    new_feedback_group = list()
                    feedback_stack.append(new_feedback_group)
            else:
                match = re.match(r"(\d+) (\S+)", line)
                if match:
                    current_level = int(match.group(1))
                    name = match.group(2)
                    leaf_cell = name_lookup[name]
                    if current_level > level:
                        feedback_stack[-1].append(leaf_cell)
                    else:
                        while current_level <= level:
                            feedback_group = feedback_stack.pop()
                            feedback_group = frozenset(feedback_group)
                            feedback_stack[-1].append(feedback_group)
                            level -= 1
                        feedback_stack[-1].append(leaf_cell)
    folded_feedback = feedback_stack.pop()
    folded_feedback = frozenset(folded_feedback)
    return folded_feedback


