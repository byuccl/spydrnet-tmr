'''
nexys4ddr
==========

The following is a script that was used to triplicate and insert voters into the SpyDrNet SHREC example netlist 'nexys4ddr'. This netlist is a RISC-V processor running on the Nexys4 DDR board. Due to the size of the design, the script takes about 30 minutes to run.

.. rst-class:: sphx-glr-script-out
 
 Out:

 .. code-block:: none

    43657 instances in netlist
    OBUF : 63
    LUT3 : 4787
    FDRE : 17642
    RAM32M : 187
    LUT2 : 1889
    CARRY4 : 949
    LUT6 : 7833
    LUT1 : 609
    LUT4 : 3929
    LUT5 : 4710
    RAMB18E1 : 42
    RAMB36E1 : 48
    FDSE : 373
    MUXF7 : 261
    IBUF : 7
    SRL16E : 4
    IOBUF : 22
    BUFG : 7
    VCC : 77
    GND : 74
    RAM32X1D : 1
    DSP48E1 : 16
    RAM64X1D : 4
    FDPE : 10
    MUXF8 : 2
    OSERDESE2 : 43
    ODDR : 26
    OBUFDS : 1
    MMCME2_ADV : 1
    ISERDESE2 : 16
    IOBUFDS : 2
    IDELAYE2 : 16
    IDELAYCTRL : 1
    IDDR : 5
    43497 instances of 43657 replicated (99.634%)
    Identified 7540 insertion points for feedback voters.
    Identified 282 insertion points for reduction voters.
'''

import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import insert_organs, apply_nmr
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
import spydrnet_tmr as sdn_tmr
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points import find_voter_insertion_points


# Parse original netlist (it was added to the spydrnet_shrec example netlists)
netlist = sdn_tmr.load_example_netlist_by_name('nexys4ddr')

# You need to uniquify the netlist so we can make changes on individual instances
uniquify(netlist)

# Save the uniquified netlist
netlist.compose('nexys4ddr_u.edf')

# Generate a list of all leaf hierarical instances (returns a generator but is then caste as a list)
hinstances = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
print(len(hinstances),"instances in netlist")

# Generate a map between instance type and a list of instances
itypes = {}
# Iterate over all instances
for hi in hinstances:
    # get the intance of the hierarchical instance
    inst = hi.item
    # Get the type of the instance
    itype = inst.reference.name
    if itype not in itypes:
        itypes[itype] = []
    ilist = itypes[itype]
    ilist.append(hi)

# Print definitions and how many times each is instanced
for itype in itypes.keys():
    num_types = len(itypes[itype])
    print(itype,":",num_types)

# Types to ignore for replication
ignore_types = [ "OBUF", "IBUF", "IOBUF", "OSERDESE2", "MMCME2_ADV", "ISERDESE2", "IOBUFDS", "IODELAYE2", "IDELAYCTRL", "IDDR" ]

# Create list of instances to replicate
hinstances_to_replicate = list(x for x in hinstances if x.item.reference.name not in ignore_types)
print(str.format("{} instances of {} replicated ({:.3f}%)",len(hinstances_to_replicate),len(hinstances),100*len(hinstances_to_replicate)/len(hinstances)))

# Don't replicate any ports
#hports_to_replicate = list(netlist.get_hports())

# Determine voter insertion points
FFs_for_feedback = {'FDRE', 'FDSE', 'FDPE', 'FDCE'}
insertion_points = find_voter_insertion_points(netlist,hinstances_to_replicate,FFs_for_feedback)

#Get instances from hierarchical instances
instances_to_replicate = list(x.item for x in hinstances_to_replicate)

# Triplicate
replicas = apply_nmr(instances_to_replicate, 3, name_suffix='TMR', rename_original=True)

# Insert voters
voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), name_suffix='VOTER')

# Compose the modified netlist
netlist.compose('nexys4ddr_u_tmr.edf')