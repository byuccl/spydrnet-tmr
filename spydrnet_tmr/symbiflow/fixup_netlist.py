import os
from spydrnet_tmr.symbiflow.fix_unconn_nets import change_unconn_to_dummy
from spydrnet_tmr.symbiflow.update_constraints import fix_and_update_constraints

'''
Single function call that will do necessary things to get netlist ready for symbiflow.
Calls change_unconn_to_dummy() and fix_and_update_constraints(). More may be added later as necessary.
'''

def fix_netlist(netlist, replicas, new_constraints_file=None, suffix="TMR"):
    fixer = Netlist_Fixer(netlist, replicas, new_constraints_file, suffix)
    fixer.run()

class Netlist_Fixer():
    def __init__(self, netlist, replicas, new_constraints_file, suffix):
        self.netlist = netlist
        self.replicas = replicas
        self.new_constraints_file = new_constraints_file
        self.suffix = suffix

    def run(self):
        change_unconn_to_dummy(self.netlist)
        if os.isfile(self.new_constraints_file):
            fix_and_update_constraints(self.netlist, self.replicas, self.new_constraints_file, self.suffix)