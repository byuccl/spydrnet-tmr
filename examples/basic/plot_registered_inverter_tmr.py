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

This is a good example of how to use SpyDrNet TMR to selectively replicate a 
design and still maintain performance by controlling the placement of voters.

"""
from spydrnet.uniquify import uniquify
from spydrnet_tmr import load_example_netlist_by_name
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet_tmr.support_files.vendor_names import XILINX


def run():
    """
    Generate netlist with no voters after BUFGs
    """
    netlist_name = "registered_inverter"

    non_replicated_instance_names = {
        "DQ_reg[1]",
    }

    generate_tmr_netlist(netlist_name, non_replicated_instance_names)


def generate_tmr_netlist(netlist_name, non_replicated_instance_names):
    """
    Generate a TMR netlist

    """
    netlist = load_example_netlist_by_name(netlist_name)
    uniquify(netlist)

    # Find hierarchical references to all leaf finstances and exclude the given
    # non-replicated instances from the list
    hinstances_to_replicate = list(
        netlist.get_hinstances(
            recursive=True,
            filter=lambda x: x.item.reference.is_leaf() is True
            and x.item.name not in non_replicated_instance_names,
        )
    )

    # Find hierarchical references to top-level ports
    valid_voter_point_dict = dict()
    valid_voter_point_dict["reduction"] = list(
        x
        for x in hinstances_to_replicate
        if x.item.reference.name not in {"BUFG"}
    )

    apply_tmr_to_netlist(
        netlist,
        XILINX,
        hinstances_and_hports_to_replicate=hinstances_to_replicate,
        valid_voter_point_dict=valid_voter_point_dict,
    )

    netlist_tmr_name = netlist_name + "_tmr"
    netlist.compose(netlist_tmr_name + ".edf")


run()
