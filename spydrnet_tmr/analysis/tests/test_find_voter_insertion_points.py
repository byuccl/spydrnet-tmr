import unittest
import spydrnet as sdn

from spydrnet.uniquify import uniquify
from spydrnet_tmr.analysis.voter_insertion.find_before_ff_voter_points import (
    find_before_ff_voter_points,
)
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import (
    find_after_ff_voter_points,
)
from spydrnet_tmr.support_files.vendor_names import XILINX


class TestVoterInsertionBeforeFF(unittest.TestCase):
    def setUp(self):
        self.netlist = sdn.load_example_netlist_by_name("b13", force_download=True)
        uniquify(self.netlist)
        hinstances_to_replicate = self.netlist.get_hinstances(
            recursive=True,
            filter=lambda x: x.item.reference.is_leaf() is True,
        )

        hports_to_replicate = self.netlist.get_hports()

        self.insertion_points = find_before_ff_voter_points(
            self.netlist,
            [*hinstances_to_replicate, *hports_to_replicate],
            XILINX,
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
        self.assertEqual(len(self.insertion_points), len(ff_instances))


class TestVoterInsertionAfterFF(unittest.TestCase):
    def setUp(self):
        self.netlist = sdn.load_example_netlist_by_name("b13", force_download=True)
        uniquify(self.netlist)
        hinstances_to_replicate = self.netlist.get_hinstances(
            recursive=True,
            filter=lambda x: x.item.reference.is_leaf() is True,
        )

        # instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        hports_to_replicate = self.netlist.get_hports()

        self.insertion_points = find_after_ff_voter_points(
            self.netlist,
            [*hinstances_to_replicate, *hports_to_replicate],
            XILINX,
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
        self.assertEqual(len(self.insertion_points), len(ff_instances))
