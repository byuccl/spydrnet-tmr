import argparse
import os.path
import spydrnet as sdn
import yaml
from yaml.loader import FullLoader

from spydrnet_tmr.process_config import process_config
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet_tmr.support_files.vendor_names import XILINX


def main():

    parser = argparse.ArgumentParser(description="compose netlist with TMR")

    parser.add_argument(
        "netlist_filename",
        help="filename of the netlist from which a new netlist with TMR will be composed",
    )

    parser.add_argument(
        "--tmr_config_yaml_filename",
        required=False,
        help="filename for the TMR configuration file",
        default=None,
    )

    args = parser.parse_args()
    netlist = sdn.parse(args.netlist_filename)

    # Path name of the configuration file for applying TMR
    if args.tmr_config_yaml_filename is None:
        config_file_path_name = "tmr_config.yaml"
    else:
        config_file_path_name = args.tmr_config_yaml_filename

    # Check if the config file exists
    if os.path.isfile(config_file_path_name):
        with open(config_file_path_name) as file:
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
    else:
        # Since the config file could not be found, apply TMR with default settings
        print(
            config_file_path_name
            + " could not be found. Applying TMR with default settings"
        )
        netlist = apply_tmr_to_netlist(
            netlist,
            XILINX,
        )

    netlist_filename, netlist_filename_ext = os.path.splitext(
        args.netlist_filename
    )

    sdn.compose(netlist, netlist_filename + "_tmr" + netlist_filename_ext)


if __name__ == "__main__":
    main()
