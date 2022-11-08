import os
import unittest
import spydrnet as sdn
from spydrnet.util.selection import Selection
from spydrnet.util.netlist_type import EBLIF
from spydrnet_tmr.f4pga.update_constraints import fix_and_update_constraints
from spydrnet_tmr import apply_nmr

class TestUpdateConstraints(unittest.TestCase):
    def setUp(self):
        self.netlist = sdn.load_example_netlist_by_name("synchronouscounter_nocarry", EBLIF)
        self.instance = next(self.netlist.get_instances(filter=lambda x: self.filter(x)))
        constraint_info = "\"count[0]:U17\""
        try: 
            self.instance["EBLIF.param"]
        except KeyError:
            self.instance["EBLIF.param"] = dict()
        self.instance["EBLIF.param"]["constraint_info"] = constraint_info

        self.replicate_design()
        self.create_new_constraint_file()

    def tearDown(self):
        os.remove(self.constraint_file_name)
        super().tearDown()
    
    def filter(self, instance):
        for pin in instance.get_pins(selection=Selection.OUTSIDE, filter=lambda x: x.inner_pin.port.direction is sdn.OUT):
            if pin.wire:
                wire_index = pin.wire.cable.wires.index(pin.wire)
                if pin.wire.cable.name == "count" and wire_index == 0:
                    print("YES")
                    return True
        return False

    def replicate_design(self):
        hinstances = list(x for x in self.netlist.get_hinstances())
        instances = list(x.item for x in hinstances)

        self.hports = list(x for x in self.netlist.get_hports())
        ports = list(x.item for x in self.hports)

        self.suffix = "TMR"
        self.replicas = apply_nmr([*instances, *ports], 3, self.suffix, True)

    def create_new_constraint_file(self):
        self.constraint_file_name = "constraint_new.txt"
        f = open(self.constraint_file_name, "w")
        f.write("count_TMR_0[0] U17\n")
        f.write("count_TMR_1[0] W12\n")
        f.write("count_TMR_2[0] V16\n")
        f.close()

    def test(self):
        self.assertTrue(len(self.hports) > 0)

        # make sure all constraints are needing to be fixed
        for replicated_instance in self.replicas[self.instance]:
            constraint_info = replicated_instance["EBLIF.param"]["constraint_info"]
            self.assertEqual(constraint_info, "\"count[0]:U17\"")

        # fix the constraints
        fix_and_update_constraints(self.netlist, self.replicas, self.constraint_file_name, self.suffix)

        #make sure constraints were fixed
        zero = "\"count_TMR_0[0]:U17\""
        one = "\"count_TMR_1[0]:W12\""
        two = "\"count_TMR_2[0]:V16\""
        constraint_list = [zero, one, two]
        list_size = 3
        for replicated_instance in self.replicas[self.instance]:
            constraint_info = replicated_instance["EBLIF.param"]["constraint_info"]
            self.assertNotEqual(constraint_info, "\"count[0]:U17\"")
            self.assertTrue(constraint_info in constraint_list)
            self.assertTrue(list_size == len(constraint_list))
            list_size-=1
            constraint_list.remove(constraint_info)
