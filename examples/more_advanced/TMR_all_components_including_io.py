"""
TMR All Components Including IO
--------------------------------
"""
import spydrnet as sdn
import spydrnet_tmr as sdn_tmr

from spydrnet.uniquify import uniquify

from spydrnet_tmr import apply_nmr
from spydrnet_tmr import insert_organs
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points import find_voter_insertion_points

from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter

# Load b13 netlist
netlist = sdn.load_example_netlist_by_name('b13')

# Make sure non-leaf definition instances refer to a unique definition
uniquify(netlist)

# Find all instances and ports
hinstances = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf()))
hports = list(netlist.get_hports())

# Find voter insertion points
insertion_points = find_voter_insertion_points(
    netlist, 
    [*hinstances, *hports], 
    {"FDRE", "FDSE", "FDPE", "FDCE"}
)

# Replicate instances and ports
instances = list(x.item for x in hinstances)
ports = list(x.item for x in hports)
copies = apply_nmr(
    [*instances, *ports],
    3,
    name_suffix="TMR",
    rename_original=True,
)

# Insert voters
voters = insert_organs(
    copies,
    insertion_points,
    XilinxTMRVoter(),
    "Voter"
)

netlist.compose('b13_TMR_all_components_including_io.edf')
