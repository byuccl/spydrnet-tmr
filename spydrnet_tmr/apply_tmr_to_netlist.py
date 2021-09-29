"""
Apply TMR to netlist
"""
import spydrnet_tmr.support_files.xilinx_primitive_tokens
from spydrnet_tmr.analysis.voter_insertion.find_reduction_voter_points import (
    find_reduction_voter_points,
)
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet.uniquify import uniquify
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info
from spydrnet_tmr.transformation.replication.nmr import apply_nmr
from spydrnet_tmr.transformation.replication.organ_insertion import (
    insert_organs,
)
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
import spydrnet_tmr.analysis.voter_insertion


def apply_tmr_to_netlist(
    netlist,
    vendor_name,
    hinstances_and_hports_to_replicate,
    valid_voter_point_dict,
):
    """
    apply_tmr_to_netlist(netlist, vendor_name, ...)

    Apply triplication to a netlist.

    The netlist and vendor_name are the only required parameters to apply TMR
    to a netlist. The correct vendor is required in order to recognize the
    primitive types used in the netlist. By default, all instances and top-level
    ports will be triplicated, and no voters will be placed.

    Parameters
    ----------
    netlist : netlist - Required
        The netlist to which triplication will be applied.
    vendor_name : str - Required
        The vendor name for the primitive definitions found in the netlist. See
        `spydrnet_tmr/support_files/vendor_names.py` for a list of supported
        vendors.
    hinstances_and_hports_to_replicate : href, Iterable - optional, default: set()
        Hierarchical references to the instances within the netlist that will be
        replicated. By default, all leaf instances and top-level ports will be
        replicated.
    valid_voter_point_dict : dict, Iterable - optional, default: dict()
        Each key in the dictionary is a keyword that corresponds to a certain
        voter insertion algorithm, and the value is a list of valid voter points
        for that algorithm.

    """
    # uniquify is called to insure that non-leaf definitions are instanced only
    # once, prevents unintended transformations.
    uniquify(netlist)

    # Load primitive info for finding flip-flops later
    primitive_info = load_primitive_info(netlist, vendor_name)
    ff_primitive_names = []
    if vendor_name is XILINX:
        ff_primitive_names = primitive_info[
            spydrnet_tmr.support_files.xilinx_primitive_tokens.FF_CELLS
        ]

    # Triplicate specified instances and top-level ports.
    replicas = apply_nmr(
        [x.item for x in hinstances_and_hports_to_replicate],
        3,
        name_suffix="TMR",
        rename_original=True,
    )

    for (
        algorithm_name,
        valid_voter_points,
    ) in valid_voter_point_dict.items():
        # Finds the method in `spydrnet_tmr/analysis/voter_insertion`
        # String must exactly match the method name as found in voter_insertion directory.
        find_voters_method_name = "find_" + algorithm_name + "_voter_points"
        find_voters_module = getattr(
            spydrnet_tmr.analysis.voter_insertion, find_voters_method_name
        )
        find_voters_method = getattr(
            find_voters_module, find_voters_method_name
        )

        insertion_points = set()
        insertion_points = find_voters_method(
            netlist, valid_voter_points, XILINX
        )

    # Voters are inserted into the netlist
    insert_organs(replicas, insertion_points, XilinxTMRVoter(), "VOTER")

    return netlist
