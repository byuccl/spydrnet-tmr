"""
Xilinx TMR
===========
This is a xilinx TMR example using SpyDrNet SHREC

The number of times each primitive is instanced before and after triplicating will be printed.
"""

from json import load
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
from spydrnet_tmr.support_files.xilinx_primitive_tokens import FF_CELLS
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_shrec.analysis.find_voter_insertion_points import (
    find_voter_insertion_points,
)

from spydrnet_tmr.support_files.xilinx_primitive_tokens import FF_CELLS
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info

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
instances_to_replicate = list(x.item for x in hinstances_to_replicate)

# set ports_to_replicate [get_ports]
hports_to_replicate = list(netlist.get_hports())
ports_to_replicate = list(x.item for x in hports_to_replicate)

primitive_info = load_primitive_info(netlist, XILINX)

# find out where to insert reduction and feedback voters
insertion_points = find_voter_insertion_points(
    netlist,
    [*hinstances_to_replicate, *hports_to_replicate],
    [cell.name for cell in primitive_info[FF_CELLS]]
)

# replicate instances and ports
replicas = apply_nmr(
    [*instances_to_replicate, *ports_to_replicate],
    3,
    name_suffix="TMR",
    rename_original=True,
)

# insert voters on the selected drivers
voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), "VOTER")

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
