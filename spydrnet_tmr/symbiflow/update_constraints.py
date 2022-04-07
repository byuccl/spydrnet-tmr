import spydrnet as sdn
from spydrnet.util.selection import Selection
from copy import deepcopy

'''
Update the replicated port parameters to reflect correct constraint values. Otherwise, all three domain ports will be constrained to the same pin and symbiflow will fail.
'''

def fix_and_update_constraints(netlist, replicas, input_file, suffix="TMR"):
    updater = Constraints_Fixer(netlist, replicas, input_file, suffix)
    updater.fix_constraints()

class Constraints_Fixer():
    def __init__(self, netlist, replicas, input_file, suffix):
        self.netlist = netlist
        self.replicas = replicas
        self.input_file = input_file
        self.suffix = suffix
        self.constraint_dict = dict()
        self.pinmap = dict()
    
    def fix_constraints(self):
        self.deepcopy_replicated_parameters()
        self.fix_replicated_parameters()
        self.read_input_file()
        self.create_pinmap()
        self.update_constraints()

    def deepcopy_replicated_parameters(self): # spydrnet clone doesn't copy inside the EBLIF.param dict, so manually do it here
        for key in self.replicas.keys():
            if "EBLIF.param" in key.data:
                param_info = key["EBLIF.param"]
                for instance in self.replicas[key]:
                    new_param_info = deepcopy(param_info)
                    instance["EBLIF.param"] = new_param_info

    def fix_replicated_parameters(self):
        # if the parameter has a name to the original, non replicated thing, change it the replicated thing
        port_names = self.get_replicated_port_names()
        for instance in self.netlist.get_instances():
            if "EBLIF.param" in instance.data:
                for parameter_key in instance["EBLIF.param"]:
                    param_info = instance["EBLIF.param"][parameter_key]
                    for name_of_port in port_names:
                        start_index = param_info.find(name_of_port)
                        if start_index != -1:
                            own_key = self.get_replica_domain(instance)
                            new_param_info = param_info[:start_index] + name_of_port + "_" + own_key + param_info[start_index+len(name_of_port):]
                            instance["EBLIF.param"][parameter_key] = new_param_info

    def get_replicated_port_names(self):
        port_names = list()
        for key in self.replicas.keys():
            if key.__class__ is sdn.ir.Port:
                port_names.append(self.get_original_name(key))
        return port_names

    def get_original_name(self, instance):
        start = instance.name.find(self.suffix)
        if start != -1:
            original_name = instance.name[:start-1] + instance.name[start+5:]
            return original_name

    def get_replica_domain(self, instance): # TMR_0, TMR_1 etc
        start_index = instance.name.find(self.suffix)
        stop_index = start_index + len(self.suffix) + 2
        if start_index is -1:
            key = ''
        else:
            key = instance.name[start_index:stop_index]
        return key
    
    def read_input_file(self):
        with open(self.input_file, "r") as f:
            for line in f.readlines():
                words = line.split()
                self.constraint_dict[words[0]] = words[1]

    def create_pinmap(self): # map from top level port to instance immediately connected to it (should be a buffer)
        for port in self.netlist.get_hports():
            if port.item.direction is sdn.IN:
                for pin in port.item.pins:
                    if pin.wire:
                        wire_name = self.get_wire_name_2(port.item, pin.wire)
                        driven_instance = next(driven_pin.instance for driven_pin in pin.wire.pins if driven_pin is not pin)
                        self.pinmap[wire_name] = driven_instance
                    # else:
                        # print("no wire for "+ port.name)
            else:
                for pin in port.item.pins:
                    if pin.wire:
                        wire_name = self.get_wire_name_2(port.item, pin.wire)
                        driven_instance = next(driven_pin.instance for driven_pin in pin.wire.pins if self.is_driver_pin_of_output_port(driven_pin))
                        self.pinmap[wire_name] = driven_instance
        # print(self.pinmap)

        # OLD
        # for instance in self.netlist.get_instances():
        #     for pin in instance.get_pins(selection=Selection.OUTSIDE, filter = lambda x: x.inner_pin.port.direction is sdn.OUT):
        #         if pin.wire:
        #             wire_name = self.get_wire_name(pin.wire)
        #             self.pinmap[wire_name] = instance

    def is_driver_pin_of_output_port(self, pin):
        if pin.__class__ is sdn.OuterPin:
            if pin.inner_pin.port.direction is sdn.OUT:
                return True


    # def get_wire_name(self, wire):
    #     cable = wire.cable
    #     wire_index = wire.cable.wires.index(wire)
    #     wire_name = cable.name + "[" + str(wire_index) + "]"
    #     return wire_name
    
    def get_wire_name_2(self, port, wire):
        cable = wire.cable
        wire_index = wire.cable.wires.index(wire)
        if len(cable.wires) > 1:
            wire_name = port.name + "[" + str(wire_index) + "]"
        else:
            wire_name = port.name
        return wire_name

    def update_constraints(self):
        for driven_wire in self.constraint_dict.keys():
            instance = self.find_instance(driven_wire)
            parameter = self.find_parameter(instance, driven_wire)
            if parameter:
                self.update_parameter(instance, driven_wire, parameter)

    def find_instance(self, driven_wire):
        try:
            self.pinmap[driven_wire]
        except KeyError:
            self.pinmap[driven_wire] = None
        if self.pinmap[driven_wire]:
            instance = self.pinmap[driven_wire]
            return instance
    
    def find_parameter(self, instance, driven_wire):
        # print(driven_wire)
        try:
            instance["EBLIF.param"]
        except KeyError:
            instance["EBLIF.param"] = dict()
        for parameter in instance["EBLIF.param"].keys():
            param_info = instance["EBLIF.param"][parameter]
            if driven_wire in param_info:
                return parameter
        return None

    def update_parameter(self, instance, driven_wire, parameter):
        original_param_info = instance["EBLIF.param"][parameter]
        new_param_info = "\"" + driven_wire + ":" + self.constraint_dict[driven_wire] + "\""
        instance["EBLIF.param"][parameter] = new_param_info
        # print(instance.name + " now has the parameter " + new_param_info)