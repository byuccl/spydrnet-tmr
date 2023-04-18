import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import (
    find_after_ff_voter_points,
)
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter

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
                                                    and "IBUF" not in x.item.reference.name))

# Gets all of the OUT hports in the design 
hports_to_replicate = list(netlist.get_hports(filter = lambda x: x.item.direction is sdn.OUT))

instances_to_replicate = list(x.item for x in hinstances_to_replicate)

ports_to_replicate = list(x.item for x in hports_to_replicate)

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

voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), "VOTER")

# Compose the triplicated netlist
netlist.compose("simpleCounter_tmr.edf")
