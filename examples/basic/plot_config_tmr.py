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
from spydrnet import compose

YAML_CONFIG1 = """
################ TMR Config Example 1 ################
replication:
  # All leaf instances will be replicated within the design.
  instances_to_replicate:
    all  
  # Only the top-level input ports will be replicated, which leaves any output
  # ports or inoutput ports not replicated.
  ports_to_replicate:
    top_level_input_ports

# Here in the voter_insertion section, we have two algorithms that will be
# applied to the netlist. 
#
# First, place a voter before every flip-flop in the design denoted by the 
# name "before_ff" which comes from the function/module name in the 
# 'spydrnet_tmr/analysis/voter_insertion/' directory. This needs to match exact!

# Second, place reduction voters for replicated to non-replicated TMR boundaries
# again denoted by the name "reduction" which comes from the corresponding
# function/module name. 
#
# For both of these algorithms, all points will be considered for voter 
# insertion, but that does not mean a voter will be placed at every point.
# For example, the "before_ff" algorithm will consider LUTs for voter insertion,
# but will ultimately decide not to place a voter before it because it isn't a
# flip-flop. If you don't want a voter at a certain instance/port, use 
# 'exclude_prim', 'exclude_ports', or 'exclude_hinst'.
voter_insertion:
  before_ff:
    instances_at_valid_points:
      all
    ports_at_valid_points:
      all
  reduction:
    instances_at_valid_points:
      all
    ports_at_valid_points:
      all

"""

YAML_CONFIG2 = """
################ TMR Config Example 2 ################
replication:
  # Here is an example of excluding an instance within the design. The 
  # hierarchical name is required.
  instances_to_replicate:
    exclude_hinst: ["PURPOSEFUL_GENERATE[8].SEQUENTIAL_LOGIC/DQ_reg[1]"]
  ports_to_replicate:
    all
voter_insertion:
  reduction:
    # Here is an example of excluding all instances of a primitive type for
    # voter insertion. In this case, we want to do this because the flip-flop
    # that is excluded from replication will receive a clock signal from the
    # global clock buffer, and we don't want to place a voter in its path, so
    # we'll exclude all BUFGs from the reduction voter insertion algorithm.
    instances_at_valid_points:
      exclude_prim: ["BUFG"]
    ports_at_valid_points:
      all
"""


def run():
    netlist_config_pairs = {
        "two_bit_counter_top": YAML_CONFIG1,
        "registered_inverter": YAML_CONFIG2,
    }

    for netlist_name, config_filename in netlist_config_pairs.items():
        process_config_and_apply_tmr(netlist_name, config_filename)


def process_config_and_apply_tmr(netlist_name, config_str):
    """
    Process YAML configuration file and apply TMR to netlist.

    Use the 'process_config' and 'apply_tmr_to_netlist' functions for an existing
    example netlist and an existing config file.
    """

    example_netlist_name = netlist_name
    netlist = load_example_netlist_by_name(example_netlist_name)

    tmr_config = yaml.load(config_str, Loader=FullLoader)
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

    compose(netlist, netlist_name + "_tmr.edf")


run()
