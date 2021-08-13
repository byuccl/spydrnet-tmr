import unittest
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet.util import selection
from spydrnet_tmr import insert_organs, apply_nmr, uniquify_nmr_property
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_after_ff import find_voter_insertion_points_after_ff
from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector
from spydrnet_tmr.transformation.surface_pins import surface_pins
from spydrnet_tmr.utils.design_rule_check.drc_surface_pins import check_surfaced_pins

class TestDRCSurfacePins(unittest.TestCase):
    '''
    Tests the DRC check for surface_pins()
    '''
    def setUp(self):
        examples_list = ['lc3','lc2']
        random_value = randint(0,len(examples_list)-1)
        example_to_test = examples_list[random_value]

        netlist = sdn.load_example_netlist_by_name(example_to_test)
        uniquify(netlist)

        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(netlist.get_hports())
        ports_to_replicate = list(x.item for x in hports_to_replicate)

        insertion_points = find_voter_insertion_points_after_ff([*hinstances_to_replicate, *hports_to_replicate], {'FDRE', 'FDSE', 'FDPE', 'FDCE'})
        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 2, name_suffix='DWC', rename_original=True)
        voters = insert_organs(replicas, insertion_points, XilinxDWCDetector(), 'DETECTOR')
        uniquify_nmr_property(replicas, {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}, "DWC")

        self.pins_to_surface = []
        for key in voters.keys():
            self.pins_to_surface += list((next(x.get_pins(selection=selection.Selection.OUTSIDE,filter=lambda x:(x.inner_pin.port.direction is sdn.OUT)))) for x in voters[key])

    def test_drc_pass(self):
        surface_pins(self.pins_to_surface)
        self.assertTrue(check_surfaced_pins(self.pins_to_surface))

    def test_drc_fail(self):
        surface_pins(self.pins_to_surface[1:3])
        self.assertFalse(check_surfaced_pins(self.pins_to_surface))

    def test_pass_no_pins(self):
        self.assertTrue(check_surfaced_pins([]))
