import unittest
import os
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet.util import selection
from spydrnet_tmr import insert_organs, apply_nmr, uniquify_nmr_property
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector
from spydrnet_tmr.transformation.surface_pins import surface_pins
from spydrnet_tmr.utils.design_rule_check.drc_surface_pins import check_surfaced_pins

class TestDRCSurfacePins(unittest.TestCase):
    '''
    Tests the DRC check for surface_pins()
    '''
    def setUp(self):
        examples_list = ['lfsr_zybo','register_file']
        random_value = randint(0,len(examples_list)-1)
        example_to_test = examples_list[random_value]

        self.netlist = sdn.load_example_netlist_by_name(example_to_test)
        uniquify(self.netlist)

        hinstances_to_replicate = list(self.netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(self.netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)

        insertion_points = find_after_ff_voter_points(self.netlist,[*hinstances_to_replicate, *hports_to_replicate],XILINX)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 2, name_suffix='DWC', rename_original=True)
        voters = insert_organs(replicas, insertion_points, XilinxDWCDetector(), 'DETECTOR')
        uniquify_nmr_property(replicas, {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}, "DWC")

        self.pins_to_surface = []
        for key in voters.keys():
            self.pins_to_surface += list((next(x.get_pins(selection=selection.Selection.OUTSIDE,filter=lambda x:(x.inner_pin.port.direction is sdn.OUT)))) for x in voters[key])

    def test_drc_pass(self):
        surface_pins(self.pins_to_surface)
        self.assertTrue(check_surfaced_pins(self.pins_to_surface,write_enable=True))
        os.remove("drc_surface_pins_results.txt")

    def test_drc_fail(self):
        some_pins_to_surface = list(x for x in self.pins_to_surface if x.instance.parent is self.netlist.top_instance)
        surface_pins(some_pins_to_surface)
        self.assertFalse(check_surfaced_pins(self.pins_to_surface,write_enable=True))
        os.remove("drc_surface_pins_results.txt")

    def test_drc_fail_2(self):
        surface_pins(self.pins_to_surface,'random_prefix')
        self.assertFalse(check_surfaced_pins(self.pins_to_surface,write_enable=True))
        os.remove("drc_surface_pins_results.txt")

    def test_pass_no_pins(self):
        self.assertTrue(check_surfaced_pins([],write_enable=True))
        os.remove("drc_surface_pins_results.txt")
