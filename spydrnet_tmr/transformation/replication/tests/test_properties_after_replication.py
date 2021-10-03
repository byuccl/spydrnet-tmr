import os
import unittest
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_after_ff import find_voter_insertion_points_after_ff
from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector, XilinxTMRVoter
from spydrnet_tmr.utils.design_rule_check.drc_properties_after_replication import check_properties_after_replication
from spydrnet_tmr.transformation.replication.uniquify_nmr_property import uniquify_nmr_property

class TestPropertiesAfterReplication(unittest.TestCase):
    '''
    Test to make sure properties of corresponding instances are the same using 'check_properties_after_replication()' in the module drc_properties_after_replication.
    '''
    def setUp(self):
        examples_list = ['b13','register_file','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']#,'lc2','lc3']
        random_value = randint(0,len(examples_list)-1)
        self.example_to_test = examples_list[random_value]

    def test_just_triplicated(self):
        self.generate_netlists(self.example_to_test,3,"TMR")
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_properties_after_replication(netlist1,netlist2,'TMR'))
        self.remove_generated_netlists(self.example_to_test)

    def test_full_tmr(self):
        self.generate_netlists(self.example_to_test,3,"TMR",XilinxTMRVoter(),"VOTER")
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_properties_after_replication(netlist1,netlist2,'TMR',["VOTER"]))
        self.remove_generated_netlists(self.example_to_test)

    def test_full_tmr_unique_properties(self):
        self.generate_netlists(self.example_to_test,3,"TMR",XilinxTMRVoter(),"VOTER",True)
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_properties_after_replication(netlist1,netlist2,'TMR',["VOTER"]))
        self.remove_generated_netlists(self.example_to_test)

    def test_just_duplicated(self):
        self.generate_netlists(self.example_to_test,2,"DWC")
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_properties_after_replication(netlist1,netlist2,'DWC'))
        self.remove_generated_netlists(self.example_to_test)

    def test_full_dwc(self):
        self.generate_netlists(self.example_to_test,2,"DWC",XilinxDWCDetector(),"DETECTOR")
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_properties_after_replication(netlist1,netlist2,'DWC',["DETECTOR"]))
        self.remove_generated_netlists(self.example_to_test)

    def test_full_dwc_unique_properties(self):
        self.generate_netlists(self.example_to_test,2,"DWC",XilinxDWCDetector(),"DETECTOR",True)
        netlist1 = sdn.parse(self.example_to_test+".edf")
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_properties_after_replication(netlist1,netlist2,'DWC',["DETECTOR"]))
        self.remove_generated_netlists(self.example_to_test)

    def generate_netlists(self,example_to_test,copy_amount,suffix,organ=None,organ_name=None,unique=False):
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
        ff_names = {'FDRE', 'FDSE', 'FDPE', 'FDCE'}
        insertion_points = find_voter_insertion_points_after_ff([*hinstances_to_replicate, *hports_to_replicate],ff_names)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], copy_amount, name_suffix=suffix, rename_original=True)

        if organ:
            organs = insert_organs(replicas, insertion_points, organ, organ_name)
        if unique:
            uniquify_nmr_property(replicas, {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}, suffix)
        sdn.compose(netlist,example_to_test+"_modified.edf")

    def remove_generated_netlists(self,example_name):
        os.remove(example_name+".edf")
        os.remove(example_name+"_modified.edf")
