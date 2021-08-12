import spydrnet_tmr as sdn_shrec
from spydrnet.util.selection import Selection
from spydrnet_tmr.utils.design_rule_check.drc_connections_after_replication_and_insertion import (
    check_connections,
)
import unittest

"""
Tests the drc_connections_after_replication_and_insertion function
"""


class TestDRCConnectionsAfterReplicationAndInsertion(unittest.TestCase):
    def test_drc_pass(self):
        netlist1 = sdn_shrec.load_example_netlist_by_name("lc3_for_test")
        netlist2 = sdn_shrec.load_example_netlist_by_name(
            "lc3_modified_for_test"
        )
        assert check_connections(netlist1, netlist2, "TMR", ["VOTER"]) is True

    def test_drc_fail(self):
        netlist1 = sdn_shrec.load_example_netlist_by_name("lc3_for_test")
        netlist2 = sdn_shrec.load_example_netlist_by_name(
            "lc3_modified_for_test"
        )
        instance = next(
            netlist2.get_instances("registers_reg[7]_TMR_1[9]"), None
        )
        the_pin = None
        for pin in instance.get_pins(selection=Selection.OUTSIDE):
            the_pin = pin
            if the_pin.wire:
                break
        the_pin.wire.disconnect_pin(the_pin)
        assert check_connections(netlist1, netlist2, "TMR", ["VOTER"]) is False
