from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.analysis.identify_reduction_points import (
    identify_reduction_points,
)
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info
from spydrnet_tmr.transformation.replication.nmr import apply_nmr
from spydrnet_tmr.transformation.replication.organ_insertion import (
    insert_organs,
)
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_after_ff import (
    find_voter_insertion_points_after_ff,
)
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_before_ff import (
    find_voter_insertion_points_before_ff,
)


def apply_tmr_to_netlist(netlist, vendor_name, **kwargs):
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
        `spydrnet_shrec/support_files/vendor_names.py` for a list of supported
        vendors.
    hinstances_to_replicate : href, Iterable - optional, default: set()
        Hierarchical references to the instances within the netlist that will be
        replicated. By default, all leaf instances will be replicated
    hports_to_replicate : href, Iterable - optional, default: set()
        Hierarchical references to the top-level ports within the netlist that
        will be replicated. By default, all top-level ports will be replicated
    insert_reduction_voters_flag : bool - optional, default: True
        Determines whether reduction voters will be placed at triplicated to
        non-triplicated boundaries. If set to false, non-triplicated components
        will receive a signal from the primary TMR domain of the triplicated
        components. By default, voters will be placed at thesetypes of
        boundaries.
    insert_voters_before_ff_flag : bool - optional, default: False
        Determines whether voters will be placed before flip-flops. These voters
        serve to cut feedback (if present) and partition triplicated parts of a
        netlist for increased reliability. Be default, these voters will not be
        placed.
    insert_voters_after_ff_flag : bool - optional, default: False
        Determines whether voters will be placed after flip-flops. These voters
        serve to cut feedback (if present) and partition triplicated parts of a
        netlist for increased reliability. Be default, these voters will not be
        placed.
    replicate_all_input_ports_flag : bool - optional, default: True
        Determines whether input ports will be replicated. Be default, they will
        be replicated
    replicate_all_output_ports_flag : bool - optional, default: True
        Determines whether output ports will be replicated. Be default, they
        will be replicated
    replicate_all_inout_ports_flag : bool - optional, default: True
        Determines whether inout ports will be replicated. Be default, they will
         be replicated

    """

    param_key_words = {
        "hinstances_to_replicate",
        "hports_to_replicate",
        "insert_reduction_voters_flag",
        "insert_voters_before_ff_flag",
        "insert_voters_after_ff_flag",
        "replicate_all_input_ports_flag",
        "replicate_all_output_ports_flag",
        "replicate_all_inout_ports_flag",
    }
    if any(x not in param_key_words for x in kwargs):
        raise TypeError("Unknown usage. Please see help for more information.")

    hinstances_to_replicate = kwargs.get("hinstances_to_replicate", set())
    hports_to_replicate = kwargs.get("hports_to_replicate", set())
    insert_reduction_voters_flag = kwargs.get(
        "insert_reduction_voters_flag", True
    )
    insert_voters_before_ff_flag = kwargs.get(
        "insert_voters_before_ff_flag", False
    )
    insert_voters_after_ff_flag = kwargs.get(
        "insert_voters_after_ff_flag", False
    )
    replicate_all_input_ports_flag = kwargs.get(
        "replicate_all_input_ports_flag", True
    )
    replicate_all_output_ports_flag = kwargs.get(
        "replicate_all_output_ports_flag", True
    )
    replicate_all_inout_ports_flag = kwargs.get(
        "replicate_all_inout_ports_flag", True
    )

    # uniquify is called to insure that non-leaf definitions are instanced only
    # once, prevents unintended transformations.
    uniquify(netlist)

    # Load primitive info for finding flip-flops later
    primitive_info = load_primitive_info(netlist, vendor_name)
    if vendor_name is XILINX:
        from spydrnet_shrec.support_files.xilinx_primitive_tokens import (
            FF_CELLS as FF_PRIMITIVES,
        )

    # If no instances were provided to replicate, select all leaf instances for
    # replication
    if not hinstances_to_replicate:
        hinstances_to_replicate = set(
            netlist.get_hinstances(
                recursive=True,
                filter=lambda x: x.item.reference.is_leaf() is True,
            )
        )
    instances_to_replicate = set(x.item for x in hinstances_to_replicate)

    # Add input, output, or inout ports to hports_to_replicate set if any flags
    # are set.
    if replicate_all_input_ports_flag:
        hports_to_replicate.update(
            set(
                netlist.get_hports(filter=lambda x: x.item.direction is sdn.IN)
            )
        )
    if replicate_all_output_ports_flag:
        hports_to_replicate.update(
            set(
                netlist.get_hports(
                    filter=lambda x: x.item.direction is sdn.OUT
                )
            )
        )
    if replicate_all_inout_ports_flag:
        hports_to_replicate.update(
            set(
                netlist.get_hports(
                    filter=lambda x: x.item.direction is sdn.INOUT
                )
            )
        )
    ports_to_replicate = set(x.item for x in hports_to_replicate)

    # These algorithms will look for all of the flip-flops (based on the vendor
    # provided) that will be replicated, and return the points at which voters
    # will be placed.
    before_ff_voter_points = set()
    after_ff_voter_points = set()
    if insert_voters_before_ff_flag:
        before_ff_voter_points = find_voter_insertion_points_before_ff(
            [*hinstances_to_replicate, *hports_to_replicate],
            [cell.name for cell in primitive_info[FF_PRIMITIVES]],
        )
    if insert_voters_after_ff_flag:
        before_ff_voter_points = find_voter_insertion_points_after_ff(
            [*hinstances_to_replicate, *hports_to_replicate],
            [cell.name for cell in primitive_info[FF_PRIMITIVES]],
        )

    # Triplicate specified instances and top-level ports.
    replicas = apply_nmr(
        [*instances_to_replicate, *ports_to_replicate],
        3,
        name_suffix="TMR",
        rename_original=True,
    )

    # Reduction voter points are located after triplicating the design.
    reduction_voter_points = set()
    if insert_reduction_voters_flag:
        reduction_voter_points = identify_reduction_points(replicas, "TMR")

    # All voter points are combined into a single list
    insertion_points = [
        *reduction_voter_points,
        *before_ff_voter_points,
        *after_ff_voter_points,
    ]

    # Voters are inserted into the netlist
    insert_organs(replicas, insertion_points, XilinxTMRVoter(), "VOTER")

    return netlist
