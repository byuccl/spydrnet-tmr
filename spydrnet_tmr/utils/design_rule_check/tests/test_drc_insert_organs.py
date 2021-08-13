import unittest
import spydrnet as sdn
from spydrnet.util.selection import Selection
from spydrnet.uniquify import uniquify
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_after_ff import find_voter_insertion_points_after_ff
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
from spydrnet_tmr.utils.design_rule_check.drc_insert_organs import check_organs,check_if_organ_was_inserted,check_if_organ_inputs_from_each_domain,check_if_organ_outputs_to_own_domain

class TestDRCCInsertOrgans(unittest.TestCase):
    '''
    Tests drc_insert_organs
    '''
    def setUp(self):
        example_name = 'b13'
        netlist = sdn.load_example_netlist_by_name(example_name)
        uniquify(netlist)
        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        ff_names = {'FDRE', 'FDSE', 'FDPE', 'FDCE'}
        self.insertion_points = list(x for x in find_voter_insertion_points_after_ff([*hinstances_to_replicate, *hports_to_replicate], ff_names))
        self.replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
        self.voters = None

    def test_drc_pass(self):
        self.voters = insert_organs(self.replicas, self.insertion_points, XilinxTMRVoter(), 'VOTER')
        self.assertTrue(check_organs(self.insertion_points,self.voters,['VOTER'],'TMR'))

    def test_drc_fail(self):
        #insert at all but one spot
        self.voters = insert_organs(self.replicas, self.insertion_points[1:], XilinxTMRVoter(), 'VOTER')
        self.assertFalse(check_if_organ_was_inserted(self.insertion_points,['VOTER']))

        #change what one of the voters outputs to so it outputs to a different domain
        key = list(self.voters.keys())[0]
        voter_1 = self.voters[key][0]
        voter_2 = self.voters[key][1]
        voter_1_output = next(voter_1.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT))
        voter_2_output = next(voter_2.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT))
        voter_1_neighbors = list(x for x in voter_1_output.wire.get_pins(selection=Selection.OUTSIDE) if x is not voter_1_output)
        for pin in voter_1_neighbors:
            if pin.wire:
                pin.wire.disconnect_pin(pin)
                voter_2_output.wire.connect_pin(pin)
        self.assertFalse(check_if_organ_outputs_to_own_domain(self.voters,'TMR'))

        #change what inputs to one of the voters so it inputs from the same domain more than once
        pin_list = list(voter_1.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.IN))
        wire = pin_list[0].wire
        for pin in pin_list:
            pin.wire.disconnect_pin(pin)
            wire.connect_pin(pin)
        self.assertFalse(check_if_organ_inputs_from_each_domain(self.voters,'TMR'))

        self.assertFalse(check_organs(self.insertion_points,self.voters,['VOTER'],'TMR'))
