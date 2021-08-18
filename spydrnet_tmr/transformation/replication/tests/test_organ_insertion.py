import unittest
import os
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet.util.selection import Selection
import spydrnet_tmr as sdn_TMR
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter, XilinxDWCDetector
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.analysis.identify_reduction_points import identify_reduction_points
from spydrnet_tmr.utils.design_rule_check.drc_insert_organs import check_organs


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
        self.remove_files()

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
        self.remove_files()

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
        self.remove_files()

    def dwc_of_feedback_loop(self):
        insts = list(self.netlist.get_instances(['DQ[1]_i_1', 'DQ_reg[1]']))
        self.replicas = sdn_TMR.apply_nmr(insts, 2, 'DWC', True)

    def remove_files(self):
        os.remove("registered_inverter_tmr.edf")


class TestOrganInsertion2(unittest.TestCase):

    def setUp(self):
        self.netlist = sdn.load_example_netlist_by_name('b13')
        uniquify(self.netlist)
        ignore = ["OBUF",'OUTBUF','VCC']
        self.hinstances_to_replicate = list(self.netlist.get_hinstances(recursive=True, filter=lambda x:(x.item.reference.is_leaf() and not any(ignore_name in x.item.name for ignore_name in ignore))is True))
        self.instances_to_replicate = list(x.item for x in self.hinstances_to_replicate)
        self.hports_to_replicate = list(self.netlist.get_hports(filter=lambda x: x.item.direction is sdn.IN))
        self.ports_to_replicate = list(x.item for x in self.hports_to_replicate)
        self.replicas = None

    def test_reduction_insertion(self):
        self.replicas = apply_nmr([*self.instances_to_replicate, *self.ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
        insertion_points = identify_reduction_points(self.replicas,'TMR')
        voters = insert_organs(self.replicas, insertion_points, XilinxTMRVoter(), 'VOTER')
        self.assertTrue(check_organs(insertion_points,voters,['VOTER'],'TMR'))

    def test_input_pin_insertion(self):
        flip_flop = ['FDRE', 'FDSE', 'FDPE', 'FDCE']
        insertion_points = []
        for instance in self.netlist.get_instances():
            if instance.reference.name in flip_flop:
                input_pin = next(instance.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.IN and 'D' in x.inner_pin.port.name))
                insertion_points+= [input_pin]
        self.replicas = apply_nmr([*self.instances_to_replicate, *self.ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
        voters = insert_organs(self.replicas, insertion_points, XilinxTMRVoter(), 'VOTER')
        self.assertTrue(check_organs(insertion_points,voters,['VOTER'],'TMR'))

    def test_output_pin_insertion(self):
        flip_flop = ['FDRE', 'FDSE', 'FDPE', 'FDCE']
        insertion_points = []
        for instance in self.netlist.get_instances():
            if instance.reference.name in flip_flop:
                output_pin = next(instance.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT))
                insertion_points+= [output_pin]
        self.replicas = apply_nmr([*self.instances_to_replicate, *self.ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
        voters = insert_organs(self.replicas, insertion_points, XilinxTMRVoter(), 'VOTER')
        self.assertTrue(check_organs(insertion_points,voters,['VOTER'],'TMR'))

    def test_no_primary_output_insertion_using_reduction_points(self):
        self.replicas = apply_nmr([*self.instances_to_replicate, *self.ports_to_replicate], 2, name_suffix='DWC', rename_original=True)
        insertion_points = identify_reduction_points(self.replicas,'DWC')
        voters = insert_organs(self.replicas, insertion_points, XilinxDWCDetector(), 'DETECTOR')
        self.assertTrue(check_organs(insertion_points,voters,['DETECTOR'],'DWC'))

    def test_no_primary_output_insertion_using_output_pins(self):
        flip_flop = ['FDRE', 'FDSE', 'FDPE', 'FDCE']
        insertion_points = []
        for instance in self.netlist.get_instances():
            if instance.reference.name in flip_flop:
                output_pin = next(instance.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT))
                insertion_points+= [output_pin]
        self.replicas = apply_nmr([*self.instances_to_replicate, *self.ports_to_replicate], 2, name_suffix='DWC', rename_original=True)
        voters = insert_organs(self.replicas, insertion_points, XilinxDWCDetector(), 'DETECTOR')
        self.assertTrue(check_organs(insertion_points,voters,['DETECTOR'],'DWC'))

    def test_no_primary_output_insertion_using_input_pins(self):
        flip_flop = ['FDRE', 'FDSE', 'FDPE', 'FDCE']
        insertion_points = []
        for instance in self.netlist.get_instances():
            if instance.reference.name in flip_flop:
                input_pin = next(instance.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.IN and 'D' in x.inner_pin.port.name))
                insertion_points+= [input_pin]
        self.replicas = apply_nmr([*self.instances_to_replicate, *self.ports_to_replicate], 2, name_suffix='DWC', rename_original=True)
        voters = insert_organs(self.replicas, insertion_points, XilinxDWCDetector(), 'DETECTOR')
        self.assertTrue(check_organs(insertion_points,voters,['DETECTOR'],'DWC'))
