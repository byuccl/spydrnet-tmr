import spydrnet as sdn
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info


def find_synchronizers(netlist, pin_clock_domains):
    '''
    Find the synchronizers in a design

    :param netlist: the current netlist
    :param pin_clock_domains: obtained by running :ref:`pin_clock_domain_analysis`
    :return: list of HRef objects to the found synchronizer instances
    '''
    primitive_info = load_primitive_info(netlist)

    multiple_clocks = list(x for x in pin_clock_domains if len(pin_clock_domains[x]) > 1)
    multiple_clocks_seq = set(x.parent.parent for x in multiple_clocks if x.item.port.definition in
                              primitive_info['sequential_cells'])
    flip_flop_search = list(x for x in multiple_clocks_seq if x.item.reference.name.startswith('FD'))
    synchronizer_head = dict()
    synchronizer_tail = dict()
    found = set()
    while flip_flop_search:
        flip_flop = flip_flop_search.pop()
        if flip_flop in found:
            continue
        found.add(flip_flop)
        output_pins = list(flip_flop.get_hpins(filter=lambda x: x.item.port.direction is sdn.OUT))
        driven_wires = list(sdn.get_hwires(output_pins, selection="ALL"))
        input_pins = list(sdn.get_hpins(driven_wires, filter=lambda x: x.item.port.definition.is_leaf() and
                                                                       x.item.port.direction is sdn.IN))
        sync_nodes = list(sdn.get_hinstances(input_pins))
        if len(sync_nodes) == 1 and all(x.item.reference.name.startswith('FD') for x in sync_nodes):
            sync_node = sync_nodes[0]

            flip_flop_clock_pin = next(flip_flop.get_hpins("C"))
            sync_node_clock_pin = next(sync_node.get_hpins("C"))
            flip_flop_clocks = pin_clock_domains[flip_flop_clock_pin]
            sync_node_clocks = pin_clock_domains[sync_node_clock_pin]
            if frozenset(flip_flop_clocks) != frozenset(sync_node_clocks):
                continue

            if sync_node in synchronizer_head:
                chain = synchronizer_head.pop(sync_node)
                chain.insert(0, flip_flop)
                synchronizer_head[flip_flop] = chain
            elif flip_flop in synchronizer_tail:
                chain = synchronizer_tail.pop(flip_flop)
                chain.append(sync_node)
                synchronizer_tail[sync_node] = chain
                flip_flop_search.append(sync_node)
            else:
                chain = [flip_flop, sync_node]
                synchronizer_head[flip_flop] = chain
                synchronizer_tail[sync_node] = chain
                flip_flop_search.append(sync_node)
    synchronizer_chains = list(synchronizer_head.values())

    return synchronizer_chains
