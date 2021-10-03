import os
import unittest
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import insert_organs, apply_nmr
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_after_ff import find_voter_insertion_points_after_ff
from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector, XilinxTMRVoter
from spydrnet_tmr.transformation.replication.uniquify_nmr_property import uniquify_nmr_property
from spydrnet_tmr.utils.design_rule_check.drc_properties_after_replication import check_properties_after_replication

class TestDRCPropertiesAfterReplication(unittest.TestCase):
    '''
    Tests the drc_properties_after_replication function
    '''

    def setUp(self):
        examples_list = ['b13','register_file','three_stage_synchronizer','synchronizer_test','n_bit_counter','fourBitCounter','basic_clock_crossing']#,'lc2','lc3','counters128']
        random_value = randint(0,len(examples_list)-1)
        self.example = examples_list[random_value]

    def test_drc_pass(self):
        self.generate_netlists(self.example,3,"TMR",XilinxTMRVoter(),"VOTER",True)
        netlist1 = sdn.parse(self.example+".edf")
        netlist2 = sdn.parse(self.example+"_modified.edf")
        self.assertTrue(check_properties_after_replication(netlist1,netlist2,'TMR',["VOTER"],True))
        self.remove_generated_netlists(self.example)
        os.remove('drc_property_results_'+netlist1.name+'.txt')

    def test_drc_fail(self):
        self.generate_netlists(self.example,3,"TMR",XilinxTMRVoter(),"VOTER",True)
        netlist1 = sdn.parse(self.example+".edf")
        netlist2 = sdn.parse(self.example+"_modified.edf")
        random_instance = next(x for x in netlist2.get_instances() if 'EDIF.properties' in x)
        random_instance['EDIF.properties'] = [{'random properties':0000}]
        self.assertFalse(check_properties_after_replication(netlist1,netlist2,'TMR',["VOTER"],True))
        self.remove_generated_netlists(self.example)
        os.remove('drc_property_results_'+netlist1.name+'.txt')

    def test_drc_fail_2(self):
        self.example = 'b13'
        self.generate_netlists(self.example,3,"TMR",XilinxTMRVoter(),"VOTER",True)
        netlist1 = sdn.parse(self.example+".edf")
        netlist2 = sdn.parse(self.example+"_modified.edf")
        random_instance = next(x for x in netlist1.get_instances() if not 'EDIF.properties' in x)
        random_instance_in_modified = next(netlist2.get_instances(random_instance.name+'*'))
        random_instance_in_modified['EDIF.properties'] = [{'random properties':0000}]
        print(random_instance_in_modified['EDIF.properties'])
        self.assertFalse(check_properties_after_replication(netlist1,netlist2,'TMR',["VOTER"]))
        self.remove_generated_netlists(self.example)

    def test_drc_fail_3(self):
        self.generate_netlists(self.example,3,"TMR",XilinxTMRVoter(),"VOTER",True)
        netlist1 = sdn.parse(self.example+".edf")
        netlist2 = sdn.parse(self.example+"_modified.edf")
        self.assertFalse(check_properties_after_replication(netlist1,netlist2,'TMR',["organ_name"],True))
        self.remove_generated_netlists(self.example)
        os.remove('drc_property_results_'+netlist1.name+'.txt')

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
        insertion_points = find_voter_insertion_points_after_ff([*hinstances_to_replicate, *hports_to_replicate], {'FDRE', 'FDSE', 'FDPE', 'FDCE'})
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], copy_amount, name_suffix=suffix, rename_original=True)
        organs = insert_organs(replicas, insertion_points, organ, organ_name)
        if unique:
            uniquify_nmr_property(replicas, {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}, suffix)

        sdn.compose(netlist,example_to_test+"_modified.edf")

    def remove_generated_netlists(self,example_name):
        os.remove(example_name+".edf")
        os.remove(example_name+"_modified.edf")
