import spydrnet as sdn
from spydrnet.util.selection import Selection

def check_organs(insertion_points,organs,organ_names,suffix):
    '''
    Checks to see if organs were inserted (using :ref:`insert_organs`) correctly by checking:
       
        * are organs found where they were intended to be inserted?
        * if each organ outputs to elements in its own domain (e.g. VOTER_TMR_0 outputs to something else in TMR_0)
        * if each organ inputs from different domains (e.g. voter inputs from TMR_0, TMR_1, and TMR_2)

    :param insertion_points: list of outer pins of where organs should have been inserted
    :param organs: the dictionary returned by :ref:`insert_organs`
    :param organ_names: list of names of the organs inserted into the design (e.g. ['VOTER', 'DETECTOR'])
    :param suffix: string appended to the replicated instances' names (e.g. 'TMR')
    '''
    print("CHECKING ORGANS")
    passed = True
    if not check_if_organ_was_inserted(insertion_points,organ_names):
        passed = False
    if not check_if_organ_outputs_to_own_domain(organs,suffix):
        passed = False
    if not check_if_organ_inputs_from_each_domain(organs,suffix):
        passed = False
    if not passed:
        print("FAILED")
    else:
        print('PASSED')
    return passed

def check_if_organ_was_inserted(insertion_points,organ_names):
    okay = True
    organ_names.append('COMPLEX')
    for point in insertion_points:
        if isinstance(point,tuple):
            point = point[0]
        wire_connections = list(x.parent.parent.item.name for x in point.wire.get_hpins())
        found_organ = False
        for connection in wire_connections:
            if any(organ_name in connection for organ_name in organ_names):
                found_organ=True
        if not found_organ:
            print('WARNING: No organ found at port',point.inner_pin.port.name,'of',point.instance.name,'as expected')
            okay = False
    return okay

def check_if_organ_outputs_to_own_domain(organs,suffix):
    okay = True
    for key in organs.keys():
        for organ in organs[key]:
            key = find_key(organ,suffix)
            output_pins = list(organ.get_pins(selection = Selection.OUTSIDE,filter=lambda x:x.inner_pin.port.direction is sdn.OUT))
            next_instances = []
            for pin in output_pins:
                if pin.wire:
                    next_instances += list(pin2.instance for pin2 in pin.wire.get_pins(selection = Selection.OUTSIDE, filter = lambda x: (x is not pin)))
            for instance in next_instances:
                name = instance.name
                if key not in name and suffix in name:
                    print('WARNING:',organ.name,'outputs to',instance.name,'which is not in the organ\'s domain')
                    okay = False
    return okay

def check_if_organ_inputs_from_each_domain(organs,suffix):
    okay = True
    for insertion_point in organs.keys():
        for organ in organs[insertion_point]:
            keys = []
            previous_instances = []
            input_pins = list(organ.get_pins(selection = Selection.OUTSIDE,filter=lambda x:x.inner_pin.port.direction is sdn.IN))
            for pin in input_pins:
                if pin.wire:
                    previous_instances += list(pin2 for pin2 in pin.wire.get_pins(selection = Selection.OUTSIDE, filter =lambda x: (previous_instance_filter(x,organ)) is True))
            for instance in previous_instances:
                if instance.instance.is_leaf():
                    key = find_key(instance.instance,suffix)
                else:
                    key = find_key(instance.inner_pin.port,suffix)
                if key in keys:
                    print(key)
                    print(keys)
                    print("WARNING:",organ.name,'inputs from the same domain more than once',organ.parent.name)
                    okay = False
                    break
                else:
                    keys.append(key)
    return okay

def find_key(instance,suffix):
    start_index = instance.name.find(suffix)
    stop_index = start_index + len(suffix) + 2
    if start_index is -1:
        key = ''
    else:
        key = instance.name[start_index:stop_index]
    return key

def previous_instance_filter(current_pin,organ):
    if current_pin.instance.is_leaf() and current_pin.inner_pin.port.direction is sdn.OUT:
        return True
    elif not current_pin.instance.is_leaf():
        if current_pin.instance.reference is organ.parent and current_pin.inner_pin.port.direction is sdn.IN:
            return True
        elif current_pin.instance.reference is not organ.parent and current_pin.inner_pin.port.direction is sdn.OUT:
            return True
        else:
            return False
    else:
        return False