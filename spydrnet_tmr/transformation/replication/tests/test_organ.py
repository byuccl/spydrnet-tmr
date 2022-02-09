import unittest
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.transformation.replication.organ import JTAG, StickyDWCDetector, XilinxCombinedOrgan, XilinxTMRVoter, XilinxDWCDetector
from spydrnet_tmr import apply_nmr, insert_organs

from spydrnet_tmr.utils.design_rule_check.drc_insert_organs import check_organs

class TestOrgan(unittest.TestCase):
    """
    Make sure no errors arise when instancing and inserting each type of organ
    """
    def setUp(self):
        examples_list = ['b13','register_file','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']#,'lc2','lc3']
        random_value = randint(0,len(examples_list)-1)
        self.example_to_test = examples_list[random_value]
        self.replicas = None
        self.insertion_points = None

    def test_insert_voter(self):
        self.generate_netlists(self.example_to_test,3,'TMR')
        insert_organs(self.replicas,self.insertion_points,XilinxTMRVoter(),'VOTER')

    def test_insert_xilinx_detector(self):
        self.generate_netlists(self.example_to_test,2,'DWC')
        insert_organs(self.replicas,self.insertion_points,XilinxDWCDetector(),'DETECTOR')

    def test_insert_sticky_detector(self):
        self.generate_netlists(self.example_to_test,2,'DWC')
        organs = insert_organs(self.replicas,self.insertion_points,StickyDWCDetector(),'DETECTOR')
        self.assertTrue(check_organs(self.insertion_points,organs,['DETECTOR'],'DWC'))

    def test_insert_combined_organ(self):
        self.generate_netlists(self.example_to_test,3,'TMR')
        organs = insert_organs(self.replicas,self.insertion_points,XilinxCombinedOrgan(),'Combined')
        self.assertTrue(check_organs(self.insertion_points,organs,['Combined'],'TMR'))


    def generate_netlists(self,example_to_test,copy_amount,suffix):
        '''
        Generates netlists needed for testing by selecting a random example from a list of small netlists, replicating the design, and composing the netlist.
        '''
        netlist = sdn.load_example_netlist_by_name(example_to_test)
        uniquify(netlist)

        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        self.insertion_points = find_after_ff_voter_points(netlist,[*hinstances_to_replicate, *hports_to_replicate], XILINX)
        self.replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], copy_amount, name_suffix=suffix, rename_original=True)

        return example_to_test
