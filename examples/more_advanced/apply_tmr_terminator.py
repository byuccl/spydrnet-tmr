"""
Apply TMR Terminator
--------------------
"""
import spydrnet as sdn
import copy

properties_to_make_unique = ["SOFT_HLUTNM"]

nodes_to_replicate = None
nodes_to_vote_on = None

definition_to_instance = None
pins_to_replicate = None
wires_to_replicate = None

replicate_inst_map = None
replicate_port_map = None
replicate_cable_map = None


def run():
    print("Welcome")
    sdn.parse("g1_top_postroute_physopt_unique.edf")
    parse_nodes_to_replicate("nodes_to_replicate.txt")
    parse_nodes_to_vote_on("nodes_to_vote_on.txt")
    print("Applying TMR")
    make_sure_instances_are_unique()
    replicate_nodes()
    replicate_ports()
    replicate_cables()
    connect_cables()
    insert_voters()
    print("Composing netlist")
    compose_netlist("g1_top_postroute_physopt_5ptmr.edf")


def parse_nodes_to_replicate(filename):
    global nodes_to_replicate
    with open(filename) as fi:
        node_names = fi.read().strip().split("\n")
    nodes_to_replicate = set(sdn.get_virtual_instances(node_names))


def parse_nodes_to_vote_on(filename):
    global nodes_to_vote_on
    with open(filename) as fi:
        node_names = fi.read().strip().split("\n")
    nodes_to_vote_on = set(sdn.get_virtual_instances(node_names))


def make_sure_instances_are_unique():
    global nodes_to_replicate
    global nodes_to_vote_on
    global definition_to_instance
    unique = is_non_leaf_definitions_unique()

    if not unique:
        print("non-leaf definitions instanced more than once.")
        exit()
    else:
        print("non-leaf definitions instanced only once")
        definition_to_instance = get_def_inst_map()


def is_non_leaf_definitions_unique():
    for library in sdn.current_netlist().libraries:
        for definition in library.definitions:
            if definition.is_leaf() is False and len(definition.virtual_instances) > 1:
                return False
    return True


def get_def_inst_map():
    def_inst_map = dict()
    for library in sdn.current_netlist().libraries:
        for definition in library.definitions:
            if definition.is_leaf() is False and len(definition.virtual_instances) == 1:
                def_inst_map[definition] = next(iter(definition.virtual_instances)).instance
    return def_inst_map


def replicate_nodes(count=3, suffix='_TMR_'):
    global replicate_inst_map
    replicate_inst_map = dict()
    for node in nodes_to_replicate:
        instance = node.instance
        parent_definition = instance.parent_definition
        definition = instance.definition
        new_instances = list()
        for ii in range(1, count):
            new_instance = sdn.Instance()
            new_instance.definition = definition
            for property in instance:
                new_instance[property] = copy.deepcopy(instance[property])
            # rename
            new_suffix = suffix + str(ii)
            if 'EDIF.identifier' in new_instance:
                new_instance['EDIF.identifier'] = new_instance['EDIF.identifier'] + new_suffix
            if 'EDIF.original_identifier' in new_instance:
                new_instance['EDIF.original_identifier'] = new_instance['EDIF.original_identifier'] + new_suffix
            if 'EDIF.properties' in new_instance:
                for property in new_instance['EDIF.properties']:
                    if property['identifier'] in properties_to_make_unique:
                        property['value'] = property['value'] + new_suffix
            parent_definition.add_instance(new_instance)
            new_instances.append(new_instance)
        replicate_inst_map[instance] = new_instances


