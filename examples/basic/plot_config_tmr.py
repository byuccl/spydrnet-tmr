"""
YAML Configuration Mode for Triplication
========================================

In order to ease the use of SpyDrNet-TMR and allow for complex replication/voter
insertion, support for YAML configurations has been implemented. A configuration
file for SpyDrNet-TMR is organized as the following:

.. code-block:: yaml

    # Replication options for both instances and top-level ports
    replication:
        instances_to_replicate:
            <instance_option>
        ports_to_replicate:
            <port_option>

    voter_insertion:
        <voter_algorithm_name>:
            instances_at_valid_points:
                <instance_option>
            ports_at_valid_points:
                <port_option>

Instance options include the following:
    - `all`: include all instances
    - `none`: exclude all instances
    - `exclude_prim: ["<primitve_name>"]`: include all instances except for ones of primtive types listed
    - `exclude_hinst: ["<hinst_name>"]`: include all instances except for the hierachircal instance names given

Port options include the following:
    - `all`: include all top-level ports
    - `none`: exclude all top-level ports
    - `top_level_input_ports`: only include all top-level input ports
    - `top_level_output_ports`: only include all top-level output ports
    - `top_level_inoutput_ports`: only include all top-level in/output ports
    - `exclude_ports: ["<port_name>"]`: include all top-level ports except for the port names given

Voter insertion algorithm names come from the module/function names found in
the `spydrnet_tmr/analysis/voter_insertion/` directory. The algorithm name is
matched with the modules/functions in that directory in the following manner:
`find_<voter_algorithm_name>_points.py`. The given algorithm name in a
configuration file must excatly match an algorithm from the algorithms in the
mentioned drectory.

    - Example:
        - `<voter_algorithm_name>` for `find_after_ff_voter_points.py` would be `after_ff`
        - `<voter_algorithm_name>` for `find_after_ff_voter_points.py` would be `after_ff`

"""

import yaml
from yaml.loader import FullLoader

from spydrnet_tmr import load_example_netlist_by_name
from spydrnet_tmr.process_config import process_config
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet_tmr.support_files.vendor_names import XILINX


def run():

    netlist_config_pairs = {
        "two_bit_counter_top": "examples/basic/tmr_config_example1.yaml",
        "registered_inverter": "examples/basic/tmr_config_example2.yaml",
    }

    for netlist_name, config_filename in netlist_config_pairs.items():
        process_config_and_apply_tmr(netlist_name, config_filename)


def process_config_and_apply_tmr(netlist_name, config_filename):
    """
    Process YAML configuration file and apply TMR to netlist.

    Use the 'process_config' and 'apply_tmr_to_netlist' functions for an existing
    example netlist and an existing config file.
    """

    example_netlist_name = netlist_name
    netlist = load_example_netlist_by_name(example_netlist_name)

    with open(config_filename) as file:
        tmr_config = yaml.load(file, Loader=FullLoader)
        (
            hinstances_and_hports_to_replicate,
            valid_voter_point_dict,
        ) = process_config(netlist, tmr_config)

        netlist = apply_tmr_to_netlist(
            netlist,
            XILINX,
            hinstances_and_hports_to_replicate,
            valid_voter_point_dict,
        )


run()
