"""
Uniquify NMR Property Example
=============================

Loads in the example netlist 'b13', triplicates it, and uniquifies the value of any instance with the property 'SOFT_HLUTNM'

The properties of 'FSM_onehot_next_bit[9]_i_2_TMR_<#>' is printed before and after uniquifying the property to show what is happening.
"""

import spydrnet as sdn
from spydrnet_tmr.transformation.replication.uniquify_nmr_property import uniquify_nmr_property
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr

def run():
    netlist = sdn.load_example_netlist_by_name("b13")
    uniquify(netlist)
    hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)
    hports_to_replicate = list(netlist.get_hports())
    ports_to_replicate = list(x.item for x in hports_to_replicate)

    replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)


    print("\nBEFORE UNIQUIFYING THE PROPERTY VALUE")
    for instance in netlist.get_instances():
        if "EDIF.properties" in instance._data:
            if 'FSM_onehot_next_bit[9]_i_2' in instance.name:
                print('\t',instance.name,instance["EDIF.properties"])


    uniquify_nmr_property(replicas, 'SOFT_HLUTNM', "TMR")


    print("\nAFTER UNIQUIFYING THE PROPERTY VALUE")
    for instance in netlist.get_instances():
        if "EDIF.properties" in instance._data:
            if 'FSM_onehot_next_bit[9]_i_2' in instance.name:
                print('\t',instance.name,instance["EDIF.properties"])

run()