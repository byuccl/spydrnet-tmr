"""
Basic TMR
----------

A bare minimum use case for SpyDrNet-TMR. 

This script loads in a netlist of an inverter from SpyDrNet. Only required parameters are given to `apply_tmr_to_netlist` so default settings will be applied. Everything in the netlist will be replicated, including all top-level ports. Since there are no reduction voters required and no special voter insertion was enabled, there are no voters inserted in this design.

"""

import spydrnet as sdn
import spydrnet_tmr as sdn_tmr
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet_tmr.support_files.vendor_names import XILINX


def run():
    netlist_name = "inverter"
    netlist = sdn.load_example_netlist_by_name(netlist_name)
    apply_tmr_to_netlist(
        netlist,
        XILINX,
    )
    sdn.compose(netlist, netlist_name + "_tmr.edf")


run()
