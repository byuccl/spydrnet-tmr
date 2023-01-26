import unittest
import spydrnet as sdn
from spydrnet.util.selection import Selection
from spydrnet.util.netlist_type import EBLIF
from spydrnet_tmr.f4pga.fix_unconn_nets import connect_unconn_to_dummy

class TestFixUnconnNets(unittest.TestCase):
    def setUp(self):
        self.netlist = sdn.load_example_netlist_by_name("synchronouscounter_nocarry", EBLIF)
        self.unconn_pins = list()
        for instance in self.netlist.get_instances():
            for pin in instance.get_pins(selection=Selection.OUTSIDE, filter=lambda x: x.inner_pin.port.direction is sdn.OUT):
                if pin.wire:
                    pin.wire.disconnect_pin(pin)
                    self.unconn_pins.append(pin)
    
    def test_connect_unconn_to_dummy(self):
        self.assertGreater(len(self.unconn_pins), 0)
        connect_unconn_to_dummy(self.netlist)
        for pin in self.unconn_pins:
            self.assertIsNotNone(pin.wire)
            self.assertTrue("dummy" in pin.wire.cable.name)