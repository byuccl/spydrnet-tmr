"""
Find voter insertion points after every flip-flip
"""
import spydrnet as sdn


def find_after_ff_voter_points(
    endpoints_to_replicate,
    ff_primitive_names,
):
    """
    Find voter insertion points after every flip-flip

    Search for every flip-flip in the design within the endpoints to be
    replicated list that match the given flip-flip primitive names, and for
    each flip-flop find the output pin (only one output port for flip-flop
    primitives, so just choose the port with direction "OUT") and add it to
    the insertion points set.

    :param endpoints_to_replicate: List of all hierarchical instances and ports to be replicated. This list determines the places that voters will need to be inserted.
    :param ff_primitive_names: List of strings for flip-flop primitve names found in the design so that the algorithm can locate each of them.

    :return insertion_points: Set of pins at each point in the netlist where voters will be inserted.

    """
    endpoints_to_replicate = set(endpoints_to_replicate)
    ff_primitive_names = set(ff_primitive_names)

    insertion_points = set()

    # Identify all flip-flop instances
    for endpoint in endpoints_to_replicate:
        if (
            isinstance(endpoint.item, sdn.ir.instance.Instance)
            and endpoint.item.reference.name in ff_primitive_names
        ):
            # Identify OuterPin for output of each flip-flip
            for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                for port in pin.get_ports():
                    if port.direction is sdn.OUT:
                        insertion_points.add(pin)

    print(
        "Identified {} insertion points for feedback voters after flip-flop.".format(
            len(insertion_points)
        )
    )

    return insertion_points
