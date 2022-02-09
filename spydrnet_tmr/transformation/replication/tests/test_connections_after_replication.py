import os
import unittest
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.transformation.replication.nmr import apply_nmr
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter,XilinxDWCDetector
from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
from spydrnet_tmr.utils.design_rule_check.drc_connections_after_replication_and_insertion import check_connections

class TestReplicationUsingDRC(unittest.TestCase):
    '''
    Tests full TMR and DWC by replicating some small netlists and making sure each passes check_connections() in the module drc_connections_after_replication_and_insertion.
    '''
    def setUp(self):
        examples_list = ['b13','register_file','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']
        random_value = randint(0,len(examples_list)-1)
        self.example_to_test = examples_list[random_value]

    def test_tmr_using_drc_1(self):
        self.generate_netlists(self.example_to_test,3,"TMR",XilinxTMRVoter(),'VOTER')
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
        self.remove_generated_netlists(self.example_to_test)

    def test_tmr_using_drc_2(self):
        self.generate_netlists(self.example_to_test,3,"TMR",XilinxTMRVoter(),'VOTER')
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
        self.remove_generated_netlists(self.example_to_test)

    def test_tmr_using_drc_3(self):
        self.generate_netlists(self.example_to_test,3,"replicated",XilinxTMRVoter(),'random_organ')
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'replicated',['random_organ']))
        self.remove_generated_netlists(self.example_to_test)

    def test_dwc_using_drc_1(self):
        self.generate_netlists(self.example_to_test,2,"DWC",XilinxDWCDetector(),'DETECTOR')
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'DWC',['DETECTOR']))
        self.remove_generated_netlists(self.example_to_test)

    def test_dwc_using_drc_2(self):
        self.generate_netlists(self.example_to_test,2,"DWC",XilinxDWCDetector(),'DETECTOR')
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'DWC',['DETECTOR']))
        self.remove_generated_netlists(self.example_to_test)

    # def test_tmr_with_riscv_multi_core(self):
    #     self.generate_netlists('riscv_multi_core',3,"TMR",XilinxTMRVoter(),'VOTER')
    #     netlist1 = sdn.parse('riscv_multi_core.edf')
    #     netlist2 = sdn.parse('riscv_multi_core_modified.edf')
    #     self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
    #     self.remove_generated_netlists('riscv_multi_core')

    # def test_tmr_with_larger_netlist(self):
    #     self.generate_netlists('lc2',3,"TMR",XilinxTMRVoter(),'VOTER')
    #     netlist1 = sdn.parse('lc2.edf')
    #     netlist2 = sdn.parse('lc2_modified.edf')
    #     self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
    #     self.remove_generated_netlists('lc2')

    # def test_tmr_with_larger_netlist_2(self):
    #     self.generate_netlists('lc3',3,"TMR",XilinxTMRVoter(),'VOTER')
    #     netlist1 = sdn.parse('lc3.edf')
    #     netlist2 = sdn.parse('lc3_modified.edf')
    #     self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
    #     self.remove_generated_netlists('lc3')

    # def test_tmr_with_larger_netlist_2(self):
    #     self.generate_netlists('counters128',3,"TMR",XilinxTMRVoter(),'VOTER')
    #     netlist1 = sdn.parse('counters128.edf')
    #     netlist2 = sdn.parse('counters128_modified.edf')
    #     self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
    #     self.remove_generated_netlists('counters128')

    def generate_netlists(self,example_to_test,copy_amount,suffix,organ=None,organ_name=None):
        '''
        Generates netlists needed for testing by selecting a random example from a list of small netlists, replicating the design, and composing the netlist.
        '''
        netlist = sdn.load_example_netlist_by_name(example_to_test)

        uniquify(netlist)
        sdn.compose(netlist,example_to_test + ".edf")

        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        insertion_points = find_after_ff_voter_points(netlist,[*hinstances_to_replicate, *hports_to_replicate], XILINX)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], copy_amount, name_suffix=suffix, rename_original=True)
        organs = insert_organs(replicas, insertion_points, organ, organ_name)
        sdn.compose(netlist,example_to_test+"_modified.edf")

    def remove_generated_netlists(self,example_name):
        os.remove(example_name+".edf")
        os.remove(example_name+"_modified.edf")