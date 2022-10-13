import spydrnet as sdn
import os

netlist = None
ports_to_replicate = None
instances_to_replicate = None

wires_to_replicate = None
additional_ports_to_replicate = None

portmap = None
instmap = None
wiremap = None

def run():
    load_netlist()
    select_ports_to_replicate()
    select_instances_to_replicate()
    assert_elements_are_unique()
    identify_wires_and_additional_ports_to_replicate()
    
    replicate_ports()
    replicate_instances()
    replicate_wires()
    
    connect_wires()
    
    # insert_voters()
    
    netlist.compose('registered_inverter_tmr.edf')
    os.remove('registered_inverter_tmr.edf')

    
def load_netlist():
    global netlist
    netlist = sdn.load_example_netlist_by_name('registered_inverter')


def select_ports_to_replicate():
    global ports_to_replicate
    ports_to_replicate = list(netlist.get_hports('I'))
    assert len(ports_to_replicate) == 1

    
def select_instances_to_replicate():
    global instances_to_replicate
    instances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.name.startswith("LUT")))
    assert len(instances_to_replicate) == 2

    
def assert_elements_are_unique():
    assert all(port.is_unique for port in ports_to_replicate)
    assert all(instance.is_unique for instance in instances_to_replicate)

    
def identify_wires_and_additional_ports_to_replicate():
    global wires_to_replicate
    global additional_ports_to_replicate
    
    # Just spark forward, spark back, take the intersect and identify the ports
    driver_pins = list()
    driver_pins += sdn.get_hpins(ports_to_replicate, filter=lambda x: x.item.port.direction in {sdn.IN, sdn.INOUT})
    driver_pins += sdn.get_hpins(instances_to_replicate, filter=lambda x: x.item.port.direction in {sdn.OUT, sdn.INOUT})
    driver_wires = set(sdn.get_hwires(driver_pins, selection="ALL"))
    
    driven_pins = list()
    driven_pins += sdn.get_hpins(ports_to_replicate, filter=lambda x: x.item.port.direction in {sdn.OUT, sdn.INOUT})
    driven_pins += sdn.get_hpins(instances_to_replicate, filter=lambda x: x.item.port.direction in {sdn.IN, sdn.INOUT})
    driven_wires = set(sdn.get_hwires(driven_pins, selection="ALL"))
    
    wires_to_replicate = driver_wires & driven_wires
    
    additional_ports_to_replicate = list(sdn.get_hports(wires_to_replicate, filter=is_hport_on_hierarchical_boundary))

def is_hport_on_hierarchical_boundary(hport):
    if hport.item.definition.is_leaf() or hport.item.definition is netlist.top_instance.reference:
        return False
    return True
    
def replicate_ports():
    global portmap
    portmap = dict()
    
    from itertools import chain
    for portref in set(chain(ports_to_replicate, additional_ports_to_replicate)):
        port = portref.item
        portmap[port] = list()
        for ii in range(1, 3):
            port_clone = port.clone()
            add_suffix_to_name(port_clone, '_TMR_' + str(ii))
            portmap[port].append(port_clone)
            port.definition.add_port(port_clone)
            
    reorder_ports_for_readability()
    
def reorder_ports_for_readability():
    reordered_definitions = set()
    for port in portmap:
        definition = port.definition
        if definition in reordered_definitions:
            continue
        reordered_definitions.add(definition)
        new_order = list()
        def_ports = definition.ports
        def_ports_len = len(def_ports)
        for def_port in def_ports:
            new_order.append(def_port)
            if def_port in portmap:
                new_order += portmap[def_port]
            if len(new_order) == def_ports_len:
                break
        definition.ports = new_order


def replicate_instances():
    global instmap
    instmap = dict()
    
    from itertools import chain
    for instref in set(instances_to_replicate):
        inst = instref.item
        instmap[inst] = list()
        for ii in range(1, 3):
            inst_clone = inst.clone()
            add_suffix_to_name(inst_clone, '_TMR_' + str(ii))
            instmap[inst].append(inst_clone)
            inst.parent.add_child(inst_clone)
            
    reorder_instances_for_readability()
    

def reorder_instances_for_readability():
    reordered_definitions = set()
    for inst in instmap:
        definition = inst.parent
        if definition in reordered_definitions:
            continue
        reordered_definitions.add(definition)
        new_order = list()
        def_children = definition.children
        def_children_len = len(def_children)
        for def_child in def_children:
            new_order.append(def_child)
            if def_child in instmap:
                new_order += instmap[def_child]
            if len(new_order) == def_children_len:
                break
        definition.children = new_order
        
        
