import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist

# Parse in the downloaded .edf netlist
netlist = sdn.parse("simpleCounter.edf")

# Makes all instances unique in the netlist
uniquify(netlist)

# Gets all of the hinstances in the design but leaves out VCC GND and IBUF as those should not be triplicated
hinstances_to_replicate = list(
    netlist.get_hinstances(
        recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
                                                    and "VCC" not in x.name
                                                    and "GND" not in x.name
                                                    and "ibuf" not in x.name.lower()
                                                    and "IBUF" not in x.item.reference.name ))

# Gets all of the OUT hports in the design 
hports_to_replicate = list(netlist.get_hports(filter=lambda x: x.item.direction is sdn.OUT))

# Creates an after_ff dictionary with all of the hinstances and hports
valid_voter_point_dict = dict()
valid_voter_point_dict["after_ff"] = [
        *hinstances_to_replicate,
        *hports_to_replicate,
    ]

# Triplicates the design and inserts the voters
apply_tmr_to_netlist(
        netlist,
        XILINX,
        hinstances_and_hports_to_replicate=[
            *hinstances_to_replicate,
            *hports_to_replicate,
        ],
        valid_voter_point_dict=valid_voter_point_dict,
    )

# Compose the triplicated netlist
netlist.compose("simpleCounter_tmr.edf")
