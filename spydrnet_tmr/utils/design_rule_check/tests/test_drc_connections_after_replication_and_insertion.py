import unittest
import os
from random import randint
import spydrnet as sdn
from spydrnet.util.selection import Selection
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr,insert_organs
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter,XilinxDWCDetector
from spydrnet_tmr.utils.design_rule_check.drc_connections_after_replication_and_insertion import check_connections

class TestDRCConnectionsAfterReplicationAndInsertion(unittest.TestCase):
    '''
    Tests the drc_connections_after_replication_and_insertion check
    '''
    def setUp(self):
        examples_list = ['b13','register_file','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']#,'lc2','lc3','counters128']
        random_value = randint(0,len(examples_list)-1)
        self.example_to_test = examples_list[random_value]

    def test_drc_tmr_pass(self):
        self.generate_netlists(self.example_to_test,3,'TMR')
        netlist1 = sdn.parse(self.example_to_test+'.edf')
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'TMR'))
        self.remove_generated_netlists(self.example_to_test)

    def test_drc_tmr_pass_2(self):
        self.generate_netlists(self.example_to_test,3,'TMR',XilinxTMRVoter(),'VOTER')
        netlist1 = sdn.parse(self.example_to_test+'.edf')
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
        self.remove_generated_netlists(self.example_to_test)

    def test_drc_tmr_pass_3(self):
        self.generate_netlists('register_file',3,'TMR',XilinxTMRVoter(),'VOTER')
        netlist1 = sdn.parse('register_file'+'.edf')
        netlist2 = sdn.parse('register_file'+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER']))
        self.remove_generated_netlists('register_file')

    def test_drc_dwc_pass(self):
        self.generate_netlists(self.example_to_test,2,'DWC')
        netlist1 = sdn.parse(self.example_to_test+'.edf')
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'DWC'))
        self.remove_generated_netlists(self.example_to_test)

    def test_drc_dwc_pass_2(self):
        self.generate_netlists(self.example_to_test,3,'DWC',XilinxDWCDetector(),'DETECTOR')
        netlist1 = sdn.parse(self.example_to_test+'.edf')
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'DWC',['DETECTOR']))
        self.remove_generated_netlists(self.example_to_test)

    def test_drc_fail(self):
        self.generate_netlists(self.example_to_test,3,'TMR')
        netlist1 = sdn.parse(self.example_to_test+'.edf')
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertFalse(check_connections(netlist1,netlist2,'random_suffix'))
        self.remove_generated_netlists(self.example_to_test)

    def test_drc_fail_2(self):
        self.generate_netlists(self.example_to_test,3,'TMR',XilinxTMRVoter(),'VOTER')
        netlist1 = sdn.parse(self.example_to_test+'.edf')
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertFalse(check_connections(netlist1,netlist2,'TMR',['random_organ']))
        self.remove_generated_netlists(self.example_to_test)

    def test_drc_fail_3(self):
        self.generate_netlists('toggle',3,'TMR',XilinxTMRVoter(),'VOTER')
        netlist1 = sdn.parse('toggle.edf')
        netlist2 = sdn.parse("toggle_modified.edf")
        instance = next(x for x in netlist2.get_instances() if 'out_i_1' in x.name)
        pin = next(instance.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT))
        pin.wire.disconnect_pin(pin)
        self.assertFalse(check_connections(netlist1,netlist2,'TMR',['VOTER']))
        self.remove_generated_netlists('toggle')

    def test_drc_write_to_file(self):
        self.generate_netlists('b13',3,'TMR',XilinxTMRVoter(),'VOTER',which_side='Before')
        netlist1 = sdn.parse('b13'+'.edf')
        netlist2 = sdn.parse('b13'+"_modified.edf")
        self.assertTrue(check_connections(netlist1,netlist2,'TMR',['VOTER'],True))
        self.remove_generated_netlists('b13')
        os.remove('drc_connection_results_'+netlist1.name+'.txt')

    def test_drc_write_to_file_when_fail(self):
        self.generate_netlists(self.example_to_test,3,'TMR',XilinxTMRVoter(),'VOTER')
        netlist1 = sdn.parse(self.example_to_test+'.edf')
        netlist2 = sdn.parse(self.example_to_test+"_modified.edf")
        self.assertFalse(check_connections(netlist1,netlist2,'TMR',[],True))
        self.remove_generated_netlists(self.example_to_test)
        os.remove('drc_connection_results_'+netlist1.name+'.txt')

    def generate_netlists(self,example_to_test,copy_amount,suffix,organ=None,organ_name=None,which_side = 'after'):
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
        if which_side is 'after':
            insertion_points = find_after_ff_voter_points(netlist,[*hinstances_to_replicate, *hports_to_replicate], XILINX)
        else:
            insertion_points = find_after_ff_voter_points(netlist,[*hinstances_to_replicate, *hports_to_replicate], XILINX)
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], copy_amount, name_suffix=suffix, rename_original=True)
        if organ:
            organs = insert_organs(replicas, insertion_points, organ, organ_name)
        sdn.compose(netlist,example_to_test+"_modified.edf")

        return example_to_test

    def remove_generated_netlists(self,example_name):
        os.remove(example_name+".edf")
        os.remove(example_name+"_modified.edf")
