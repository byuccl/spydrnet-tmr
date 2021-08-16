import unittest
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr
from spydrnet_tmr.utils.design_rule_check.drc_apply_nmr import check_nmr

class TestDRCApplyNMR(unittest.TestCase):
    def setUp(self):
        examples_list = ['b13','register_file','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']
        random_value = randint(0,len(examples_list)-1)
        self.example_to_test = examples_list[random_value]

    def test_drc_pass(self):
        netlist = sdn.load_example_netlist_by_name(self.example_to_test)
        uniquify(netlist)
        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
        self.assertTrue(check_nmr(netlist,[*hinstances_to_replicate, *hports_to_replicate], 3, 'TMR'))

    def test_drc_pass_2(self):
        netlist = sdn.load_example_netlist_by_name('lfsr_zybo')
        uniquify(netlist)
        ignore_types = ['OBUF','OUTBUF','segment','anode','VCC','GND']
        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.is_leaf() and all(x.item.name not in ignore for ignore in ignore_types)))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports(filter = lambda x: (x.item.direction is sdn.IN and 'clk' not in x.item.name) is True))
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)

        self.assertTrue(check_nmr(netlist,[*hinstances_to_replicate, *hports_to_replicate], 3, 'TMR'),self.example_to_test)

    def test_drc_fail(self):
        netlist = sdn.load_example_netlist_by_name(self.example_to_test)
        uniquify(netlist)
        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)

        self.assertFalse(check_nmr(netlist,[], 3, 'TMR'))

    def test_drc_fail_2(self):
        netlist = sdn.load_example_netlist_by_name(self.example_to_test)
        uniquify(netlist)
        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)

        self.assertFalse(check_nmr(netlist,[*hinstances_to_replicate, *hports_to_replicate], 3, '____'))