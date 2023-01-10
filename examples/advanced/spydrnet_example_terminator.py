"""
SpyDrNet Example Terminator
---------------------------
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
    'FIFO18E1': ['RDCLK', 'WRCLK'],
    'FIFO36E1': ['RDCLK', 'WRCLK'],
    'RAM128X1D': ['WCLK'],
    'RAM128X1S': ['WCLK'],
    'RAM16X4S': ['WCLK'],
    'RAM32X1D': ['WCLK'],
    'RAM64M': ['WCLK'],
    'RAM64X1D': ['WCLK'],
    'RAM64X1S': ['WCLK'],
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
    identify_synchronizers()
    #fold_feedback()
    # print_fold_hierarchy()
    #select_target_nodes()
    # determine_voters()
    # apply_tmr()
    # compose_netlist()
    # export_sequential_graph_dot(sequential_graph, feedback_hierarchy)


def parse_lut_sensitivities():
    global lut_sensitivity
    lut_sensitivity = dict()
    #with open('sensitivity_data/overall_classification.csv') as fi:
    #    reader = csv.reader(fi)
    #    for row in reader:
    #        lut_sensitivity[row[0]] = int(row[1])


def parse_netlist():
    global connectivity_graph
    sdn.parse("g1_top_postroute_physopt.edf")  # ("b13.edf")#
    connectivity_graph = sdn.create_connectivity_graph()


def compose_netlist():
    sdn.compose_netlist("reference_switch-baseline-pblock-20180511-ptmr.edf")


def find_sensitive_luts():
    global sensitive_lut_names
    global sensitive_luts
    sensitive_lut_names = list(name for name, value in lut_sensitivity.items() if value > 0)
    sensitive_luts = list(sdn.get_virtual_instances(sensitive_lut_names))


def inclusion_report():
    len_total = len(sensitive_lut_names)
    len_included = len(sensitive_luts)
    print("There are {} sensitive luts identified through fault injection.".format(len_total))
    if len(len_included) > 0:
        print("There are {} included in the netlist ({:.02f}%).".format(len_included, len_included / len_total * 100))


def primitive_usage_report():
    prim_library = sdn.current_netlist().get_library('hdi_primitives')
    for definition in sorted(prim_library.definitions, key=lambda x: x['EDIF.identifier']):
        print("{} {}".format(definition['EDIF.identifier'], len(definition.virtual_instances)))
    for library in (x for x in sdn.current_netlist().libraries if x is not prim_library):
        for definition in library.definitions:
            if definition.is_leaf():
                print("{} {}".format(definition['EDIF.identifier'], len(definition.virtual_instances)))


def generate_sequential_graph():
    global sequential_graph
    sequential_graph = connectivity_graph.copy()
    nodes = list(sequential_graph.nodes)
    for node in nodes:
        if isinstance(node, sdn.VirtualInstance):
            type = node.instance.definition['EDIF.identifier']
            if type not in sequential_primitives and type not in blackboxes:
                for predecessor in sequential_graph.predecessors(node):
                    for successor in sequential_graph.successors(node):
                        sequential_graph.add_edge(predecessor, successor)
                sequential_graph.remove_node(node)


def identify_synchronizers():
    global sequential_graph
    global no_clock
    global multi_clock
    global blackbox_instances
    global other_instances
    global cdc_instances
    global synchronizers
    identified = set()
    for count, node in enumerate(x for x in sequential_graph.nodes if isinstance(x, sdn.VirtualInstance)):
        definition = node.instance.definition
        type = definition['EDIF.identifier']
        if type in blackboxes:
            continue
        clk_pins = sequential_primitives[type]
        for clk_pin in clk_pins:
            id_port = definition.get_port(clk_pin)
            id_pin = id_port.get_pin(0)
            id_virtualPort = node.virtualPorts[id_port]
            id_virtualPin = id_virtualPort.virtualPins[id_pin]
            if id_virtualPin in identified:
                continue
            driver, driven = get_driver_and_driven_virtual_instances(id_virtualPin, identified)
            print("{} {}".format(driver is not None, len(driven)))
            if not driver:
                print("No drivers found")
            else:
                for d in driven:
                    if 'clocks' not in sequential_graph.nodes[d]:
                        sequential_graph.nodes[d]['clocks'] = set()
                    sequential_graph.nodes[d]['clocks'].add(driver)
    print("clock_id complete")
    instances = set(x for x in sequential_graph.nodes
                    if isinstance(x, sdn.VirtualInstance))
    blackbox_instances = set(x for x in instances if x.instance['EDIF.identifier'] in blackboxes)
    multi_clock = set(x for x in instances - blackboxes if 'clocks' in sequential_graph.nodes[x] and
                      len(sequential_graph.nodes[x]['clocks']) > 1)
    no_clock = set(x for x in instances - blackboxes if 'clocks' not in sequential_graph.nodes[x] or
                   len(sequential_graph.nodes[x]['clocks']) == 0)
    other_instances = instances - (blackbox_instances | multi_clock | no_clock)
    cdc_instances = set()
    for other_instance in other_instances:
        predecessors = set(sequential_graph.predecessors(other_instance))
        if any(predecessor in blackbox_instances for predecessor in predecessors):
            cdc_instances.add(other_instance)
        else:
            other_instance_clocks = sequential_graph.nodes[other_instance]['clocks']
            for predecessor in predecessors:
                if isinstance(predecessor, sdn.VirtualInstance):
                    if 'clocks' not in sequential_graph.nodes[predecessor] or \
                            len(sequential_graph.nodes[predecessor]['clocks'] & other_instance_clocks) == 0 or \
                            len(sequential_graph.nodes[predecessor]['clocks'] - other_instance_clocks) > 0:
                        cdc_instances.add(other_instance)
    synchronizers = set()
    search_stack = list(cdc_instances)
    while search_stack:
        top = search_stack.pop()
        successors = set(connectivity_graph.successors(top))
        if len(successors) == 1 and all(successor in other_instances for successor in successors):
            synchronizers.add(top)
            synchronizers |= successors
            search_stack += successors
    print("Sorted")


def get_driver_and_driven_virtual_instances(id_virtualPin, identified):
    virtualWires = sdn.get_virtual_wires(of=id_virtualPin, selection=sdn.ALL)
    driver = None
    driven = set()
    for virtual_wire in virtualWires:
        virtualPins = virtual_wire.get_virtualPins()
        for virtual_pin in virtualPins:
            virtual_instance = virtual_pin.virtualParent.virtualParent
            port = virtual_pin.pin.port
            port_name = port['EDIF.identifier']
            definition = port.definition
            type = definition['EDIF.identifier']
            if type in power_primives:
                print("clk_tied to ground or vcc, ignored")
            elif virtual_instance in sequential_graph.nodes:
                if type in sequential_primitives:
                    if port_name in sequential_primitives[type]:
                        driven.add(virtual_instance)
                        identified.add(virtual_pin)
                    else:
                        print("Unidentified clk port")
                else:
                    if port.direction == sdn.OUT:
                        if driver:
                            print("warning, a driver was already identified.")
                        driver = virtual_pin
                        print("blackbox clock source?")
                    else:
                        driven.add(virtual_instance)
            elif virtual_instance.is_leaf() and port.direction == sdn.OUT:
                if driver:
                    print("warning, a driver was already identified.")
                driver = virtual_pin
    return driver, driven


def fold_feedback():
    global feedback_hierarchy
    if os.path.isfile('feedback_hierarchy_report.txt'):
        sets_stack = [set()]
        quick_name_lookup = dict()
        for vi in sdn.get_virtual_instances(hierarchical=True):
            quick_name_lookup[vi.get_hierarchical_name()] = vi
        with open('feedback_hierarchy_report.txt') as fi:
            cur_level = 0
            for line_number, line in enumerate(fi, 1):
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

        # Handle self loops
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
            # find nodes with minimum return distance
            minimum_return_distances = dict()
            min_return_distance = 2
            still_looking = True
            while still_looking:
                for node in scc:
                    # find minimum return distance
                    found_nodes = {node}
                    search_queue = deque()
                    search_queue.append((node, 0))
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
                                    search_queue.append((successor, next_depth))
                if still_looking:
                    min_return_distance *= 2
            print("Minimum return distance {}.".format(min_return_distance))
            nodes_of_return_distance = set(
                node for node, distance in minimum_return_distances.items() if distance == min_return_distance)
            print("There are {} nodes with this return distance, {} total.".format(len(nodes_of_return_distance),
                                                                                   folded_graph.number_of_nodes()))

            # find tightfeedback groups
            node_to_set = dict()
            for node in nodes_of_return_distance:
                nearby = surround(folded_graph, node, min_return_distance - 1)
                filtered = (x for x in nearby if x in nodes_of_return_distance)
                containing_scc = next(nx.strongly_connected_components(folded_graph.subgraph(filtered)))
                node_set = set()
                for scc_node in containing_scc:
                    if scc_node in node_to_set:
                        node_set |= node_to_set[scc_node]
                    else:
                        node_set.add(scc_node)
                for node_set_node in node_set:
                    node_to_set[node_set_node] = node_set

            groups = list()
            group_ids = set()
            for group in node_to_set.values():
                group_id = id(group)
                if group_id not in group_ids:
                    group_ids.add(group_id)
                    groups.append(frozenset(group))

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
    # print_fold_hierarchy_recursive(feedback_hierarchy.nodes)
    print_fold_hierarchy_non_recursive(feedback_hierarchy)


def print_fold_hierarchy_recursive(nodes, prefix=0):
    for node in sorted((x for x in nodes if not isinstance(x, sdn.VirtualPort)),
                       key=lambda y: len(y) if isinstance(y, frozenset) else 0, reverse=True):
        if isinstance(node, frozenset):
            print("{} Feedback_node".format(prefix))
            print_fold_hierarchy_recursive(node, prefix=prefix + 1)
        else:
            print(str(prefix) + " " + node.get_hierarchical_name())


def print_fold_hierarchy_non_recursive(nodes):
    with open("feedback_hierarchy_report.txt", 'w') as fi:
        depths = dict()
        depth = 0
        found_nodes = set(nodes)
        search_stack = list(map(lambda node: (node, 0),
                                sorted((x for x in found_nodes if not isinstance(x, sdn.VirtualPort)),
                                       key=lambda y: len(y) if isinstance(y, frozenset) else 0)))
        while search_stack:
            node, level = search_stack.pop()
            if isinstance(node, frozenset):
                fi.write("{} Feedback_node\n".format(level))
                for subnode in sorted((x for x in node if not isinstance(x, sdn.VirtualPort)),
                                      key=lambda y: len(y) if isinstance(y, frozenset) else 0):
                    search_stack.append((subnode, level + 1))
            else:
                fi.write("{} {}\n".format(level, node.get_hierarchical_name()))


def select_target_nodes():
    global nodes_to_replicate, cm, crm, parents
    cm, crm, parents = sort_combinational_members()
    luts_in_feedback = list(x for x in sensitive_luts if x in crm)
    print("Sensitive luts in feedback {} of {} known sensitive_luts".format(len(luts_in_feedback), len(sensitive_luts)))
    fbgs_with_sensitive_luts = set()
    for lut in luts_in_feedback:
        fbgs_with_sensitive_luts |= crm[lut]
    print("There are {} feedback groups that contain sensitive luts.".format(len(fbgs_with_sensitive_luts)))
    selfcontained = set(x for x in fbgs_with_sensitive_luts if all(not isinstance(y, frozenset) for y in x))
    print(
        "There are {} self contained feedback groups (meaning they themselves do not contain more feedback groups).".format(
            len(selfcontained)))
    selfcontained_nodes = set()
    for s in selfcontained:
        selfcontained_nodes |= s
    drive = nodes_that_drive_nodes(connectivity_graph, selfcontained_nodes)
    driven = nodes_driven_by_nodes(connectivity_graph, selfcontained_nodes)
    combinational_nodes = drive | driven
    print("Selected {} sequential_nodes and {} combinational_nodes.".format(len(selfcontained_nodes),
                                                                            len(combinational_nodes)))
    # extend selection to include all carry_chain members:
    carry_chain_nodes = set(x for x in combinational_nodes if x.instance.definition['EDIF.identifier'] == "CARRY4")
    print("Carry chain nodes before extension {}.".format(len(carry_chain_nodes)))
    search_stack = list(carry_chain_nodes)
    others = set()
    while search_stack:
        top_node = search_stack.pop()
        for adjacent in chain(connectivity_graph.predecessors(top_node), connectivity_graph.successors(top_node)):
            if isinstance(adjacent, sdn.VirtualInstance):
                def_name = adjacent.instance.definition['EDIF.identifier']
                if adjacent.instance.definition['EDIF.identifier'] == "CARRY4":
                    if adjacent not in carry_chain_nodes:
                        carry_chain_nodes.add(adjacent)
                        search_stack.append(adjacent)
                elif def_name in (set(sequential_primitives) | combinational_primitives):
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
                elif def_name in (set(sequential_primitives) | combinational_primitives):
                    others.add(adjacent)
    print("Carry chain nodes after extension {}.".format(len(carry_chain_nodes)))
    return (carry_chain_nodes | others)


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
        for scc in (x for x in nx.strongly_connected_components(subgraph) if
                    len(x) > 1 or any(xx in subgraph.successors(xx) for xx in x)):
            found_scc = True
            sequential_elements_in_sccs |= set(
                x for x in scc if x.instance.definition['EDIF.identifier'] in sequential_primitives)
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


def sort_combinational_members():
    parents = dict()
    combinational_mapping = dict()
    frozenset_mappings = dict()
    frozenset_count = 0
    found_nodes = set()
    search_stack = list()
    for node in feedback_hierarchy:
        found_nodes.add(node)
        search_stack.append((node, False))
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
            search_stack.append((node, True))
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


def export_sequential_graph_dot(sequential_graph, folded_graph=None, exclude_ports=True):
    if not folded_graph:
        folded_graph = sequential_graph
    if exclude_ports:
        sequential_graph = sequential_graph.subgraph(
            x for x in sequential_graph.nodes if isinstance(x, sdn.VirtualInstance))
    nodeToIndex = dict()
    for index, node in enumerate(sequential_graph.nodes):
        nodeToIndex[node] = index
    subgraph_index = 0
    with open("sequential_graph.dot", 'w') as fi:
        fi.write("digraph {\n")
        fi.write("  rankdir=LR;\n")
        if not exclude_ports:
            fi.write("  subgraph cluster_{}{{\n".format(subgraph_index))
            subgraph_index += 1
            fi.write('    label="INPUT PORTS";\n')
            for node in [x for x in sequential_graph.nodes if
                         isinstance(x, sdn.VirtualPort) and x.port.direction == sdn.IN]:
                label = "{}".format(node.get_name())
                fi.write('  {}[label="{}"];\n'.format(nodeToIndex[node], label))
            fi.write("  }\n")
        subgraph_index = gen_cluster_hierarchy(fi, folded_graph.nodes, nodeToIndex, cluster_index=subgraph_index)
        subgraph_index += 1
        if not exclude_ports:
            fi.write("  subgraph cluster_{}{{\n".format(subgraph_index))
            subgraph_index += 1
            fi.write('    label="OUTPUT PORTS";\n')
            for node in [x for x in sequential_graph.nodes if
                         isinstance(x, sdn.VirtualPort) and x.port.direction == sdn.OUT]:
                label = "{}".format(node.get_name())
                fi.write('  {}[label="{}"];\n'.format(nodeToIndex[node], label))
            fi.write("  }\n")
        for node in [x for x in sequential_graph.nodes if
                     not isinstance(x, sdn.VirtualPort) or x.port['EDIF.identifier'] not in ["clock", "reset"]]:
            for successor in sequential_graph.successors(node):
                fi.write('  {} -> {};\n'.format(nodeToIndex[node], nodeToIndex[successor]))
        fi.write("}\n")


def gen_cluster_hierarchy(fi, nodes, nodeToIndex, prefix="  ", cluster_index=0):
    fi.write("{}subgraph cluster_{}{{\n".format(prefix, cluster_index))
    fi.write('    label="FEEDBACK_GROUP";\n')
    for node in sorted((x for x in nodes if not isinstance(x, sdn.VirtualPort)),
                       key=lambda y: len(y) if isinstance(y, frozenset) else 0, reverse=True):
        if isinstance(node, frozenset):
            cluster_index += 1
            cluster_index = gen_cluster_hierarchy(fi, node, nodeToIndex, prefix="  " + prefix,
                                                  cluster_index=cluster_index)
        else:
            fi.write('{}  {}[label="{}"];\n'.format(prefix, nodeToIndex[node], node.get_name()))
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
    with open("nodes_to_replicate.txt", 'w') as fi:
        for node in nodes_to_replicate:
            fi.write(node.get_hierarchical_name() + "\n")

    with open("nodes_to_vote_on.txt", 'w') as fi:
        for node in nodes_to_vote_on:
            fi.write(node.get_hierarchical_name() + "\n")
        # triplicate_inst_map = triplicate_instances(nodes_to_replicate, uniquify_properties=["SOFT_LUTNM"])
        # triplicate_port_map = triplicate_ports(based_on=nodes_to_replicate)
        # triplicate_and_connect_cables(instances=triplicate_inst_map, ports=triplicate_port_map)
        # insert_voters(on=nodes_to_vote_on, instances=triplicate_inst_map, ports=triplicate_port_map)


def triplicate_instances(nodes_to_triplicate, uniquify_properties=None):
    return replicate_instances(nodes_to_triplicate, suffix="_TMR_", count=3, uniquify_properties=uniquify_properties)


def replicate_instances(nodes_to_replicate, suffix="_COPY_", count=2, uniquify_properties=None):
    assert all(len(x.instance.parent_definition.virtual_instances) == 1 for x in nodes_to_replicate)
    replicate_inst_map = dict()
    for node in nodes_to_replicate:
        instance = node.instance
        parent_definition = instance.parent_definition
        definition = instance.definition
        new_instances = list()
        for ii in range(1, count):
            new_instance = sdn.Instance()
            new_instance.definition = definition
            for property in instance:
                new_instance[property] = copy.deepcopy(instance[property])
            # rename
            new_suffix = suffix + str(ii)
            if 'EDIF.identifier' in new_instance:
                new_instance['EDIF.identifier'] = new_instance['EDIF.identifier'] + new_suffix
            if 'EDIF.original_identifier' in new_instance:
                new_instance['EDIF.original_identifier'] = new_instance['EDIF.original_identifier'] + new_suffix
            parent_definition.add_instance(new_instance)
            new_instances.append(new_instance)
        replicate_inst_map[node] = new_instances
        new_suffix = suffix + str(0)
        if 'EDIF.identifier' in instance:
            instance['EDIF.identifier'] = instance['EDIF.identifier'] + new_suffix
        if 'EDIF.original_identifier' in instance:
            instance['EDIF.original_identifier'] = instance['EDIF.original_identifier'] + new_suffix
    return replicate_inst_map


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
            virtual_ports.add(tlp)
    for port in virtual_ports:
        if len(port.virtualParent.instance.definition.virtual_instances) > 1:
            assert False, "Parent_definition_of_ports_not_unique"

    replicate_port_map = dict()
    for vp in virtual_ports:
        port = vp.port
        definition = port.definition
        new_ports = list()
        for ii in range(1, count):
            new_port = sdn.Port()
            new_port.is_downto = port.is_downto
            new_port.is_scalar = port.is_scalar
            new_port.lower_index = port.lower_index
            new_port.initialize_pins(len(port.inner_pins))
            for property in port:
                new_port[property] = copy.deepcopy(port[property])
            # rename
            new_suffix = suffix + str(ii)
            if 'EDIF.identifier' in new_port:
                new_port['EDIF.identifier'] = new_port['EDIF.identifier'] + new_suffix
            if 'EDIF.original_identifier' in new_port:
                new_port['EDIF.original_identifier'] = new_port['EDIF.original_identifier'] + new_suffix
            definition.add_port(new_port)
            new_ports.append(new_port)
        replicate_port_map[vp] = new_ports
        new_suffix = suffix + str(0)
        if 'EDIF.identifier' in port:
            port['EDIF.identifier'] = port['EDIF.identifier'] + new_suffix
        if 'EDIF.original_identifier' in port:
            port['EDIF.original_identifier'] = port['EDIF.original_identifier'] + new_suffix
    return replicate_port_map


def triplicate_and_connect_cables(instances=None, ports=None):
    return replicate_and_connect_cables(instances=instances, ports=ports, suffix="_TMR_", count=3)


def replicate_and_connect_cables(instances=None, ports=None, suffix="_COPY_", count=2):
    # find wires that need replicated (driven & drive) | immediately driven
    driven_pins = set()
    drive_pins = set()
    instance_drive_pins = set()
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
                    pins = set(port.virtualPins.values())
                    drive_pins |= pins
                    instance_drive_pins |= pins
    drive_wires = set(sdn.get_virtual_wires(of=driven_pins, selection=sdn.ALL))
    driven_wires = set(sdn.get_virtual_wires(of=drive_pins, selection=sdn.ALL))
    immediate_drive_wires = set(sdn.get_virtual_wires(of=instance_drive_pins, selection=sdn.OUTSIDE))
    common_wires = drive_wires | driven_wires | immediate_drive_wires
    cables_to_replicate = set()
    for wire in common_wires:
        cables_to_replicate |= wire.virtualParent
    print("This many cables need replicated {}.".format(len(cables_to_replicate)))

    replicate_cable_map = dict()
    for vc in cables_to_replicate:
        cable = vc.cable
        definition = cable.definition
        new_cables = list()
        for ii in range(1, count):
            new_cable = sdn.Cable()
            new_cable.is_downto = cable.is_downto
            new_cable.is_scalar = cable.is_scalar
            new_cable.lower_index = cable.lower_index
            new_cable.initialize_wires(len(cable.wires))
            for property in cable:
                new_cable[property] = copy.deepcopy(cable[property])
            # rename
            new_suffix = suffix + str(ii)
            if 'EDIF.identifier' in new_cable:
                new_cable['EDIF.identifier'] = new_cable['EDIF.identifier'] + new_suffix
            if 'EDIF.original_identifier' in new_cable:
                new_cable['EDIF.original_identifier'] = new_cable['EDIF.original_identifier'] + new_suffix
            definition.add_cable(new_cable)
            new_cables.append(new_cable)
            replicate_cable_map[vc] = new_cables
        new_suffix = suffix + str(0)
        if 'EDIF.identifier' in cable:
            cable['EDIF.identifier'] = cable['EDIF.identifier'] + new_suffix
        if 'EDIF.original_identifier' in cable:
            cable['EDIF.original_identifier'] = cable['EDIF.original_identifier'] + new_suffix

    # Okay, I have ports and I have wires 1) if an instances is driven by a wire that is not
    for vc in cables_to_replicate:
        vi = vc.virtualParent
        cable = vc.cable
        for wire_index, wire in enumerate(cable.wires):
            for pin in wire.pins:
                port = pin.port
                virtualPort = vi.virtualPorts(port)
                if isinstance(pin, InnerPin):
                    if virtualPort in ports:
                        port_copies = ports[virtalPort]
                        for copy_index, cable_copy in enumerate(cables_to_replicate[vc]):
                            port_copy = port_copies[copy_index]
                            pin_copy = port_copy.inner_pins[port.index(pin)]
                            wire_copy = cable_copy.wires[wire_index]
                            wire_copy.add_pin(pin_copy)
                if isinstance(pin, OuterPin):
                    instance = pin.instance
                    virtualInstance = vi.virtualChildren[instance]
                    if virtualInstance in instances:
                        instance_copies = instances[virtualInstance]
                        for copy_index, cable_copy in enumerate(cables_to_replicate[vc]):
                            instance_copy = instance_copies[copy_index]
                            pin_copy = instance_copy.get_outer_pin(pin.inner)  # THIS ONLY WORKS FOR LEAF INSTANCES
                            wire_copy = cable_copy.wires[wire_index]
                            wire_copy.add_pin(pin_copy)
                    elif virtualPort in ports:
                        port_copies = ports[virtalPort]
                        for copy_index, cable_copy in enumerate(cables_to_replicate[vc]):
                            port_copy = port_copies[copy_index]
                            pin_copy = port_copy.inner_pins[port.index(pin)]
                            wire_copy = cable_copy.wires[wire_index]
                            wire_copy.add_pin(pin_copy)


def insert_voters(on=None, instances=None, ports=None):
    pass


run()
