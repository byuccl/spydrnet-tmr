import os
import unittest
import spydrnet_tmr as sdn_TMR


class TestNMR(unittest.TestCase):
    def setUp(self) -> None:
        self.netlist = sdn_TMR.load_example_netlist_by_name('registered_inverter')

    def test_nmr_of_combinational_logic(self):
        instances_to_replicate = self.netlist.get_instances(filter=lambda x: x.reference.name.startswith("LUT"))
        ports_to_replicate = self.netlist.top_instance.get_ports('I')

        from itertools import chain
        replicas = sdn_TMR.apply_nmr(chain(instances_to_replicate, ports_to_replicate), 3, 'TMR', True)

        self.netlist.compose('registered_inverter_tmr.edf')
        self.remove_files()

    def test_nmr_of_feedback_loop(self):
        insts = list(self.netlist.get_instances(['DQ[1]_i_1', 'DQ_reg[1]']))
        replicas = sdn_TMR.apply_nmr(insts, 3, 'TMR', True)

        self.netlist.compose('registered_inverter_tmr.edf')
        self.remove_files()

    def remove_files(self):
        os.remove("registered_inverter_tmr.edf")
