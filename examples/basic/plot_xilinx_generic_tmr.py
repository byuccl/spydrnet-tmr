"""
Xilinx TMR
===========
This is a xilinx TMR example using SpyDrNet TMR

The number of times each primitive is instanced before and after triplicating will be printed.
"""

import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist

# set_property design_mode GateLvl [current_fileset]
# set_property edif_top_file <path_to_file> [current_fileset]
# link_design -part <part_number> -mode out_of_context
netlist = sdn.load_example_netlist_by_name(
    "fourBitCounter"
)  # loading an example, use `sdn.parse(<netlist filename>)` otherwise

# uniquify is called to insure that non-leaf definitions are instanced only once, prevents unintended transformations.
uniquify(netlist)

# set instances_to_replicate [get_cells -hierarchical -filter {PRIMITIVE_LEVEL==LEAF||PRIMITIVE_LEVEL==MACRO}]
hinstances_to_replicate = list(
    netlist.get_hinstances(
        recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
    )
)

# set ports_to_replicate [get_ports]
hports_to_replicate = list(
    netlist.get_hports(filter=lambda x: x.item.direction is sdn.IN)
)

valid_voter_point_dict = dict()
valid_voter_point_dict["reduction"] = [
    *netlist.get_hports(),
    *hinstances_to_replicate,
]

# find out where to insert reduction voters
netlist = apply_tmr_to_netlist(
    netlist,
    XILINX,
    hinstances_and_hports_to_replicate=[
        *hports_to_replicate,
        *hinstances_to_replicate,
    ],
    valid_voter_point_dict=valid_voter_point_dict,
)

# print the number of times each primitive is instanced
def instance_count(original_netlist, new_netlist):
    print("\nPrimitive count before and after TMR:")
    primitives_library = next(
        new_netlist.get_libraries("hdi_primitives"), None
    )
    for primitive in primitives_library.get_definitions():
        i = 0
        j = 0
        for instance in original_netlist.get_instances():
            if primitive.name == instance.reference.name:
                i += 1
        for instance in new_netlist.get_instances():
            if primitive.name == instance.reference.name:
                j += 1
        print("\t", primitive.name, ": ", i, " --> ", j)


instance_count(sdn.load_example_netlist_by_name("fourBitCounter"), netlist)
