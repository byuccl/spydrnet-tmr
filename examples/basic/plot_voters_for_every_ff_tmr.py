"""
Voter Before/After Every Flip-Flop Algorithms
=============================================

There are several ways to place voters in a TMR netlist. This example covers the
two simplest ways: placing voters before every flip-flop, and placing voters
after every flip-flop.

The only difference in the process between these algorithms and other algorithms
that SpyDrNet TMR implements occurs when finding the insertion points for the
voters. In this example, two netlists are composed. One that uses the
`find_voter_insertion_points_before_ff` function to find insertion points for
voters, and one that uses the `find_voter_insertion_points_after_ff` function.

"""
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet_tmr.support_files.vendor_names import XILINX


def run():
    """
    Generate two netlists: one with voters before every flip-flop, and one
    with voters after every flip-flop
    """
    netlist_name = "b13"

    generate_tmr_netlist(netlist_name, voters_before_ff=True)
    generate_tmr_netlist(netlist_name, voters_before_ff=False)


def generate_tmr_netlist(netlist_name, voters_before_ff=True):
    """
    Generate a TMR netlist with voters before/after every flip-flop

    Parameters
    """
    netlist = sdn.load_example_netlist_by_name(netlist_name)
    uniquify(netlist)

    # set instances_to_replicate [get_cells -hierarchical -filter \
    # {PRIMITIVE_LEVEL==LEAF||PRIMITIVE_LEVEL==MACRO}]
    hinstances_to_replicate = list(
        netlist.get_hinstances(
            recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
        )
    )

    # set ports_to_replicate [get_ports]
    hports_to_replicate = list(port for port in netlist.get_hports())

    valid_voter_point_dict = dict()
    valid_voter_point_dict["reduction"] = [
        *hinstances_to_replicate,
        *hports_to_replicate,
    ]

    # find out where to insert reduction and feedback voters
    if voters_before_ff:
        valid_voter_point_dict["before_ff"] = [
            *hinstances_to_replicate,
            *hports_to_replicate,
        ]
    else:
        valid_voter_point_dict["after_ff"] = [
            *hinstances_to_replicate,
            *hports_to_replicate,
        ]

    netlist = apply_tmr_to_netlist(
        netlist,
        XILINX,
        hinstances_and_hports_to_replicate=[
            *hinstances_to_replicate,
            *hports_to_replicate,
        ],
        valid_voter_point_dict=valid_voter_point_dict,
    )

    netlist_tmr_name = ""

    if voters_before_ff:
        netlist_tmr_name = netlist_name + "_before_ff_tmr"
    else:
        netlist_tmr_name = netlist_name + "_after_ff_tmr"

    netlist.compose(netlist_tmr_name + ".edf")


run()
