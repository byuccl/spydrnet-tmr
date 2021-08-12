import spydrnet_tmr as sdn_TMR
import spydrnet as sdn
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter, XilinxDWCDetector

import unittest


class TestOrganInsertion(unittest.TestCase):
    def setUp(self) -> None:
        self.netlist = sdn_TMR.load_example_netlist_by_name('registered_inverter')
        self.replicas = None

    def test_xilinx_tmr_organ_insertion(self):
        hinst = next(self.netlist.get_hinstances('PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ[1]_i_1', recursive=True))
        points = list(sdn.get_pins(hinst, selection='OUTSIDE', filter=lambda x: x.inner_pin.port.direction == sdn.OUT))

        self.nmr_of_combinational_logic()
        organs = sdn_TMR.insert_organs(self.replicas, points, XilinxTMRVoter(), 'VOTER')
        self.netlist.compose('registered_inverter_tmr.edf')

    def nmr_of_combinational_logic(self):
        instances_to_replicate = self.netlist.get_instances(filter=lambda x: x.reference.name.startswith("LUT"))
        ports_to_replicate = self.netlist.top_instance.get_ports('I')

        from itertools import chain
        self.replicas = sdn_TMR.apply_nmr(chain(instances_to_replicate, ports_to_replicate), 3, 'TMR', True)

    def test_xilinx_tmr_feedback_organ_insertion(self):
        hinst = next(self.netlist.get_hinstances('PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ_reg[1]', recursive=True))
        output_pins = list(sdn.get_pins(hinst.get_hports(filter=lambda hport: hport.item.direction is sdn.OUT),
                                        selection='OUTSIDE'))

        self.tmr_of_feedback_loop()
        organs = sdn_TMR.insert_organs(self.replicas, output_pins, XilinxTMRVoter(), 'VOTER')
        self.netlist.compose('registered_inverter_tmr.edf')

    def tmr_of_feedback_loop(self):
        insts = list(self.netlist.get_instances(['DQ[1]_i_1', 'DQ_reg[1]']))
        self.replicas = sdn_TMR.apply_nmr(insts, 3, 'TMR', True)

    def test_xilinx_dwc_feedback_organ_insertion(self):
        hinst = next(self.netlist.get_hinstances('PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ_reg[1]', recursive=True))
        output_pins = list(sdn.get_pins(hinst.get_hports(filter=lambda hport: hport.item.direction is sdn.OUT),
                                        selection='OUTSIDE'))

        self.dwc_of_feedback_loop()
        organs = sdn_TMR.insert_organs(self.replicas, output_pins, XilinxDWCDetector(), 'DETECTOR')
        self.netlist.compose('registered_inverter_tmr.edf')

    def dwc_of_feedback_loop(self):
        insts = list(self.netlist.get_instances(['DQ[1]_i_1', 'DQ_reg[1]']))
        self.replicas = sdn_TMR.apply_nmr(insts, 2, 'DWC', True)
