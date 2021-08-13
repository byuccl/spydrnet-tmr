import unittest
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.analysis.identify_reduction_points import identify_reduction_points
from spydrnet_tmr import apply_nmr


class TestIdentifyReductionPoints(unittest.TestCase):

    def setUp(self):
        self.netlist = sdn.load_example_netlist_by_name("b13")
        uniquify(self.netlist)
        hinstances_to_replicate = list(
            self.netlist.get_hinstances(
                recursive=True,
                filter=lambda x: x.item.reference.is_leaf() is True,
            )
        )
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(
            port
            for port in self.netlist.get_hports(
                filter=lambda x: x.item.direction is sdn.IN
            )
        )
        ports_to_replicate = list(x.item for x in hports_to_replicate)
        replicas = apply_nmr(
            [*instances_to_replicate, *ports_to_replicate], 3, "TMR"
        )
        self.insertion_points = identify_reduction_points(replicas, "TMR")

    def test_points_are_tuples(self):
        for pin in self.insertion_points:
            self.assertIsInstance(pin, tuple)

    def test_tuples_are_pins(self):
        for pin in self.insertion_points:
            self.assertIsInstance(pin[0],sdn.OuterPin)
            self.assertIsInstance(pin[1],frozenset)
            for sink_pin in pin[1]:
                self.assertIsInstance(sink_pin,sdn.Pin)

    def test_point_amount(self):
        self.assertEqual(len(self.insertion_points),9)
