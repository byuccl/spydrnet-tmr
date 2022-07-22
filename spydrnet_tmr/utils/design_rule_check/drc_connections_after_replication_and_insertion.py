import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet.util.selection import Selection
from spydrnet_tmr.utils.design_rule_check.util import find_key, get_original_name

def check_connections(original_netlist,modified_netlist,suffix,organ_names=[],write_enable=False):
    '''
    Looks at each leaf instance's pins in both netlists and finds what it drives/what drives it and makes sure corresponding instance pins between the netlists match up.

    :param original_netlist: original netlist
    :param modified_netlist: the replicated netlist. Can contain organs (voters/detectors)
    :param suffix: string appended to the replicated instances' names (e.g. 'TMR' or 'DWC')
    :param organ_name: list of names of the organs inserted into the design (e.g. ['VOTER', 'DETECTOR'])
    :param write_enable: output results to text file
    :type write_enable: bool
    :return: bool (matched, not_matched)

    For example, if the instance '**a_lut_3**' has a pin that drives the data_in port on the instance '**a_flip_flop**' in the original design, it will make sure that '**a_lut_3_TMR_0**' has a pin that drives the data_in port on '**a_flip_flop_TMR_0**' (it will check this for both TMR_1 and TMR_2 as well). **See figure below.**


    .. figure:: ../../figures/check_connections.svg
        :width: 700px
        :align: center
    '''

    class_object = DRCConnections(original_netlist,modified_netlist,suffix,organ_names,write_enable)
    print("CHECKING CONNECTIONS")
    return class_object._check_connections()


