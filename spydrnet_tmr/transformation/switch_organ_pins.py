import spydrnet as sdn
from spydrnet.util.selection import Selection

def reorder_organ_pins(voter_map,primary_input_port_name,suffix):
    '''
    Reorders the input pins of each organ until the primary input pin is driven by the organ's own domain (i.e. at first, reg_TMR_2_VOTER's primary input is driven by reg_TMR_0, but after will be driven by reg_TMR_2). This makes the :ref:`xilinx_combined_organ` work.

    :param voter_map: the dictionary returned by the dictionary returned by :ref:`insert_organs`
    :param primary_input_port_name: name of the primary input port (e.g. 'I0')
    :param suffix: string appended to the replicated instances' names (e.g. 'TMR')
    :return: void
    '''
    for key in voter_map.keys():
        for organ in voter_map[key]:
            primary_input_pin = next(organ.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.name is primary_input_port_name),None)
            driver_of_primary_input = next(primary_input_pin.wire.get_pins(selection=Selection.OUTSIDE,filter=lambda x: (x.inner_pin.port.direction is sdn.OUT and x is not primary_input_pin)))
            key = find_key(organ,suffix)
            while key not in driver_of_primary_input.instance.name:
                reorder_pins_helper(organ)
                driver_of_primary_input = next(primary_input_pin.wire.get_pins(selection=Selection.OUTSIDE,filter=lambda x: (x.inner_pin.port.direction is sdn.OUT and x is not primary_input_pin)))

def reorder_pins_helper(organ):
    all_input_pins = []
    all_wires = []
    for pin in organ.get_pins(selection=Selection.OUTSIDE,filter=lambda x: (x.inner_pin.port.direction is sdn.IN)):
        all_input_pins.append(pin)
        all_wires.append(pin.wire)
    for i in range(len(all_input_pins)):
        all_input_pins[i].wire.disconnect_pin(all_input_pins[i])
        if i < len(all_input_pins)-1:
            all_wires[i+1].connect_pin(all_input_pins[i])
        else:
            all_wires[0].connect_pin(all_input_pins[i])

def find_key(instance,suffix):
    start_index = instance.name.find(suffix)
    stop_index = start_index + len(suffix) + 2
    if start_index == -1:
        key = ''
    else:
        key = instance.name[start_index:stop_index]
    return key
