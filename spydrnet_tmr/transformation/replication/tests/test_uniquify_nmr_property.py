import unittest
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.transformation.replication.uniquify_nmr_property import uniquify_nmr_property
from spydrnet_tmr.utils.design_rule_check.drc_uniquify_nmr_property import check_uniquify_nmr_property
from spydrnet_tmr import apply_nmr

class TestUniquifyNmrProperty(unittest.TestCase):
    '''
    Tests uniquify_nmr_property(). Checks are done using the drc_uniquify_nmr_property
    '''
    def setUp(self):
        examples_list = ['b13','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']#,'lc2','lc3']
        random_value = randint(0,len(examples_list)-1)
        example_to_test = examples_list[random_value]

        netlist = sdn.load_example_netlist_by_name(example_to_test, force_download=True)
        uniquify(netlist)

        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)

        self.replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 2, name_suffix='TMR', rename_original=True)


    def test_uniquify_nmr_property_tmr(self):
        uniquify_nmr_property(self.replicas, {'SOFT_HLUTNM','SOFT_HLUTNM'}, 'TMR')
        self.assertTrue(check_uniquify_nmr_property(self.replicas,{'SOFT_HLUTNM','SOFT_HLUTNM'},"TMR"))

    def test_uniquify_nmr_property_tmr_2(self):
        uniquify_nmr_property(self.replicas, {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}, 'TMR')
        self.assertTrue(check_uniquify_nmr_property(self.replicas,{'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'},"TMR"))
