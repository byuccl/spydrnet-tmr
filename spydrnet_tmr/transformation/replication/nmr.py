from spydrnet.ir import Port, Instance, InnerPin
from spydrnet_tmr.transformation.util import add_suffix_to_name
from spydrnet.util.selection import Selection
IN = Port.Direction.IN
OUT = Port.Direction.OUT
INOUT = Port.Direction.INOUT


def apply_nmr(ports_and_instances_to_replicate, degree, name_suffix='NMR', rename_original=True, verilog=False):
    """
    Replicate the selected ports and instances to the n-th degree.

    :param ports_and_instances_to_replicate:
    :param degree: number of total copies
    :param name_suffix: string to append to each replicated element (e.g. 'TMR' or 'DWC')
    :param rename_original: rename orginal domain
    :type rename_original: bool
    :return: A map from an original element to its replicas
    """
    nmr_agent = NMR.from_originals_degree_suffix_and_rename(ports_and_instances_to_replicate, degree, name_suffix,
                                                            rename_original, verilog)
    replicas = nmr_agent.apply()
    return replicas


class NMR:
    @staticmethod
    def from_originals_degree_suffix_and_rename(originals, degree, suffix, rename, verilog):
        nmr_agent = NMR(originals, degree, suffix, rename, verilog)
        return nmr_agent

    def __init__(self, originals, degree, suffix, rename, verilog):
        # Internal state
        self._applied = False
        self._wires_to_replicate = None
        self._additional_ports_to_replicate = None
        self._wiremap = None
        self._replicas = dict()
        self._verilog = verilog

        # Inputs
        for original in originals:
            # if isinstance(original, HRef):
            #     original = original.item
            if isinstance(original, (Port, Instance)):
                self._replicas[original] = None
        self.replication_degree = degree
        self.name_suffix = suffix
        self.rename_original = rename

    def apply(self):
        #self._validate_inputs()
        self._identify_additional_wires_and_ports_to_replicate()

        self._replicate_ports_and_instances()
        self._replicate_wires()

        self._connect_wires()

        return self._replicas

    def _identify_additional_wires_and_ports_to_replicate(self):
        src_pins, snk_pins = self._idenfity_src_and_snk_pins_that_will_be_replicated()
        wires_to_replicate = self.identify_additional_wires_to_replicate(src_pins, snk_pins)
        ports_to_replicate = self.identify_additional_ports_to_replicate(wires_to_replicate)        
        if self._verilog:
            for wire in self._identify_even_more_wires_to_replicate(ports_to_replicate, wires_to_replicate):
                wires_to_replicate.add(wire)

        self._wires_to_replicate = wires_to_replicate
        self._replicas.update((port, None) for port in ports_to_replicate)

    @staticmethod
    def _identify_even_more_wires_to_replicate(ports_to_replicate, wires_to_replicate):
        # for any port that will be replicated, make sure all wires connected to him are replicated as well
        # for every cable to be replicated, make sure all wires in the cable will be replicated
        # this keeps SpyDrNet happy with the Verilog netlist
        more_wires = list()
        for port in ports_to_replicate:
            # if port.direction not in {OUT, INOUT}:
            #     continue
            for pin in port.get_pins(selection=Selection.OUTSIDE):
                if not pin.wire:
                    continue
                if pin.wire not in wires_to_replicate:
                    more_wires.append(pin.wire)

        cable_set = set()
        for wire in [*wires_to_replicate, *more_wires]:
            cable_set.add(wire.cable)
        for cable in cable_set:
            for wire in cable.wires:
                if len(wire.pins) == 1 and wire not in wires_to_replicate and wire not in more_wires:
                    more_wires.append(wire)
        return more_wires

    @staticmethod
    def identify_additional_ports_to_replicate(wires_to_replicate):
        ports_to_replicate = set()
        inner_pins = set()
        outer_pins = set()
        for wire in wires_to_replicate:
            for pin in wire.pins:
                if isinstance(pin, InnerPin):
                    inner_pins.add(pin)
                else:
                    outer_pins.add(pin)
        for outer_pin in outer_pins:
            inner_pin = outer_pin.inner_pin
            if inner_pin in inner_pins:
                port = inner_pin.port
                ports_to_replicate.add(port)
                for pin in port.pins:
                    inner_pins.discard(pin)
        return ports_to_replicate

    @staticmethod
    def identify_additional_wires_to_replicate(src_pins, snk_pins):
        wires_to_replicate = set()
        wires_found = set()
        for src_pin in src_pins:
            wire = src_pin.wire
            if not wire or wire in wires_found:
                continue
            wires_found.add(wire)
            search_stack = [(wire, False)]
            while search_stack:
                wire, visited = search_stack.pop()
                if visited:
                    continue
                search_stack.append((wire, True))
                for pin in wire.pins:
                    if pin in snk_pins:
                        for path_member, part_of_path in reversed(search_stack):
                            if part_of_path is True:
                                if path_member not in wires_to_replicate:
                                    wires_to_replicate.add(path_member)
                                else:
                                    break
                    elif pin not in src_pins:
                        other_wires = pin.get_wires(selection='OUTSIDE' if isinstance(pin, InnerPin) else 'INSIDE')
                        for other_wire in other_wires:
                            if other_wire not in wires_found:
                                wires_found.add(other_wire)
                                search_stack.append((other_wire, False))
        return wires_to_replicate

    def _idenfity_src_and_snk_pins_that_will_be_replicated(self):
        src_pins = set()
        snk_pins = set()
        for original in self._replicas.keys():
            if isinstance(original, Port):
                direction = original.direction
                if direction in {IN, INOUT}:
                    src_pins.update(original.get_pins(selection='INSIDE'))
                    snk_pins.update(original.get_pins(selection='OUTSIDE'))
                if direction in {OUT, INOUT}:
                    src_pins.update(original.get_pins(selection='OUTSIDE'))
                    snk_pins.update(original.get_pins(selection='INSIDE'))
            else:
                reference = original.reference
                for port in reference.ports:
                    direction = port.direction
                    if direction in {IN, INOUT}:
                        snk_pins.update(map(original.pins.get, port.pins))
                    if direction in {OUT, INOUT}:
                        src_pins.update(map(original.pins.get, port.pins))
        return src_pins, snk_pins

    def _replicate_ports_and_instances(self):
        for original in self._replicas.keys():
            if isinstance(original, Port):
                self._replicate_port(original)
            else:
                self._replicate_instance(original)

        self._reorder_ports_for_readability()
        self._reorder_instances_for_readability()

    def _replicate_port(self, port):
        replicas = list()
        for ii in range(1, self.replication_degree):
            port_clone = port.clone()
            add_suffix_to_name(port_clone, self.name_suffix + '_' + str(ii))
            replicas.append(port_clone)
            port.definition.add_port(port_clone)
        if self.rename_original:
            add_suffix_to_name(port, self.name_suffix + '_' + '0')
        self._replicas[port] = replicas

    def _replicate_instance(self, inst):
        replicas = list()
        for ii in range(1, self.replication_degree):
            inst_clone = inst.clone()
            add_suffix_to_name(inst_clone, self.name_suffix + '_' + str(ii))
            replicas.append(inst_clone)
            inst.parent.add_child(inst_clone)
        if self.rename_original:
            add_suffix_to_name(inst, self.name_suffix + '_' + '0')
        self._replicas[inst] = replicas

    def _reorder_ports_for_readability(self):
        reordered_definitions = set()
        for original in self._replicas.keys():
            if isinstance(original, Port):
                definition = original.definition
                if definition not in reordered_definitions:
                    reordered_definitions.add(definition)
                    new_order = list()
                    def_ports = definition.ports
                    def_ports_len = len(def_ports)
                    for def_port in def_ports:
                        new_order.append(def_port)
                        if def_port in self._replicas:
                            new_order += self._replicas[def_port]
                        if len(new_order) == def_ports_len:
                            break
                    definition.ports = new_order

    def _reorder_instances_for_readability(self):
        reordered_definitions = set()
        for original in self._replicas:
            if isinstance(original, Instance):
                definition = original.parent
                if definition not in reordered_definitions:
                    reordered_definitions.add(definition)
                    new_order = list()
                    def_children = definition.children
                    def_children_len = len(def_children)
                    for def_child in def_children:
                        new_order.append(def_child)
                        if def_child in self._replicas:
                            new_order += self._replicas[def_child]
                        if len(new_order) == def_children_len:
                            break
                    definition.children = new_order

    def _replicate_wires(self):
        self._wiremap = dict()

        replicated_cables = set()

        for wire in self._wires_to_replicate:
            cable = wire.cable
            if cable not in replicated_cables:
                replicated_cables.add(cable)
                for ii in range(1, self.replication_degree):
                    cable_clone = cable.clone()
                    add_suffix_to_name(cable_clone, self.name_suffix + '_' + str(ii))
                    for wire_index, cable_wire in enumerate(cable.wires):
                        if cable_wire in self._wires_to_replicate:
                            if cable_wire not in self._wiremap:
                                self._wiremap[cable_wire] = list()
                            self._wiremap[cable_wire].append(cable_clone.wires[wire_index])
                    cable.definition.add_cable(cable_clone)
                if self.rename_original:
                    add_suffix_to_name(cable, self.name_suffix + '_' + '0')

        self._reorder_cables_for_readibility()

    def _reorder_cables_for_readibility(self):
        reordered_definitions = set()
        for wire in self._wiremap:
            definition = wire.cable.definition
            if definition not in reordered_definitions:
                reordered_definitions.add(definition)
                new_order = list()
                visited_cables = set()
                def_cables = definition.cables
                for def_cable in def_cables:
                    if def_cable in visited_cables:
                        continue
                    visited_cables.add(def_cable)
                    new_order.append(def_cable)
                    for wire in def_cable.wires:
                        if wire in self._wiremap:
                            other_cables = list(other_wire.cable for other_wire in self._wiremap[wire])
                            for other_cable in other_cables:
                                if other_cable not in visited_cables:
                                    visited_cables.add(other_cable)
                                    new_order.append(other_cable)
                definition.cables = new_order

    def _connect_wires(self):
        self._connect_replicated_wires()
        self._connect_non_replicated_wires_to_replicated_pins()

    def _connect_replicated_wires(self):
        for wire, other_wires in self._wiremap.items():
            for pin in wire.pins:
                if isinstance(pin, InnerPin):
                    port = pin.port
                    if port in self._replicas:
                        other_ports = self._replicas[port]
                        pin_index = port.pins.index(pin)
                        for ii in range(self.replication_degree - 1):
                            other_wires[ii].connect_pin(other_ports[ii].pins[pin_index])
                else:
                    inner_pin = pin.inner_pin
                    instance = pin.instance
                    if instance in self._replicas:
                        other_instances = self._replicas[instance]
                        for ii in range(self.replication_degree - 1):
                            other_wires[ii].connect_pin(other_instances[ii].pins[inner_pin])
                    else:  # TODO: if move this outside of the if does it do what we would expect?
                        port = inner_pin.port
                        if port in self._replicas:
                            other_ports = self._replicas[port]
                            pin_index = port.pins.index(inner_pin)
                            for ii in range(self.replication_degree - 1):
                                other_wires[ii].connect_pin(instance.pins[other_ports[ii].pins[pin_index]])

    def _connect_non_replicated_wires_to_replicated_pins(self):
        pinmap = dict()

        for original in self._replicas:
            if isinstance(original, Instance):
                inst = original
                other_instances = self._replicas[inst]
                for pin in inst.pins:
                    if pin.inner_pin.port.direction in {IN, INOUT}:
                        wire = pin.wire
                        if wire and wire not in self._wiremap:
                            inner_pin = pin.inner_pin
                            pinmap[pin] = list()
                            for ii in range(self.replication_degree - 1):
                                other_pin = other_instances[ii].pins[inner_pin]
                                pinmap[pin].append(other_pin)
                                wire.connect_pin(other_pin)
            elif isinstance(original, Port):
                port = original
                other_ports = self._replicas[port]
                for pin in port.pins:
                    if port.direction in {OUT, INOUT}:
                        wire = pin.wire
                        if wire and wire not in self._wiremap:
                            pin_index = pin.port.pins.index(pin)
                            pinmap[pin] = list()
                            for ii in range(self.replication_degree - 1):
                                other_pin = other_ports[ii].pins[pin_index]
                                pinmap[pin].append(other_pin)
                                wire.connect_pin(other_pin)
                
                if self._verilog:
                    # This wire drives an input port of a non leaf instance. This wire also doesn’t have a driver. So he is not replicated. 
                    # He just stays connected to that one port. But if that port is replicated, we should connect that wire to all of them so he drives all of them.
                    # This keeps SpyDrNet happy with the verilog netlist
                    if port.direction in {IN, INOUT}:
                        for pin in port.get_pins(selection=Selection.OUTSIDE):
                            if not pin.wire:
                                continue
                            if pin.wire not in self._wires_to_replicate:
                                # print(pin.wire.cable.name + " was not replicated")
                                pinmap[pin] = list()
                                for ii in range(self.replication_degree - 1):
                                    other_pin = next(other_ports[ii].get_pins(selection=Selection.OUTSIDE, filter = lambda x : x.index() == pin.index()))
                                    pinmap[pin].append(other_pin)
                                    pin.wire.connect_pin(other_pin)

        self._reorder_pins_for_readibility(pinmap)

    @staticmethod
    def _reorder_pins_for_readibility(pinmap):
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