def replicate_ports(count=3, suffix="_TMR_"):
    ports_to_replicate = get_ports_to_replicate()
    global replicate_port_map
    replicate_port_map = dict()
    for port in ports_to_replicate:
        definition = port.definition
        new_ports = list()
        for ii in range(1, count):
            new_port = sdn.Port()
            new_port.direction = port.direction
            new_port.is_downto = port.is_downto
            new_port.is_scalar = port.is_scalar
            if hasattr(port, "is_array"):
                new_port.is_array = port.is_array
            new_port.lower_index = port.lower_index
            new_port.initialize_pins(len(port.inner_pins))
            for property in port:
                new_port[property] = copy.deepcopy(port[property])
            # rename
            new_suffix = suffix + str(ii)
            if 'EDIF.identifier' in new_port:
                new_port['EDIF.identifier'] = new_port['EDIF.identifier'] + new_suffix
            if 'EDIF.original_identifier' in new_port:
                new_port['EDIF.original_identifier'] = new_port['EDIF.original_identifier'] + new_suffix
            definition.add_port(new_port)
            new_ports.append(new_port)
        replicate_port_map[port] = new_ports


def get_ports_to_replicate():
    global nodes_to_replicate
    global pins_to_replicate
    instances_to_replicate = {x.instance for x in nodes_to_replicate}
    pins_to_replicate = set()
    for node in nodes_to_replicate:
        instance = node.instance
        definition = instance.definition
        for port in (x for x in definition.ports if x.direction == sdn.OUT):
            for pin in port.inner_pins:
                if pin in instance.outer_pins:
                    outer_pin = instance.outer_pins[pin]
                    search_for_pins_to_replicate(instances_to_replicate, outer_pin, pins_to_replicate)
    print("This many pins to replicate {}".format(len(pins_to_replicate)))
    ports_to_replicate = {x.port for x in pins_to_replicate}
    print("This many ports to replicate {}".format(len(ports_to_replicate)))
    return ports_to_replicate


def search_for_pins_to_replicate(instances_to_replicate, outer_pin, pins_to_replicate):
    path = list()
    search_stack = [(outer_pin, False)]
    while search_stack:
        current_pin, visited = search_stack.pop()
        if visited:
            path.pop()
            continue
        path.append(current_pin)
        search_stack.append((current_pin, True))
        current_wire = current_pin.wire
        if current_wire:
            for wire_pin in (x for x in current_wire.pins if x is not current_pin):
                if isinstance(wire_pin, sdn.InnerPin):
                    wire_pin_port = wire_pin.port
                    wire_pin_definition = wire_pin_port.definition
                    wire_pin_instance = definition_to_instance[wire_pin_definition]
                    if wire_pin in wire_pin_instance.outer_pins:
                        wire_pin_outer_pin = wire_pin_instance.outer_pins[wire_pin]
                        search_stack.append((wire_pin_outer_pin, False))
                elif isinstance(wire_pin, sdn.OuterPin):
                    wire_pin_instance = wire_pin.instance
                    if wire_pin_instance in instances_to_replicate:
                        update_pins_to_replicate(path, pins_to_replicate)
                    else:
                        wire_pin_inner_pin = wire_pin.inner_pin
                        search_stack.append((wire_pin_inner_pin, False))


def update_pins_to_replicate(path, pins_to_replicate):
    for path_pin in path[1:]:
        if isinstance(path_pin, sdn.InnerPin):
            pins_to_replicate.add(path_pin)
        elif isinstance(path_pin, sdn.OuterPin):
            path_pin_inner_pin = path_pin.inner_pin
            pins_to_replicate.add(path_pin_inner_pin)


def replicate_cables(count=3, suffix="_TMR_"):
    cables_to_replicate = get_cables_to_replicate()
    global replicate_cable_map
    replicate_cable_map = dict()
    for cable in cables_to_replicate:
        definition = cable.definition
        new_cables = list()
        for ii in range(1, count):
            new_cable = sdn.Cable()
            new_cable.is_downto = cable.is_downto
            new_cable.is_scalar = cable.is_scalar
            new_cable.lower_index = cable.lower_index
            new_cable.initialize_wires(len(cable.wires))
            for property in cable:
                new_cable[property] = copy.deepcopy(cable[property])
            # rename
            new_suffix = suffix + str(ii)
            if 'EDIF.identifier' in new_cable:
                new_cable['EDIF.identifier'] = new_cable['EDIF.identifier'] + new_suffix
            if 'EDIF.original_identifier' in new_cable:
                new_cable['EDIF.original_identifier'] = new_cable['EDIF.original_identifier'] + new_suffix
            definition.add_cable(new_cable)
            new_cables.append(new_cable)
        replicate_cable_map[cable] = new_cables


