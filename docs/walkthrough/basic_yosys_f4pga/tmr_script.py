import os
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.transformation.replication.nmr import apply_nmr
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
from spydrnet_tmr.analysis.identify_reduction_points import identify_reduction_points
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.transformation.replication.organ import GenericEBLIFVoter
from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
from spydrnet.util.selection import Selection
from spydrnet_tmr.f4pga import fix_and_update_constraints
from spydrnet_tmr.f4pga import connect_unconn_to_dummy

def run_tmr(netlist_name, new_constraints_file=None):

   print("Attempting to replicate design using Spydrnet")

   netlist = sdn.parse(netlist_name)


   uniquify(netlist)

   #    netlist.compose("before_TMR.eblif")

   hinstances = list(x for x in netlist.get_hinstances(filter = lambda x: x.item.is_leaf()
                                                      and "VCC" not in x.name
                                                      and "GND" not in x.name
                                                      and "ibuf" not in x.name.lower()
                                                      and "IBUF" not in x.item.reference.name ))

   instances = list(x.item for x in hinstances)

   hports = list(x for x in netlist.get_hports() if x.item.direction is sdn.OUT)
   ports = list(x.item for x in hports)

   # this will return an empty set because f4pga renames primitives and spydrnet doesn't recognize them (e.g. FDRE is FDRE_ZINI)
   insertion_points = find_after_ff_voter_points(netlist, [*hinstances, *hports], XILINX)

   # so manually find the insertion points here
   for instance in netlist.get_instances():
      if "FDRE" in instance.reference.name:
            output_pin = next(pin for pin in instance.get_pins(selection=Selection.OUTSIDE,
                              filter = lambda x: x.inner_pin.port.direction is sdn.OUT))
            insertion_points.add(output_pin)

   suffix = "TMR"
   replicas = apply_nmr([*instances, *ports], 3, suffix, True)

   # check for any points needing reduction voters and add them to the insertion points set
   insertion_points_more = identify_reduction_points(replicas, suffix)
   for point in insertion_points_more:
      insertion_points.add(point)

   print("Total Insertion Points Found: " + str(len(insertion_points)))
   voters = insert_organs(replicas, insertion_points, GenericEBLIFVoter(),"VOTER",True)

   connect_unconn_to_dummy(netlist)
   if os.path.isfile(new_constraints_file):
      fix_and_update_constraints(netlist, replicas, new_constraints_file, suffix)

   netlist.compose(netlist_name,write_blackbox=False,write_eblif_cname=False)
   print("Design successfully replicated using Spydrnet")


import sys

if __name__:
    if len(sys.argv) >= 3:
        run_tmr(sys.argv[1], sys.argv[2])
    else:
        run_tmr(sys.argv[1])