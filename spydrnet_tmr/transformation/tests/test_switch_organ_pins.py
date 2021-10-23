import unittest
from random import randint
import spydrnet as sdn
from spydrnet.util.selection import Selection
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.transformation.switch_organ_pins import reorder_organ_pins
from spydrnet_tmr.transformation.replication.organ import XilinxCombinedOrgan
from spydrnet_tmr.utils.design_rule_check.drc_insert_organs import check_organs

class TestSwitchOrganPins(unittest.TestCase):

    def setUp(self):
        examples_list = ['b13','toggle','three_stage_synchronizer','synchronizer_test','n_bit_counter','lfsr_kc705','lfsr_zybo','fourBitCounter','basic_clock_crossing']
        random_value = randint(0,len(examples_list)-1)
        self.example_name = examples_list[random_value]
        self.insertion_points = None
        self.replicas = None
        self.voters = None
        self.netlist = None

    def test_switch_organ_pins_pass_drc(self):
        self.generate_netlist()
        self.assertTrue(check_organs(self.insertion_points,self.voters,['COMBINED_ORGAN'],'TMR'))
        reorder_organ_pins(self.voters,'Primary','TMR')
        self.assertTrue(check_organs(self.insertion_points,self.voters,['COMBINED_ORGAN'],'TMR'))

    def test_switch_organ_pins_primary_input(self):
        self.generate_netlist()
        reorder_organ_pins(self.voters,'Primary','TMR')
        for point in self.voters.keys():
            for organ in self.voters[point]:
                key = self.find_key(organ,'TMR')
                primary_input_pin = next(organ.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.name is 'Primary'))
                driver = next(x for x in primary_input_pin.wire.pins if x.inner_pin.port.direction is sdn.OUT)
                self.assertTrue(key in driver.instance.name)


    def generate_netlist(self):
        example_name = self.example_name
        netlist = sdn.load_example_netlist_by_name(example_name)
        uniquify(netlist)
        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        self.insertion_points = find_after_ff_voter_points(netlist,[*hinstances_to_replicate, *hports_to_replicate],XILINX)
        self.assertTrue(len(self.insertion_points) > 0,example_name)
        self.replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
        self.voters = insert_organs(self.replicas,self.insertion_points,XilinxCombinedOrgan(),'COMBINED_ORGAN')
        self.netlist = netlist

    def find_key(self,instance,suffix):
        start_index = instance.name.find(suffix)
        stop_index = start_index + len(suffix) + 2
        if start_index is -1:
            key = ''
        else:
            key = instance.name[start_index:stop_index]
        return key
