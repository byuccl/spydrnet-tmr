import spydrnet as sdn
from spydrnet.util.selection import Selection

def connect_unconn_to_dummy(netlist):
    '''
    Any output pins that are left unconnected are denoted in the output netlist as being connected to “unconn”. F4PGA expects all unconnected output pins to be connected to “dummy” wires. This function cycles through the netlist and connects any unconnected output pins to a dummy wire.

    :param netlist: the current netlist

    '''
    fixer = Unconn_Net_Fixer(netlist)
    fixer.run()

class Unconn_Net_Fixer():
    def __init__(self, netlist):
        self.netlist = netlist
        self.dummy_cable = None

    def run(self):
        for instance in self.netlist.get_instances():
            for pin in instance.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT):
                if not pin.wire:
                    self.connect_to_dummy(pin.wire, pin)

    def connect_to_dummy(self, wire, pin):
        if not self.dummy_cable:
            self.dummy_cable = self.netlist.top_instance.reference.create_cable(name="dummy")
        wire = self.dummy_cable.create_wire() # add a wire
        wire.connect_pin(pin) # connect it to the pin
