from spydrnet.uniquify import uniquify
from spydrnet_shrec import apply_nmr, insert_organs
import spydrnet_shrec
from spydrnet_shrec.analysis.find_voter_insertion_points import (
    find_voter_insertion_points,
)
import spydrnet as sdn

import unittest

class TestVoterInsertion(unittest.TestCase):
    def setUp(self):
        self.netlist = sdn.load_example_netlist_by_name("b13")
        uniquify(self.netlist)
        hinstances_to_replicate = list(
            self.netlist.get_hinstances(
                recursive=True,
                filter=lambda x: x.item.reference.is_leaf() is True,
            )
        )
        # instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = list(port for port in self.netlist.get_hports())
        # ports_to_replicate = list(x.item for x in hports_to_replicate)
        self.insertion_points = find_voter_insertion_points(
            self.netlist,
            [*hinstances_to_replicate, *hports_to_replicate],
            {"FDRE", "FDSE", "FDPE", "FDCE"},
        )

    def test_insertion_points_are_pins(self):
        for pin in self.insertion_points:
            self.assertIsInstance(pin, sdn.ir.Pin)

    def test_voter_count(self):
        ff_instances = list(
            self.netlist.get_hinstances(
                recursive=True,
                filter=lambda x: x.item.reference.is_leaf() is True
                and x.item.reference.name in {"FDRE", "FDSE", "FDPE", "FDCE"},
            )
        )
        self.assertLessEqual(len(self.insertion_points), len(ff_instances))
