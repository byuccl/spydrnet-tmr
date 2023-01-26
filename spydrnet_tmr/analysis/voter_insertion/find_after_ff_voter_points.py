"""
Find voter insertion points after every flip-flip
"""
import spydrnet as sdn

from spydrnet_tmr.support_files.vendor_names import XILINX, LATTICE
from spydrnet_tmr.support_files.xilinx_primitive_tokens import FF_CELLS
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info


def find_after_ff_voter_points(
    netlist,
    endpoints_to_replicate,
    vendor_name,
):
    """Find Voter Points After Every Flip-Flop

    Search for every flip-flip in the design within the endpoints to be
    replicated list that match the given flip-flip primitive names, and for
    each flip-flop find the output pin (only one output port for flip-flop
    primitives, so just choose the port with direction "OUT") and add it to
    the insertion points set.

    :param netlist: netlist for which voter points will be found
    :type netlist: netlist
    :param endpoints_to_replicate: List of all hierarchical instances and ports to be replicated. This list determines the places that voters will need to be inserted.
    :type endpoints_to_replicate: list
    :param vendor_name: name of vendor for finding flip-flop primitive
    :type vendor_name: string
    :return: Set of pins at each point in the netlist where voters will be inserted.
    :rtype: list

    """
    # """
    # Find voter insertion points after every flip-flip

    # Search for every flip-flip in the design within the endpoints to be
    # replicated list that match the given flip-flip primitive names, and for
    # each flip-flop find the output pin (only one output port for flip-flop
    # primitives, so just choose the port with direction "OUT") and add it to
    # the insertion points set.

    # :param endpoints_to_replicate: List of all hierarchical instances and ports to be replicated. This list determines the places that voters will need to be inserted.
    # :param primitive_names: List of strings for flip-flop primitve names found in the design so that the algorithm can locate each of them.

    # :return insertion_points: Set of pins at each point in the netlist where voters will be inserted.

    # """
    endpoints_to_replicate = set(endpoints_to_replicate)
    primitive_names = set()
    
    insertion_points = set()

    # Load primitive info for finding flip-flops
    primitive_info = load_primitive_info(netlist, vendor_name)
    if vendor_name is XILINX:
        for definition in primitive_info[FF_CELLS]:
            primitive_names.add(definition.name)
    if vendor_name is LATTICE:
        for definition in primitive_info[FF_CELLS]:
            primitive_names.add(definition.name)

    # Identify all flip-flop instances
    for endpoint in endpoints_to_replicate:
        if (
            isinstance(endpoint.item, sdn.ir.instance.Instance)
            and endpoint.item.reference.name in primitive_names
        ):
            # Identify OuterPin for output of each flip-flip
            for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                if pin.inner_pin.port.direction is sdn.OUT:
                    if pin.wire:
                        insertion_points.add(pin)

    print(
        "Identified {} insertion points for feedback voters after flip-flop.".format(
            len(insertion_points)
        )
    )

    return insertion_points
