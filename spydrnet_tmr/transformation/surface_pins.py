import spydrnet as sdn
import spydrnet_tmr as sdn_TMR


def surface_pins(pins, name_prefix="surfaced_pin"):
    """
    Surfaces the list of given pins to the top module.

    Example: when detectors are inserted several levels deep in hierarchy, this function can bring their output pins up to the top to be connected.

    :param pins: List of pins to surface to the top module.
    :param name_prefix:
    :return: void
    """
    wireMap = dict()
    for pin_index,pin in enumerate(pins):
        original_pin = pin
        while(True):
            #get parent
            parent_def = pin.instance.parent
            #create new cable
            cable = parent_def.create_cable()
            cable.name = "%s[%d]"%(name_prefix, pin_index)
            cable['EDIF.identifier'] = "%s_%d_"%(name_prefix, pin_index)
            #create and connect wire
            wire = cable.create_wire()
            wire.connect_pin(pin)

            # get the Out pin of the parent instance
            parent_inst = next(iter(parent_def.references))

            if parent_inst.parent is None:
                wireMap[original_pin] = wire
                break


            #create port with a pin and connect it to the wire
            port = parent_def.create_port()
            port.name = "%s_%d"%(name_prefix, pin_index)
            port['EDIF.identifier'] = "%s_%d" % (name_prefix, pin_index)
            port.direction = sdn.OUT
            port_pin = port.create_pin()
            wire.connect_pin(port_pin)
            pin = parent_inst.pins[port_pin]
    return wireMap
