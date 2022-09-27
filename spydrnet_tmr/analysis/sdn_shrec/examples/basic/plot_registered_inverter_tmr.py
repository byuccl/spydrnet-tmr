"""
Registered Inverter TMR Example
=============================================

In this example, there is a global clock buffer that is triplicated. This allows 
for a global clock buffer for each TMR domain in case a BUFG fails. It is 
possible that a synchronous element in the design may not be triplicated, 
and needs a signal from a BUFG. When a synchronous element that receives a 
signal from a BUFG is not triplicated, special care needs to be taken to ensure 
that a voter is not placed in its path, but rather that the non-replicated 
synchronous element just receives its clock signal from the primary TMR domain. 
If a voter is placed in its path, this could result in large hold time 
violations

This is a good example of how to SpyDrNet SHREC to selectively replicate a 
design and still maintain performance by controlling the placement of voters.

"""
from spydrnet.uniquify import uniquify
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter

from spydrnet_tmr.support_files.xilinx_primitive_tokens import (
    CLOCK_BUFFERS,
    FF_CELLS,
)
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info
from spydrnet_tmr import apply_nmr, insert_organs
import spydrnet_shrec
from spydrnet_shrec.analysis.find_voter_insertion_points import (
    find_voter_insertion_points,
)

from spydrnet_tmr.support_files.xilinx_primitive_tokens import (
    CLOCK_BUFFERS,
    FF_CELLS,
)
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info


def run():
    """
    Generate netlist with no voters after BUFGs
    """
    netlist_name = "registered_inverter"

    non_replicated_instances = {
        "DQ_reg[1]",
    }

    generate_tmr_netlist(netlist_name, non_replicated_instances)


def generate_tmr_netlist(netlist_name, non_replicated_instances):
    """
    Generate a TMR netlist

    """
    netlist = spydrnet_shrec.load_example_netlist_by_name(netlist_name)
    uniquify(netlist)

    # Find hierarchical references to all leaf finstances
    hinstances_to_replicate = list(
        netlist.get_hinstances(
            recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
        )
    )
    # Exclude the given non-replicated instances from the list
    hinstances_to_replicate = list(
        x
        for x in hinstances_to_replicate
        if x.item.name not in non_replicated_instances
    )
    # Create list of actual instances from hierarchcial references
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)

    # Find hierarchical references to top-level ports
    hports_to_replicate = list(port for port in netlist.get_hports())
    # Create list of actual instances from hierarchcial references
    ports_to_replicate = list(x.item for x in hports_to_replicate)

    primitive_info = load_primitive_info(netlist, XILINX)

    hinstances_to_replicate_without_BUFG = list(
        x
        for x in hinstances_to_replicate
        if x.item.reference.name
        not in [cell.name for cell in primitive_info[CLOCK_BUFFERS]]
    )

    # find out where to insert reduction and feedback voters
    insertion_points = find_voter_insertion_points(
        netlist,
        [*hinstances_to_replicate_without_BUFG, *hports_to_replicate],
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

    netlist_tmr_name = netlist_name + "_tmr"

    netlist.compose(netlist_tmr_name + ".edf")


run()
