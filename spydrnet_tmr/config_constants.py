"""
TMR Configuration Constants for 'tmr_config.yaml' file

Note: Voter insertion algorithm names are matched to functions in the
      analysis/voter_insertion/ directory in the following manner:
      "find_<algorithm_name>_voter_points". Make sure to match the name for the
      desired algorithm exactly.

"""

# Keywords for the different sections of the TMR config file.
REPLICATION = "replication"
VOTER_INSERTION = "voter_insertion"

INSTANCES_TO_REPLICATE = "instances_to_replicate"
PORTS_TO_REPLICATE = "ports_to_replicate"

INSTANCES_AT_VALID_POINTS = "instances_at_valid_points"
PORTS_AT_VALID_POINTS = "ports_at_valid_points"


# Options applicable to both instances and ports
ALL = "all"

# Options applicable to instances
EXCLUDE_PRIM = "exclude_prim"
EXCLUDE_HINST = "exclude_hinst"

# Options applicable to ports
EXCLUDE_PORTS = "exclude_ports"
TOP_LEVEL_INPUT_PORTS = "top_level_input_ports"
TOP_LEVEL_OUTPUT_PORTS = "top_level_output_ports"
TOP_LEVEL_INOUTPUT_PORTS = "top_level_inoutput_ports"
