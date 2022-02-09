import unittest
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr,uniquify_nmr_property
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.utils.design_rule_check.drc_uniquify_nmr_property import check_uniquify_nmr_property

class TestDRCUniquifyNmrProperty(unittest.TestCase):
    '''
    Tests the DRC check for uniquify_nmr_property()
    '''
    def setUp(self):
        example_name = 'b13'
        netlist = sdn.load_example_netlist_by_name(example_name)
        uniquify(netlist)
        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        self.insertion_points = find_after_ff_voter_points(netlist,[*hinstances_to_replicate, *hports_to_replicate], XILINX)
        self.replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
        self.properties = {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}

    def test_drc_pass(self):
        uniquify_nmr_property(self.replicas,self.properties, "TMR")
        self.assertTrue(check_uniquify_nmr_property(self.replicas,self.properties, "TMR"))

    def test_drc_fail(self):
        uniquify_nmr_property(self.replicas,{}, "TMR")
        self.assertFalse(check_uniquify_nmr_property(self.replicas,self.properties, "TMR"))

    def test_drc_fail_2(self):
        uniquify_nmr_property(self.replicas,self.properties, "random_suffix")
        self.assertFalse(check_uniquify_nmr_property(self.replicas,self.properties, "TMR"))
