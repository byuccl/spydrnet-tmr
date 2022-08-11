import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet.util.architecture import XILINX_7SERIES
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import (
    find_after_ff_voter_points,
)
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoterVerilog

# Parse in the downloaded .v netlist
netlist = sdn.parse("simpleCounter.v",architecture=XILINX_7SERIES)

# Makes all instances unique in the netlist
uniquify(netlist)

# Gets all of the hinstances in the design but leaves out VCC GND and IBUF as those should not be triplicated
hinstances_to_replicate = list(
    netlist.get_hinstances(
        recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
                                                    and "VCC" not in x.name 
                                                    and "GND" not in x.name
                                                    and "ibuf" not in x.name.lower()
                                                    and "IBUF" not in x.item.reference.name))

# Gets all of the OUT hports in the design 
hports_to_replicate = list(netlist.get_hports(filter = lambda x: x.item.direction is sdn.OUT))

instances_to_replicate = list(x.item for x in hinstances_to_replicate)

ports_to_replicate = list(x.item for x in hports_to_replicate)

# Removes the \ and space in instance names
for hinst in hinstances_to_replicate:
    if "\\" in hinst.name:
        update_name = hinst.item.name.replace("\\", "").replace(" ", "")
        hinst.item.name = update_name

# Removes the \ and space in port names
for port in netlist.get_ports():
    if "\\" in port.name:
        update_name = port.name.replace("\\", "").replace(" ", "")
        port.name = update_name

# Removes the \ and space in cable names
for cable in netlist.get_cables():
    if "\\" in cable.name and not "const" in cable.name:
        update_name = cable.name.replace("\\", "").replace(" ", "")
        cable.name = update_name

# Creates an after_ff dictionary with all of the hinstances and hports
valid_voter_point_dict = dict()
valid_voter_point_dict["after_ff"] = [
        *hinstances_to_replicate,
        *hports_to_replicate,
    ]

# # Triplicates the design and inserts the voters
# apply_tmr_to_netlist(
#         netlist,
#         XILINX,
#         hinstances_and_hports_to_replicate=[
#             *hinstances_to_replicate,
#             *hports_to_replicate,
#         ],
#         valid_voter_point_dict=valid_voter_point_dict,
#     )

insertion_points = find_after_ff_voter_points(netlist,
    [*hinstances_to_replicate, *hports_to_replicate],
    XILINX
)

replicas = apply_nmr(
    [*instances_to_replicate, *ports_to_replicate],
    3,
    name_suffix="TMR",
    rename_original=True,
)

voters = insert_organs(replicas, insertion_points, XilinxTMRVoterVerilog(), "VOTER")

# Adds the \ and space back in instance names
for inst in netlist.get_instances():
    if "count" in inst.name or "led" in inst.name or "FSM" in inst.name:
        inst.name = ''.join(("\\", inst.name, " "))

# Adds the \ and space back in port names
for port in netlist.get_ports():
    if "FSM" in port.name:
        port.name = ''.join(("\\", port.name, " "))

# Adds the \ and space back in cable names
for cable in netlist.get_cables():
    if "count" in cable.name or "FSM" in cable.name:
        # If the wire is a VOTER wire to avoid any naming conflicts _wire is added to the end of the wire name
        if "VOTER" in cable.name:
            cable.name = ''.join(("\\", cable.name, "_wire "))
        else:
            cable.name = ''.join(("\\", cable.name, " "))
    if "f1" in cable.name or "f2" in cable.name or "one_shot" in cable.name:
        if "VOTER" in cable.name:
            cable.name = ''.join((cable.name, "_wire"))
    if "led" in cable.name and "VOTER" in cable.name:
        cable.name = ''.join(("\\",cable.name, "_wire "))

# Compose the triplicated netlist
netlist.compose("simpleCounter_tmr.v")
