"""
Find reduction voter insertion points
"""
import spydrnet as sdn
from spydrnet.util.get_hports import get_hports


def find_reduction_voter_points(
    netlist,
    endpoints_to_replicate,
):

    endpoints_to_replicate = set(endpoints_to_replicate)
    insertion_points = set()

    def find_immediate_driver_pin(receiver_pin):
        """
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
            and any(
                port.direction is sdn.IN
                for port in [x for x in receiver_pin.get_ports()]
            )
            or isinstance(receiver_pin, sdn.OuterPin)
            and any(
                port.direction is sdn.OUT
                for port in [x for x in receiver_pin.get_ports()]
            )
        ):
            print(
                "WARNING: Given pin for the receiver_pin was actually a driver pin"
            )
            return receiver_pin

        for immediate_driver_pin in receiver_pin.wire.pins:
            if isinstance(immediate_driver_pin, sdn.InnerPin) and any(
                port.direction is sdn.IN
                for port in [x for x in immediate_driver_pin.get_ports()]
            ):
                return immediate_driver_pin

            if isinstance(immediate_driver_pin, sdn.OuterPin) and any(
                port.direction is sdn.OUT
                for port in [x for x in immediate_driver_pin.get_ports()]
            ):
                return immediate_driver_pin

        return

    all_endpoints = [
        *netlist.get_hinstances(
            # recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
            recursive=True
        ),
        *netlist.get_hports(),
    ]

    receiver_pins = set()
    for endpoint in [
        *netlist.get_hinstances(
            # recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
            recursive=True
        ),
        *netlist.get_hports(),
    ]:
        # Receiver pins are all pins (outer/inner) that are driven by one other
        # pin. For top-level ports, only output ports have receiving pins.

        if isinstance(endpoint.item, sdn.Instance):
            for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                if any(
                    hport.item.direction is sdn.IN
                    for hport in pin.get_hports()
                ):
                    receiver_pins.add(pin)
        if (
            isinstance(endpoint.item, sdn.Port)
            and endpoint.item.direction is sdn.OUT
        ):
            for pin in endpoint.item.get_pins(selection=sdn.OUTSIDE):
                receiver_pins.add(pin)

    for receiver_pin in receiver_pins:
        if receiver_pin.wire is None:
            receiver_pin = receiver_pin.inner_pin
        driver_pin = find_immediate_driver_pin(receiver_pin)
        print(driver_pin)
        if any(
            inst == netlist.top_instance
            for inst in [inst for inst in receiver_pin.get_instances()]
        ):
            if not any(
                endpoint in endpoints_to_replicate
                for endpoint in [hport for hport in receiver_pin.get_hports()]
            ) and any(
                endpoint in endpoints_to_replicate
                for endpoint in [
                    hinst for hinst in driver_pin.get_hinstances()
                ]
            ):
                insertion_points.add(receiver_pin)
        elif (
            any(
                endpoint in endpoints_to_replicate
                for endpoint in [
                    *[hinst for hinst in driver_pin.get_hinstances()],
                ]
            )
        ) and (
            not any(
                endpoint in endpoints_to_replicate
                for endpoint in [
                    *[hinst for hinst in receiver_pin.get_hinstances()],
                ]
            )
        ):
            insertion_points.add(receiver_pin)

    print(
        "Identified {} insertion points for reduction voters.".format(
            len(insertion_points)
        )
    )

    return insertion_points
