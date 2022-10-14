import spydrnet as sdn
from spydrnet_tmr.analysis import adjacency_list
import networkx as nx


def find_voter_insertion_points(
    netlist,
    endpoints_to_replicate,
    primitive_names,
    separate_reduction_voters=False,
):
    """

    find_voter_insertion_points(netlist, ...)

    Currently, this function is not deterministic meaning selected inserted points may vary, especially with large designs.

    Find voter insertion points for feedback and reduction voters.

    :param netlist: the current netlist
    :param endpoints_to_replicate: List of all hierarchical instances and ports to be replicated. This list determines the places that voters will need to be inserted.
    :param primitive_names: List of strings for flip-flop primitive names found in the design so that the algorithm can locate each of them.
    :param separate_reduction_voters:
    :return: list of outer pins where voters will be inserted

    """
    endpoints_to_replicate = set(endpoints_to_replicate)
    primitive_names = set(primitive_names)

    all_leaf_hinstances = list(
        netlist.get_hinstances(
            recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
        )
    )
    all_top_level_ports = list(netlist.get_hports())
    connections = adjacency_list([*all_leaf_hinstances, *all_top_level_ports])
    connectivity_graph = nx.DiGraph(connections)

    reduction_voters = set()

    # first, reduction voters
    for endpoint in endpoints_to_replicate:
        if any(
            x not in endpoints_to_replicate
            for x in connectivity_graph.successors(endpoint)
        ):
            reduction_voters.add(endpoint)

    feedback_voters = set()
    # second, feedback voters
    if separate_reduction_voters is False:
        pool = endpoints_to_replicate - reduction_voters
    else:
        pool = endpoints_to_replicate
    sccs = list(
        nx.strongly_connected_components(connectivity_graph.subgraph(pool))
    )
    while sccs:
        scc = sccs.pop()
        if len(scc) == 1:
            for node in scc:
                if any(x in scc for x in connectivity_graph.successors(node)):
                    feedback_voters.add(node)
        else:
            subgraph = connectivity_graph.subgraph(scc).copy()
            candidates = list(
                x
                for x in subgraph.nodes
                if x.item.reference.name in primitive_names
            )
            if not candidates:
                print("Warning, feedback cannot be broken")
            else:
                candidate = max(candidates, key=subgraph.out_degree)
                feedback_voters.add(candidate)
                subgraph.remove_node(candidate)
                sccs += nx.strongly_connected_components(subgraph)

    # We know at that the inserting point is something that has been replicated
    # We dont know if a voter was placed here to break up feedback or if a voter was placed here to reduce.

    reduction_and_feedback_voter = set()
    if separate_reduction_voters is False:
        # identify which reduction voters also break up feedback?
        pool = endpoints_to_replicate - feedback_voters
        sccs = list(
            nx.strongly_connected_components(connectivity_graph.subgraph(pool))
        )
        while sccs:
            scc = sccs.pop()
            # check if reduction voter is part of a single node self-loop scc.
            if len(scc) == 1:
                for node in scc:
                    if any(
                        x in scc for x in connectivity_graph.successors(node)
                    ):
                        if any(x in reduction_voters for x in scc):
                            reduction_and_feedback_voter.add(node)
            else:
                # check if reduction voter is part of SCC
                included_reduction_voter = next(
                    (x for x in scc if x in reduction_voters), None
                )
                if included_reduction_voter:
                    subgraph = connectivity_graph.subgraph(scc).copy()
                    reduction_and_feedback_voter.add(included_reduction_voter)
                    subgraph.remove_node(included_reduction_voter)
                    sccs += nx.strongly_connected_components(subgraph)

    # We now know which voters are feedback, reduction, and both. If feedback or both, proceed as normal, else, only
    # insert voter between replicated pin and non-replicated end points.

    insertion_points = list()
    for node in feedback_voters:
        if isinstance(node.item, sdn.Port):
            insertion_points += (pin for pin in node.item.pins if pin.wire)
        else:
            for pin in node.item.pins:
                inner_pin = pin.inner_pin
                port = inner_pin.port
                if pin.wire and port.direction in {sdn.OUT, sdn.INOUT}:
                    insertion_points.append(pin)

    num_feedback_voters = len(insertion_points)
    print(
        "Identified {} insertion points for feedback voters.".format(
            num_feedback_voters
        )
    )

    if separate_reduction_voters is True:
        reduction_voters -= feedback_voters

    for reduction_voter in reduction_voters:
        # follow the output pins and if they drive something that isn't replicate then that point needs inserted.
        for sub_pin in reduction_voter.get_hpins(
            filter=lambda x: x.item.port.direction is sdn.OUT
        ):
            wires = sub_pin.get_hwires(selection="ALL")
            pins = set(
                #pins it drives of other leaf instances or its parent instance
                sdn.get_hpins(
                    wires,
                    filter=lambda x: (x.item.port.definition.is_leaf()
                    and x.item.port.direction is sdn.IN) or (x.parent.parent is reduction_voter.parent)
                )
            )
            instances = set(sdn.get_hinstances(pins))
            has_non_redundant = any(
                x not in endpoints_to_replicate for x in instances
            )
            has_redundant = any(x in endpoints_to_replicate for x in instances)
            if (has_non_redundant and not has_redundant) or (
                has_redundant
                and reduction_voter in reduction_and_feedback_voter
            ):
                # has non-redundant and redundant endpoints -> normal voter insertion
                # has only redundant endpoints and is feedback voter as well -> normal voter insertion
                outer_pin = next(sub_pin.get_pins(selection="OUTSIDE"))
                insertion_points.append(outer_pin)
            elif (
                has_non_redundant
                and has_redundant
                and reduction_voter not in reduction_and_feedback_voter
            ):
                # has only non-redundant feedback -> insert special voters
                non_redundant_instances = set(
                    x for x in instances if x not in endpoints_to_replicate
                )
                non_redundant_pins = set()
                for pin in pins:
                    port = pin.parent
                    instance = port.parent
                    if instance in non_redundant_instances:
                        non_redundant_pins.add(pin)
                driver_pin = next(sub_pin.get_pins(selection="OUTSIDE"))
                driven_pins = set()
                for non_redundant_pin in non_redundant_pins:
                    port = non_redundant_pin.parent
                    instance = port.parent
                    parent = (
                        instance.parent
                    )  # return the containing instance of instance
                    if parent is None:  # port is a top level port
                        driven_pins.add(
                            next(
                                non_redundant_pin.get_pins(selection="INSIDE")
                            )
                        )
                    else:
                        driven_pins.add(
                            next(
                                non_redundant_pin.get_pins(selection="OUTSIDE")
                            )
                        )
                insertion_points.append((driver_pin, frozenset(driven_pins)))

            # has only redundant endpoints and is not feedback voter -> don't add a voter.

            # if instances and any(x not in endpoints_to_replicate for x in instances):
            # any of the end points are non-redundant
            # TODO: sub_pin could be on a top level port, thus you would want the inside pin instead of the the outside pin
            #    outer_pin = next(sub_pin.get_pins(selection="OUTSIDE"))
            #    insertion_points.append(outer_pin)

    num_reduction_voters = len(insertion_points) - num_feedback_voters
    print(
        "Identified {} insertion points for reduction voters.".format(
            num_reduction_voters
        )
    )

    return insertion_points
