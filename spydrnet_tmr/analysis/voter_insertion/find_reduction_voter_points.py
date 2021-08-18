"""
Find reduction voter insertion points
"""
import spydrnet as sdn


def find_reduction_voter_points(
    netlist,
    endpoints_to_replicate,
):
    """
    find_reduction_voter_points(netlist, endpoints_to_replicate)

    Find reduction voter points for a netlist *before replicating*

    When a TMR boundary consists of replicated logic going to non-replicated
    logic, a reduction voter can be placed so that the separate TMR domains from
    the replicated logic can be voted on, and the correct signal will be passed
    to the non-replicated logic. Otherwise, only the signal from the primary
    domain would be passed to the non-replicated logic, which would make the
    other TMR domains disconnected to any other logic, and useless.


    :param netlist: required.
        The netlist for which reduction voter points will be found.
    :param endpoints_to_replicate: href, Iterable - required.
        Hierarchical references to top-level ports and leaf instances that are
        to be replicated in the design.

    :return: * **insertion_points** - Pin, Iterable. Points at which voters will be placed. See insertion_points parameter in :ref:`insert_organs` for more details.

    """

    endpoints_to_replicate = set(endpoints_to_replicate)
    insertion_points = set()

    receiver_pins = find_receiver_pins_in_netlist(netlist)

    for receiver_pin in receiver_pins:
        if receiver_pin.wire is None:
            receiver_pin = receiver_pin.inner_pin
        driver_pin = find_immediate_driver_pin(receiver_pin)
        # Check if the receiver pin is a top-level output port by looking at
        # its associated instance
        if any(
            inst == netlist.top_instance
            for inst in list(receiver_pin.get_instances())
        ):
            # Check if driver port is replicated and receiver instance is NOT replicated
            if not any(
                endpoint in endpoints_to_replicate
                for endpoint in list(receiver_pin.get_hports())
            ) and any(
                endpoint in endpoints_to_replicate
                for endpoint in list(driver_pin.get_hinstances())
            ):
                insertion_points.add((driver_pin, receiver_pin))
        # Check if driver instacnce is replicated and receiver instance is NOT replicated
        elif (
            any(
                endpoint in endpoints_to_replicate
                for endpoint in list(driver_pin.get_hinstances())
            )
        ) and (
            not any(
                endpoint in endpoints_to_replicate
                for endpoint in list(receiver_pin.get_hinstances())
            )
        ):
            insertion_points.add((driver_pin, receiver_pin))
        # Check if driver is replicated and the receiver pin is not a leaf instance.
        elif (
            any(
                endpoint in endpoints_to_replicate
                for endpoint in list(driver_pin.get_hinstances())
            )
        ) and (
            not all(
                hinst.item.is_leaf() for hinst in receiver_pin.get_hinstances()
            )
        ):
            insertion_points.add((driver_pin, receiver_pin))

    print(
        "Identified {} insertion points for reduction voters.".format(
            len(insertion_points)
        )
    )

    return insertion_points


def find_receiver_pins_in_netlist(netlist):
    """
    find_receiver_pins_in_netlist(netlist)

    Find Receiver Pins in Netlist

    Receiver pins are defined as pins that are driven by one other pin. This
    function will find all such pins on all instances and top-level output
    ports.

    Parameters
    ----------
    netlist : netlist - required
        The netlist within which receiver pins are found

    Returns
    -------
    receiver_pins : Pin, Iterable
        All pins that are driven by another pin from leaf instances and
        top-level output ports
    """
    receiver_pins = set()

    # Iterate through all endpoints in the netlist
    for endpoint in [
        *netlist.get_hinstances(recursive=True),
        *netlist.get_hports(),
    ]:
        if isinstance(endpoint.item, sdn.Instance):
            if endpoint.item.is_leaf():
                for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                    if pin.inner_pin.port.direction is sdn.IN:
                        receiver_pins.add(pin)
            else:
                for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                    if pin.inner_pin.port.direction is sdn.IN:
                        receiver_pins.add(pin)
                    elif pin.inner_pin.port.direction is sdn.OUT:
                        receiver_pins.add(pin.inner_pin)

        if (
            isinstance(endpoint.item, sdn.Port)
            and endpoint.item.direction is sdn.OUT
        ):
            for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                receiver_pins.add(pin)
    return receiver_pins


def find_immediate_driver_pin(receiver_pin):
    """
    find_immediate_driver_pin(receiver_pin)

    Find the immediately connected driver pin.

    This function finds the driver pin connected to a receiver pin. A pin
    can be determined as either a driver pin or receiver pin based on
    whether it is an Inner/Outer pin, and whether it is part of an output/
    input port, as shown by the following:

    Driver Pins
    - OuterPin and output port
    - InnerPin and input port

    Receiver Pins
    - OuterPin and input port
    - InnerPin and output port

    :param primary_pin: Pin for which this function will find the
        accompanying pin.
    :param connected_pin: Pin that is connected to the primary_pin.
    """

    # Check if receiver_pin is a driver pin before trying to find a driver
    # pin associated with it
    if (
        isinstance(receiver_pin, sdn.InnerPin)
        and receiver_pin.port.direction is sdn.IN
        or isinstance(receiver_pin, sdn.OuterPin)
        and receiver_pin.inner_pin.port.direction is sdn.OUT
    ):
        print(
            "WARNING: Given pin for the receiver_pin was actually a driver pin"
        )
        return receiver_pin

    for immediate_driver_pin in receiver_pin.wire.pins:
        if isinstance(immediate_driver_pin, sdn.InnerPin) and (
            immediate_driver_pin.port.direction is sdn.IN
        ):
            return immediate_driver_pin

        if isinstance(immediate_driver_pin, sdn.OuterPin) and (
            immediate_driver_pin.inner_pin.port.direction is sdn.OUT
        ):
            return immediate_driver_pin

    return receiver_pin
