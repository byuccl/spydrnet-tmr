"""
Xilinx TMR
===========
This is a xilinx TMR example using SpyDrNet TMR
"""

import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
from spydrnet_tmr import apply_nmr, insert_organs, uniquify_nmr_property
import spydrnet_tmr as sdn_tmr
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points import find_voter_insertion_points

def run():
    netlist = sdn.parse('reference_switch-baseline-pblock-20180511.edf')

    # uniquify is called to insure that non-leaf definitions are instanced only once, prevents unintended transformations.
    uniquify(netlist)

    pin_clock_domains = sdn_tmr.pin_clock_domain_analysis(netlist)
    synchronizer_chains = sdn_tmr.find_synchronizers(netlist, pin_clock_domains)
    hinstances_to_replicate = make_selection(netlist, pin_clock_domains, synchronizer_chains)

    with open("tmr_selection_conservative_1.txt", "w") as fi:
        for inst in hinstances_to_replicate:
            fi.write(inst.name + '\n')

    print("Replicating {} instances".format(len(hinstances_to_replicate)))
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)

    # find out where to insert reduction and feedback voters
    insertion_points = find_voter_insertion_points(netlist, hinstances_to_replicate, {'FDRE', 'FDSE', 'FDPE', 'FDCE'})

    # replicate instances and ports
    replicas = apply_nmr(instances_to_replicate, 3, name_suffix='TMR', rename_original=True)
    uniquify_nmr_property(replicas, {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}, "TMR")
    # insert voters on the selected drivers
    voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), 'VOTER')

    #compose out the netlist
    netlist.compose('reference_switch-conservative_tmr_rev1b.edf')


def make_selection(netlist, pin_clock_domains, synchronizer_chains):
    synchronizers = set()
    for chain in synchronizer_chains:
        synchronizers.update(chain)

    multi_clock = set(next(pin.get_hinstances()) for pin, clocks in pin_clock_domains.items() if len(clocks) > 1)

    #exclude anything that drives a black box or multi-clock cell up to and including that element.

    primitive_info = sdn_tmr.load_primitive_info(netlist)

    blackboxes = set(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() and
                                                                             x.item.reference not in primitive_info['combinational_cells'] and
                                                                             x.item.reference not in primitive_info['sequential_cells'] and
                                                                             x.item.reference not in primitive_info['power_ground_cells']))


    items_to_search = [*multi_clock, *blackboxes]
    additional_excludes = set()
    while items_to_search:
        input_pins_to_excluded_items = set(sdn.get_hpins(items_to_search, filter=lambda x: x.item.port.direction is sdn.IN))
        connected_wires = set(sdn.get_hwires(input_pins_to_excluded_items, selection="ALL"))
        connected_srcs = set(sdn.get_hpins(connected_wires, filter=lambda x: x.item.port.direction is sdn.OUT and x.item.port.definition.is_leaf()))
        connected_instances = set(sdn.get_hinstances(connected_srcs))

        items_to_search = set()
        for instance in connected_instances:
            reference = instance.item.reference
            if reference in primitive_info['combinational_cells']:
                items_to_search.add(instance)
                additional_excludes.add(instance)
            elif reference in primitive_info['sequential_cells']:
                additional_excludes.add(instance)

    comb_seq_cells = set(netlist.get_hinstances(recursive=True, filter=lambda x:
                                                x.item.reference in primitive_info['combinational_cells'] or
                                                x.item.reference in primitive_info['sequential_cells']))

    print("number of synchronizers", len(synchronizers))
    print("Combinational or Sequential Leaf cell candiadates", len(comb_seq_cells))

    selection = comb_seq_cells
    selection = selection - synchronizers
    selection = selection - multi_clock
    selection = selection - additional_excludes

    return selection


run()