def get_cables_to_replicate():
    global nodes_to_replicate
    global wires_to_replicate
    global pins_to_replicate
    wires_to_replicate = set()
    for node in nodes_to_replicate:
        instance = node.instance
        definition = instance.definition
        for port in (x for x in definition.ports if x.direction == sdn.OUT):
            for pin in port.inner_pins:
                if pin in instance.outer_pins:
                    outer_pin = instance.outer_pins[pin]
                    wire = outer_pin.wire
                    if wire:
                        wires_to_replicate.add(wire)
    for pin in pins_to_replicate:
        wire = pin.wire
        if wire:
            wires_to_replicate.add(wire)
        if isinstance(pin, sdn.InnerPin):
            port = pin.port
            definition = port.definition
            instance = definition_to_instance[definition]
            if pin in instance.outer_pins:
                outer_pin = instance.outer_pins[pin]
                wire = outer_pin.wire
                if wire:
                    wires_to_replicate.add(wire)
        elif isinstance(pin, sdn.OuterPin):
            inner_pin = pin.inner_pin
            wire = inner_pin.wire
            if wire:
                wires_to_replicate.add(wire)
    print("This many wires to replicate {}".format(len(wires_to_replicate)))
    cables_to_replicate = {x.cable for x in wires_to_replicate}
    print("This many cables to replicate {}".format(len(cables_to_replicate)))
    return cables_to_replicate


def connect_cables():
    _connect_replicated_wires()
    _connect_split_wires()


def _connect_replicated_wires():
    global nodes_to_replicate
    global pins_to_replicate
    global wires_to_replicate
    instances_to_replicate = {x.instance for x in nodes_to_replicate}
    for wire in wires_to_replicate:
        cable = wire.cable
        wire_index = cable.wires.index(wire)
        for pin in wire.pins:
            if isinstance(pin, sdn.OuterPin):
                instance = pin.instance
                inner_pin = pin.inner_pin
                if inner_pin in pins_to_replicate:
                    port = inner_pin.port
                    pin_index = port.inner_pins.index(inner_pin)
                    for other_cable, other_port in zip(replicate_cable_map[cable], replicate_port_map[port]):
                        other_pin = other_port.inner_pins[pin_index]
                        other_outer_pin = instance.get_outer_pin(other_pin)
                        other_wire = other_cable.wires[wire_index]
                        other_wire.connect_pin(other_outer_pin)
                elif instance in instances_to_replicate:
                    for other_cable, other_instance in zip(replicate_cable_map[cable], replicate_inst_map[instance]):
                        other_outer_pin = other_instance.get_outer_pin(inner_pin)
                        other_wire = other_cable.wires[wire_index]
                        other_wire.connect_pin(other_outer_pin)
            elif isinstance(pin, sdn.InnerPin):
                if pin in pins_to_replicate:
                    port = pin.port
                    pin_index = port.inner_pins.index(pin)
                    for other_cable, other_port in zip(replicate_cable_map[cable], replicate_port_map[port]):
                        other_pin = other_port.inner_pins[pin_index]
                        other_wire = other_cable.wires[wire_index]
                        other_wire.connect_pin(other_pin)