class DRCConnections():
    def __init__(self,original_netlist,modified_netlist,suffix,organ_names,write_enable):
        self.original_netlist = original_netlist
        self.modified_netlist = modified_netlist
        self.suffix = suffix
        self.write_enable =write_enable
        self.output_txt_file_name = 'drc_connection_results_'+original_netlist.name+'.txt'
        self.top_instances = [original_netlist.top_instance,modified_netlist.top_instance]
        self.organs = organ_names
        self.input_pins_todo_later = []
        self.original_instances_all = []
        self.modified_instances_all = []
        self.original_port_dict = {}
        self.modified_port_dict = {}
        self.not_matched = []
        self.organs.append('COMPLEX')

    def _check_connections(self):
        uniquify(self.original_netlist)
        self.get_instance_lists()
        self.get_pin_connections(self.original_instances_all,self.original_port_dict,self.original_netlist)
        self.get_pin_connections(self.modified_instances_all,self.modified_port_dict,self.modified_netlist)
        #self.check_pin_connections() make sure we connect to only our domain??
        self.compare_pin_connections()
        if self.not_matched:
            print("FAILED")
            return False
        else:
            print("PASSED")
            return True

    def get_instance_lists(self):
        self.original_instances_all = list(x for x in self.original_netlist.get_instances(
                                                    filter = lambda x: (
                                                    self.filter_instances(x)) is True))
        self.modified_instances_all = list(x for x in self.modified_netlist.get_instances(
                                                    filter = lambda x: (
                                                    self.filter_instances(x)) is True))

    def is_organ(self,instance):
        if any(organ in instance.name for organ in self.organs):
            return True
        return False

    def filter_instances(self,instance):
        if self.is_organ(instance):
            return False
        # elif 'GND' in instance.name:
        #     return False
        # elif 'VCC' in instance.name:
        #     return False
        else:
            return True

    def get_pin_connections(self,instance_list,current_dict,netlist):
        self.input_pins_todo_later = []
        for instance in instance_list:
            if instance.is_leaf():
                self.get_leaf_pin_connections(instance,current_dict)
            else:
                self.get_non_leaf_pin_connections(instance,current_dict)
        self.get_netlist_hport_connections(netlist,current_dict)
        self.do_pins_todo_later(current_dict)

    def get_leaf_pin_connections(self,instance,current_dict):
        key = find_key(instance,self.suffix)
        for pin in instance.get_pins(selection=Selection.OUTSIDE):
            port = pin.inner_pin.port
            if pin.wire:
                if port.direction is sdn.OUT:
                    self.get_pin_connections_helper(instance,pin,key,current_dict)
                elif port.direction is sdn.IN:
                    self.input_pins_todo_later.append((pin,key))
                else:
                    self.add_info_to_dict(pin,set('INOUT_PORT'),current_dict)
            else:
                self.add_info_to_dict(pin,set(),current_dict)

    def get_non_leaf_pin_connections(self,instance,current_dict):
        instance_item = instance
        if instance.__class__ is sdn.HRef:
            instance_item = instance.item
        for outside_pin in instance_item.get_pins(selection=Selection.OUTSIDE):
            port = outside_pin.inner_pin.port
            inner_pin = outside_pin.inner_pin
            key = find_key(port,self.suffix)
            if port.direction is sdn.IN:
                if outside_pin.inner_pin.wire:
                    pins = set(x for x in self.get_next_instances(inner_pin,key,outside_pin))
                    self.add_driver_information(instance_item,port,pins,current_dict)
            elif port.direction is sdn.OUT:
                if outside_pin.wire:
                    pins = set(x for x in self.get_next_instances(outside_pin,key,inner_pin))
                    self.add_driver_information(instance_item,port,pins,current_dict)

    def get_netlist_hport_connections(self,netlist,current_dict):
        for port in netlist.get_hports():
            if port.item.direction is sdn.IN:
                key = find_key(port.item,self.suffix)
                for pin in port.item.get_hpins():
                    if pin.item.wire:
                        pins = set(x for x in self.get_next_instances(pin.item,key))
                        self.add_driver_information(netlist.top_instance,port.item,pins,current_dict)

    def do_pins_todo_later(self,current_dict):
        for pin in self.input_pins_todo_later:
            instance = pin[0].instance
            key = pin[1]
            self.get_pin_connections_helper(instance,pin[0],key,current_dict)

    def get_pin_connections_helper(self,instance,current_pin,key,current_dict):
        port =current_pin.inner_pin.port
        if port.direction is sdn.OUT:
            pins = set(x for x in self.get_next_instances(current_pin,key))
            neighbor_pin_info = set(x.instance.name+'/'+x.inner_pin.port.name+'/'+str(x.inner_pin.port.pins.index(x.inner_pin)) for x in pins)
            self.add_info_to_dict(current_pin,neighbor_pin_info,current_dict)
            self.add_driver_information(instance,port,pins,current_dict)
        elif port.direction is sdn.IN:
            key_to_look_for = current_pin.instance.name+'/'+current_pin.inner_pin.port.name+'/'+str(current_pin.inner_pin.port.pins.index(current_pin.inner_pin))
            if current_pin.instance.parent:
                key_to_look_for = current_pin.instance.parent.name+'/'+key_to_look_for
            if key_to_look_for not in current_dict.keys():
                previous_pin_info = set(x.instance.name+'/'+x.inner_pin.port.name+'/'+str(x.inner_pin.port.pins.index(x.inner_pin)) for x in self.get_previous_instances(current_pin))
                self.add_info_to_dict(current_pin,previous_pin_info,current_dict)

    def add_driver_information(self,instance,instance_port,pins,current_dict):
        for pin in pins:
            self.add_info_to_dict(pin,[instance.name+'/'+instance_port.name+'/'+str(pin.inner_pin.port.pins.index(pin.inner_pin))],current_dict)

    def add_info_to_dict(self,pin,info,current_dict):
        dict_key = pin.instance.name+'/'+pin.inner_pin.port.name+'/'+str(pin.inner_pin.port.pins.index(pin.inner_pin))
        if pin.instance.parent:
            dict_key = pin.instance.parent.name+'/'+dict_key
        if dict_key in current_dict.keys():
            current_dict[dict_key].update(set(info))
        else:
            current_dict[dict_key] = set(info)

    def get_next_instances(self,current_pin,key,other_pin=None):
        next_instances = list(pin for pin in current_pin.wire.get_pins(selection=Selection.OUTSIDE) if (pin is not current_pin and pin.inner_pin is not other_pin))
        next_instances = self.check_next_instances(next_instances,key)
        return next_instances

    def check_next_instances(self,next_instances,key):
        to_remove = []
        to_add = []
        for i,instance_pin in enumerate(next_instances):
            instance_of_pin = instance_pin.instance
            if self.is_organ(instance_of_pin):
                organ_output_pins = list(x for x in instance_of_pin.get_pins(selection=Selection.OUTSIDE) if x.inner_pin.port.direction is sdn.OUT)
                if organ_output_pins:
                    for pin in organ_output_pins:
                        if pin.wire:
                            possible_next = self.get_organ_next(pin,key)
                            to_add = to_add + possible_next
                to_remove.append(instance_pin)
        next_instances += to_add
        next_instances = list(x for x in next_instances if not x in to_remove)
        return next_instances

    def get_organ_next(self,organ_current_pin,key):
        to_remove = []
        to_add = []
        next_instances = list(pin for pin in organ_current_pin.wire.get_pins(selection=Selection.OUTSIDE) if pin is not organ_current_pin)
        for i,instance_pin in enumerate(next_instances):
            instance_of_pin = instance_pin.instance
            if self.is_organ(instance_of_pin):
                organ_output_pins = list(x for x in instance_of_pin.get_pins(selection=Selection.OUTSIDE) if x.inner_pin.port.direction is sdn.OUT)
                if organ_output_pins:
                    for pin in organ_output_pins:
                        if pin.wire:
                            to_add += self.get_organ_next(pin,key)
                to_remove.append(instance_pin)
        next_instances += to_add
        for instance_pin in next_instances:
            instance_of_pin = instance_pin.instance
            if instance_of_pin.is_leaf():
                if key not in instance_of_pin.name and self.suffix in instance_of_pin.name:
                    to_remove.append(instance_pin)
            else:
                port = instance_pin.inner_pin.port
                wires = list(x for x in port.get_wires(selection = Selection.OUTSIDE))
                if not wires and not instance_of_pin in self.top_instances:
                    to_remove.append(instance_pin)
                else:
                    if key not in port.name and self.suffix in port.name:
                        if 'COMPLEX' not in port.name:
                            to_remove.append(instance_pin)

        next_instances = list(x for x in next_instances if not x in to_remove)
        return next_instances

    def get_previous_instances(self,current_pin):
        previous_instances = []
        to_remove = []
        to_add = []
        previous_instances = list(pin for pin in current_pin.wire.get_pins(selection=Selection.OUTSIDE) if not (pin.instance.is_leaf() and pin.inner_pin.port.direction is sdn.IN))
        for i,instance_pin in enumerate(previous_instances):
            instance_of_pin = instance_pin.instance
            if self.is_organ(instance_of_pin):
                input_pins = list(pin for pin in instance_of_pin.get_pins(selection=Selection.OUTSIDE) if pin.inner_pin.port.direction is sdn.IN)
                possible_next = []
                for pin in input_pins:
                    possible_next += self.get_organ_previous(pin)
                to_add = to_add + possible_next
                to_remove.append(instance_pin)
        previous_instances = previous_instances + to_add
        previous_instances = list(x for x in previous_instances if x not in to_remove)
        driver = self.find_driver(previous_instances,current_pin)
        return driver

    def get_organ_previous(self,current_pin):
        previous_instances = []
        previous_instances = list(pin for pin in current_pin.wire.get_pins(selection=Selection.OUTSIDE) if (pin is not current_pin and not self.is_organ(pin.instance))is True)
        return previous_instances

    def find_driver(self,instance_list,current_pin):
        driver = []
        for instance_pin in instance_list:
            instance_of_pin = instance_pin.instance
            port = instance_pin.inner_pin.port
            if instance_of_pin.is_leaf() and port.direction is sdn.OUT:
                driver.append(instance_pin)
            else:
                if instance_of_pin.reference is current_pin.instance.parent:
                    if port.direction is sdn.IN:
                        driver.append(instance_pin)
                else:
                    if port.direction is sdn.OUT:
                        driver.append(instance_pin)
        return driver

    def compare_pin_connections(self):
        f = None
        if self.write_enable:
            f = open(self.output_txt_file_name,'w')
        for key in self.modified_port_dict.keys():
            if 'GND' not in key and 'VCC' not in key:
                key_without_suffixes = get_original_name(key,self.suffix)
                try:
                    self.original_port_dict[key_without_suffixes]
                except KeyError:
                    if f:
                        f.write(key+ ' had no one to compare to\n')
                    self.not_matched.append(key)
                    continue

                list_without_suffixes = set(get_original_name(x,self.suffix) for x in self.modified_port_dict[key])
                info_to_write = key+' '+str(self.modified_port_dict[key])+'---'+str(self.original_port_dict[key_without_suffixes])+' '+key_without_suffixes+'\n'
                if list_without_suffixes == self.original_port_dict[key_without_suffixes]:
                    if f:
                        f.write("MATCH: "+info_to_write)
                else:
                    if f:
                        f.write("NOT MATCH: "+info_to_write)
                    self.not_matched.append(key)