def replicate_wires():
    global wiremap
    wiremap = dict()
    
    replicated_cables = set()
    
    actual_wires_to_replicate = set(href.item for href in wires_to_replicate)
    for wire in actual_wires_to_replicate:
        cable = wire.cable
        if cable not in replicated_cables:
            replicated_cables.add(cable)
            for ii in range(1, 3):
                cable_clone = cable.clone()
                add_suffix_to_name(cable_clone, '_TMR_' + str(ii))
                for wire_index, cable_wire in enumerate(cable.wires):
                    if cable_wire in actual_wires_to_replicate:
                        if cable_wire not in wiremap:
                            wiremap[cable_wire] = list()
                        wiremap[cable_wire].append(cable_clone.wires[wire_index])
                cable.definition.add_cable(cable_clone)

    reorder_cables_for_readibility()
    

def reorder_cables_for_readibility():
    reordered_definitions = set()
    for wire in wiremap:
        definition = wire.cable.definition
        if definition in reordered_definitions:
            continue
        reordered_definitions.add(definition)
        new_order = list()
        def_cables = definition.cables
        def_cables_len = len(def_cables)
        for def_cable in def_cables:
            new_order.append(def_cable)
            wire = next(iter(def_cable.wires))
            if wire in wiremap:
                new_order += (other_wire.cable for other_wire in wiremap[wire])
            if len(new_order) == def_cables_len:
                break
        definition.cables = new_order

def connect_wires():
    for wire, other_wires in wiremap.items():
        for pin in wire.pins:
            if isinstance(pin, sdn.InnerPin):
                port = pin.port
                if port in portmap:
                    other_ports = portmap[port]
                    pin_index = port.pins.index(pin)
                    for ii in range(2):
                        other_wires[ii].connect_pin(other_ports[ii].pins[pin_index])
            else:
                inner_pin = pin.inner_pin
                instance = pin.instance
                if instance in instmap:
                    other_instances = instmap[instance]
                    for ii in range(2):
                        other_wires[ii].connect_pin(other_instances[ii].pins[inner_pin])
                else:
                    port = inner_pin.port
                    if port in portmap:
                        other_ports = portmap[port]
                        pin_index = port.pins.index(inner_pin)
                        for ii in range(2):
                            other_wires[ii].connect_pin(instance.pins[other_ports[ii].pins[pin_index]])
                            
    pinmap = dict()
    
    for inst, other_instances in instmap.items():
        for pin in inst.pins:
            if pin.inner_pin.port.direction in {sdn.IN, sdn.INOUT}:
                wire = pin.wire
                if wire and wire not in wiremap:
                    inner_pin = pin.inner_pin
                    pinmap[pin] = list()
                    for ii in range(2):
                        other_pin = other_instances[ii].pins[inner_pin]
                        pinmap[pin].append(other_pin)
                        wire.connect_pin(other_pin)
                    
                    
    reorder_pins_for_readibility(pinmap)
    
def reorder_pins_for_readibility(pinmap):
    reordered_wires = set()
    for pin in pinmap:
        wire = pin.wire
        if wire not in reordered_wires:
            reordered_wires.add(wire)
            new_order = list()
            wire_pins = wire.pins
            wire_pins_len = len(wire_pins)
            for wire_pin in wire_pins:
                new_order.append(wire_pin)
                if wire_pin in pinmap:
                    new_order += pinmap[wire_pin]
                if len(new_order) == wire_pins_len:
                    break
            wire.pins = new_order


def add_suffix_to_name(element, suffix):
    import re
    match = re.match(r"(.+)((?:\([^\)]+\))|(?:\<[^\>]+\>)|(?:\[[^\]]+\]))$", element.name)
    if match:
        element.name = match.group(1) + suffix + match.group(2)
    else:
        element.name = element.name + suffix
    
    if 'EDIF.identifier' in element:
        match = re.match(r'(.+)(_[^_]+_)$', element['EDIF.identifier'])
        if match:
            element['EDIF.identifier'] = match.group(1) + suffix + match.group(2)
        else:
            element['EDIF.identifier'] = element['EDIF.identifier'] + suffix
    
    
if __name__ == '__main__':
    run()
