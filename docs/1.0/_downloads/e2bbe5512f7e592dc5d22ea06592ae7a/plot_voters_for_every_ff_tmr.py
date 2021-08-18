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
from spydrnet_tmr import apply_nmr, insert_organs
import spydrnet_tmr
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_before_ff import (
    find_voter_insertion_points_before_ff,
)
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_after_ff import (
    find_voter_insertion_points_after_ff,
)
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter

from spydrnet_tmr.support_files.xilinx_primitive_tokens import FF_CELLS
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info


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
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)

    # set ports_to_replicate [get_ports]
    hports_to_replicate = list(port for port in netlist.get_hports())

    ports_to_replicate = list(x.item for x in hports_to_replicate)

    primitive_info = load_primitive_info(netlist, XILINX)

    # find out where to insert reduction and feedback voters
    if voters_before_ff:
        insertion_points = find_voter_insertion_points_before_ff(
            [*hinstances_to_replicate, *hports_to_replicate],
            [cell.name for cell in primitive_info[FF_CELLS]],
        )
    else:
        insertion_points = find_voter_insertion_points_after_ff(
            [*hinstances_to_replicate, *hports_to_replicate],
            [cell.name for cell in primitive_info[FF_CELLS]],
        )

    # replicate instances and ports
    replicas = apply_nmr(
        [*instances_to_replicate, *ports_to_replicate],
        3,
        name_suffix="TMR",
        rename_original=True,
    )

    # insert voters on the selected drivers
    insert_organs(replicas, insertion_points, XilinxTMRVoter(), "VOTER")
    netlist_tmr_name = ""

    if voters_before_ff:
        netlist_tmr_name = netlist_name + "_before_ff_tmr"
    else:
        netlist_tmr_name = netlist_name + "_after_ff_tmr"

    netlist.compose(netlist_tmr_name + ".edf")


run()
