import spydrnet as sdn
import spydrnet_tmr as sdn_tmr
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet_tmr.support_files.vendor_names import XILINX


def run():
    netlist_name = "two_bit_counter_top"
    netlist = sdn_tmr.load_example_netlist_by_name(netlist_name)
    hinstances_to_replicate = list(netlist.get_hinstances(
        filter=lambda x: x.name != "two_bit_counter"
        and x.parent.name != "two_bit_counter" and x.item.is_leaf(),
        recursive=True,
    ))
    apply_tmr_to_netlist(
        netlist,
        XILINX,
        hinstances_to_replicate=hinstances_to_replicate
        # insert_voters_before_ff_flag=True,
        # replicate_all_output_ports_flag=False,
    )
    sdn.compose(netlist, netlist_name + "_tmr.edf")


run()
