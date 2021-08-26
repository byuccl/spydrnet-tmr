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


    :param netlist: The netlist for which reduction voter points will be found.
    :type netlist: Netlist, required
    :param endpoints_to_replicate: Hierarchical references to top-level ports
        and leaf instances that are to be replicated in the design.
    :type endpoints_to_replicate: list, required
    :return: List of pin tuples at which voters will be placed. See
        insertion_points parameter in :ref:`insert_organs` for more details.
    :rtype: list
    """

    # Ensure that there are no duplicate endpoints in the list provided
    endpoints_to_replicate = set(endpoints_to_replicate)
    insertion_points = set()

    # Receiver pins are defined as pins that are connected to a driving pin.
    # This list not only includes receiver pins for leaf instances, but also for
    # non-leaf instances
    receiver_pins = find_receiver_pins_in_netlist(netlist)

    for receiver_pin in receiver_pins:
        # if receiver_pin.wire is None:
        #     receiver_pin = receiver_pin.inner_pin
        driver_pin = find_driver_pin(receiver_pin)
        # Check if the receiver pin is a top-level output port by looking at
        # its associated instance
        if any(
            inst == netlist.top_instance
            for inst in list(receiver_pin.get_instances())
        ):
            # Check if driver instance is replicated and receiver port is NOT replicated
            if any(
                endpoint in endpoints_to_replicate
                for endpoint in list(driver_pin.get_hinstances())
            ) and not any(
                endpoint in endpoints_to_replicate
                for endpoint in list(receiver_pin.get_hports())
            ):
                # Add tuple of driver/receiver pins to insertion_points. The
                # receiver pin must be on the same wire as the driver pin, so
                # some traversal upstream from the receiving pin of a leaf
                # instance (done by find_immediate_receiver_pin) may be required
                # to the correct receiver pin.
                insertion_points.add(
                    (
                        driver_pin,
                        find_immediate_receiver_pin(driver_pin, receiver_pin),
                    )
                )
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
            insertion_points.add(
                (
                    driver_pin,
                    find_immediate_receiver_pin(driver_pin, receiver_pin),
                )
            )

    print(
        "Identified {} insertion points for reduction voters.".format(
            len(insertion_points)
        )
    )

    return insertion_points


def find_immediate_receiver_pin(driver_pin, receiver_pin):
    """
    find_immediate_receiver_pin(driver_pin, receiver_pin)

    Find the immediately connected receiver pin to the driver pin.

    To place a voter, the immediately connected receiver pin to the driver pin
    must be found. The receiver pin might be further "downstream" from the
    driver pin, in which case this function can find which pin immediately
    recieves the signal from the driver pin i.e. on the same wire as the driver
    pin.

    This function finds the receiving pin on the same wire as the driver pin.
    Since the driver pin could be driving multiple pins, it is not immediately
    apparent which pin is connected to the driver pin which eventually drives
    the receiver pin, which is why the receiver_pin is a required parameter.

    :param driver_pin: Pin that sends driving signal to receiver pin
    :type driver_pin: Pin, required
    :param receiver_pin: Pin that receives signal from driver pin
    :type receiver_pin: Pin, required
    :return: Receiving pin connected to driver pin
    :rtype: Pin
    """
    immediate_driver_pin = find_immediate_driver_pin(receiver_pin)

    # If the immediate_driver_pin is the same as the driver_pin provided, then
    # the receiver pin must be the immediate receiver pin.
    if immediate_driver_pin is driver_pin:
        return receiver_pin

    # Since the immediate_driver_pin is not the same as the driver_pin provided,
    # then look upstream from the immediate_driver_pin and run this function
    # recursively
    if isinstance(immediate_driver_pin, sdn.InnerPin):
        next_upstream_receiver_pin = list(
            immediate_driver_pin.get_pins(selection=sdn.OUTSIDE)
        )[0]
        return find_immediate_receiver_pin(
            driver_pin, next_upstream_receiver_pin
        )

    next_upstream_receiver_pin = list(immediate_driver_pin.get_pins())[0]
    return find_immediate_receiver_pin(driver_pin, next_upstream_receiver_pin)


def find_receiver_pins_in_netlist(netlist):
    """
    find_receiver_pins_in_netlist(netlist)

    Find Receiver Pins in Netlist

    Receiver pins are defined as pins that are driven by one other pin. This
    function will find all such pins on all instances and top-level output
    ports.

    :param netlist: The netlist within which receiver pins are found
    :type netlist: Netlist, required
    :return: A list of all pins that are driven by another pin from instances
        and top-level output ports
    :rtype: list
    """
    receiver_pins = set()

    # Iterate through all endpoints in the netlist
    for endpoint in [
        *netlist.get_hinstances(
            recursive=True,
            filter=lambda x: x.item.is_leaf(),
        ),
        *netlist.get_hports(),
    ]:
        if isinstance(endpoint.item, sdn.Instance):
            for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                if pin.inner_pin.port.direction is sdn.IN:
                    receiver_pins.add(pin)

        if (
            isinstance(endpoint.item, sdn.Port)
            and endpoint.item.direction is sdn.OUT
        ):
            for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                if pin.wire is None:
                    receiver_pins.add(pin.inner_pin)
                else:
                    receiver_pins.add(pin)
    return receiver_pins


def find_driver_pin(receiver_pin):
    """
    find_driver_pin(receiver_pin)

    Find the connected driver pin.

    This function finds the driver pin connected to a receiver pin. If the
    driver pin is not from a leaf instance, then this function will traverse
    "upstream" from the receiving pin until the "true" driver is found from a
    leaf instance.

    :param receiver_pin: Pin for which this function will find the accompanying pin.
    :type receiver_pin: Pin, required
    :return: Pin that drives the receiver pin
    :rtype: Pin
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
        if isinstance(immediate_driver_pin, sdn.OuterPin) and (
            immediate_driver_pin.inner_pin.port.direction is sdn.OUT
        ):
            if immediate_driver_pin.instance.is_leaf():
                return immediate_driver_pin
            return find_driver_pin(list(immediate_driver_pin.get_pins())[0])
        if isinstance(immediate_driver_pin, sdn.InnerPin) and (
            immediate_driver_pin.port.direction is sdn.IN
        ):
            if any(
                inst.parent is None
                for inst in list(immediate_driver_pin.get_instances())
            ):
                return immediate_driver_pin
            # outer_immediate_driver_pin = immediate_driver_pin
            return find_driver_pin(
                list(immediate_driver_pin.get_pins(selection=sdn.OUTSIDE))[0]
            )

    return receiver_pin


def find_immediate_driver_pin(receiver_pin):
    """
    find_immediate_driver_pin(receiver_pin)

    Find the immediately connected driver pin.

    This function finds the immediate driver pin connected to a receiver pin.
    The immediate driver pin is a part of the same wire as the receiver pin.

    A pin can be determined as either a driver pin or receiver pin based on
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
    :type primary_pin: Pin
    :returns: Immediate pin that drives the receiver pin
    :rtype: Pin
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

    # Find the driving pin connected to the receiver pin.
    for immediate_driver_pin in receiver_pin.wire.pins:
        # Check if InnerPin and input port
        if isinstance(immediate_driver_pin, sdn.InnerPin) and (
            immediate_driver_pin.port.direction is sdn.IN
        ):
            return immediate_driver_pin
        # Check if OuterPin and output port
        if isinstance(immediate_driver_pin, sdn.OuterPin) and (
            immediate_driver_pin.inner_pin.port.direction is sdn.OUT
        ):
            return immediate_driver_pin

    return receiver_pin
