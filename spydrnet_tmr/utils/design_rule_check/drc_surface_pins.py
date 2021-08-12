from spydrnet.util.selection import Selection

def check_surfaced_pins(pins_to_surface,name_prefix='surfaced_pin',write_enable=False):
    '''
    Go through the list of pins that were intended to be surfaced and see if each was surfaced to the top module.
    
    :param pins_to_surface: Pins that were intended to be surfaced
    :param name_prefix: Name for the ports and cables created when surfacing the pins
    :param write_enable: write output to a text file
    :type write_enable: bool
    :return: True/False
    '''

    f = None
    if write_enable:
        f = open("drc_surface_pins_results.txt",'w')

    if not pins_to_surface:
        if f:
            f.write("No surfaced pins to check")
        return True

    netlist = next(pins_to_surface[0].get_netlists(),None)
    global top_instance
    top_instance = netlist.top_instance

    not_surfaced = []
    for pin in pins_to_surface:
        pin_was_surfaced = True
        if pin.instance.parent is top_instance.reference:
            continue
        elif pin.wire:
            next_pin = next(pin2 for pin2 in pin.wire.get_hpins(filter=lambda x: (x.item is not pin.inner_pin and x.item.port.direction is pin.inner_pin.port.direction)is True))
            port_name = next_pin.parent.item.name
            if name_prefix in port_name:
                if not step_up(next_pin.parent,port_name):
                    not_surfaced.append(pin)
                    pin_was_surfaced= False
            else:
                not_surfaced.append(pin)
                pin_was_surfaced= False
        else:
            not_surfaced.append(pin)
            pin_was_surfaced= False

        write_output(pin,pin_was_surfaced,f)

    if f:
        f.close()
    if not_surfaced:
        return False
    else:
        return True
    
def step_up(current_port,name):
    if current_port.parent.item.parent is top_instance.reference:
        return True
    else:
        next_wire = next(current_port.item.get_wires(selection=Selection.OUTSIDE),None)
        if next_wire:
            next_pin = next(next_wire.get_hpins(filter=lambda x: (x.parent.item is not current_port.item and x.item.port.direction is current_port.item.direction)is True),None)
            if next_pin:
                return step_up(next_pin.parent,name)
            else:
                return False
        else:
            return False

def write_output(pin,surfaced,f):
    if f:
        if surfaced:
            f.write("SURFACED: "+pin.inner_pin.port.name+' of '+pin.instance.name+'\n')
        else:
            f.write("NOT SURFACED: "+pin.inner_pin.port.name+' of '+pin.instance.name+'\n')