def _connect_split_wires():
    global nodes_to_replicate
    global wires_to_replicate
    for node in nodes_to_replicate:
        instance = node.instance
        definition = instance.definition
        for port in (x for x in definition.ports if x.direction == sdn.IN):
            for pin in port.inner_pins:
                if pin in instance.outer_pins:
                    outer_pin = instance.outer_pins[pin]
                    wire = outer_pin.wire
                    if wire and wire not in wires_to_replicate:
                        for other_instance in replicate_inst_map[instance]:
                            other_pin = other_instance.get_outer_pin(pin)
                            wire.connect_pin(other_pin)


def insert_voters():
    global nodes_to_vote_on
    for node in nodes_to_vote_on:
        instance = node.instance
        definition = instance.definition
        parent_definition = instance.parent_definition
        for port in (x for x in definition.ports if x.direction == sdn.OUT):
            for pin in port.inner_pins:
                if pin in instance.outer_pins:
                    outer_pin = instance.outer_pins[pin]
                    wire = outer_pin.wire
                    if wire:
                        cable = wire.cable
                        voter_cables = list()
                        voter_cells = list()
                        for ii in range(3):
                            new_cable = sdn.Cable()
                            new_cable.is_downto = cable.is_downto
                            new_cable.is_scalar = cable.is_scalar
                            new_cable.lower_index = cable.lower_index
                            new_cable.initialize_wires(len(cable.wires))
                            for property in cable:
                                new_cable[property] = copy.deepcopy(cable[property])
                            # rename
                            new_suffix = "_TMR_VOTER_" + str(ii)
                            if 'EDIF.identifier' in new_cable:
                                new_cable['EDIF.identifier'] = new_cable['EDIF.identifier'] + new_suffix
                            if 'EDIF.original_identifier' in new_cable:
                                new_cable['EDIF.original_identifier'] = new_cable['EDIF.original_identifier'] + new_suffix
                            parent_definition.add_cable(new_cable)
                            voter_cables.append(new_cable)

                            voter = sdn.Instance()
                            voter["EDIF.identifier"] = new_cable['EDIF.identifier']
                            properties = list()
                            property = dict()
                            property["identifier"] = "INIT"
                            property["value"] = "8'hE8"
                            properties.append(property)
                            voter["EDIF.properties"] = properties
                            voter.definition = sdn.current_netlist().get_library('hdi_primitives').get_definition('LUT3')
                            parent_definition.add_instance(voter)
                            voter_cells.append(voter)
                        wire.disconnect_pin(outer_pin)
                        voter_output_pin = voter_cells[0].definition.get_port("O").inner_pins[0]
                        voter_output_outer_pin = voter_cells[0].get_outer_pin(voter_output_pin)
                        wire.connect_pin(voter_output_outer_pin)
                        voter_input_pin = voter_cells[0].definition.get_port("I0").inner_pins[0]
                        voter_wire = voter_cables[0].wires[0]
                        voter_wire.connect_pin(outer_pin)
                        for voter_cell in voter_cells:
                            voter_wire.connect_pin(voter_cell.get_outer_pin(voter_input_pin))
                        for index, other_instance in enumerate(replicate_inst_map[instance], 1):
                            other_outer_pin = other_instance.outer_pins[pin]
                            other_wire = other_outer_pin.wire
                            other_wire.disconnect_pin(other_outer_pin)
                            other_voter_output_outer_pin = voter_cells[index].get_outer_pin(voter_output_pin)
                            other_wire.connect_pin(other_voter_output_outer_pin)
                            other_voter_input_pin = voter_cells[0].definition.get_port("I"+str(index)).inner_pins[0]
                            other_voter_wire = voter_cables[index].wires[0]
                            other_voter_wire.connect_pin(other_outer_pin)
                            for other_voter_cell in voter_cells:
                                other_voter_wire.connect_pin(other_voter_cell.get_outer_pin(other_voter_input_pin))


def compose_netlist(filename):
    from spydrnet.composers.edif.composer import ComposeEdif
    composer = ComposeEdif()
    composer.run(sdn.current_netlist(), file_out=filename)


run()