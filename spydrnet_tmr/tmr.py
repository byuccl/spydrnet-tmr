"""
TMR.py
"""
import argparse
import os.path
from spydrnet_tmr.tmr_config_constants import (
    ALL,
    INSTANCES_AT_VALID_POINTS,
    INSTANCES_TO_REPLICATE,
    PORTS_AT_VALID_POINTS,
    PORTS_TO_REPLICATE,
    REPLICATION,
    TOP_LEVEL_INPUT_PORTS,
    TOP_LEVEL_OUTPUT_PORTS,
    TOP_LEVEL_INOUTPUT_PORTS,
    VOTER_INSERTION,
)
import spydrnet as sdn
import yaml
from yaml.loader import FullLoader

# import spydrnet_tmr as sdn_tmr
# import tmr_config
from spydrnet_tmr.apply_tmr_to_netlist import apply_tmr_to_netlist
from spydrnet_tmr.support_files.vendor_names import XILINX


def main():

    parser = argparse.ArgumentParser(description="compose netlist with TMR")
    parser.add_argument(
        "netlist_filename",
        help="filename of the netlist from which a new netlist with TMR will be composed",
    )

    args = parser.parse_args()
    netlist = sdn.parse(args.netlist_filename)

    # Path name of the configuration file for applying TMR
    config_file_path_name = "tmr_config.yaml"

    # Check if the config file exists
    if os.path.isfile(config_file_path_name):
        with open(config_file_path_name) as file:
            tmr_config_content = yaml.load(file, Loader=FullLoader)
            tmr_config = list(tmr_config_content.values())[0]
            netlist = apply_tmr_to_netlist_from_config(netlist, tmr_config)
    else:
        # Since the config file could not be found, apply TMR with default settings
        print(
            config_file_path_name
            + " could not be found. Applying TMR with default settings"
        )
        # netlist = apply_tmr_to_netlist(
        #     netlist,
        #     XILINX,
        #     # replicate_all_output_ports_flag=False,
        #     # replicate_all_input_ports_flag=False,
        # )

    netlist_filename, netlist_filename_ext = os.path.splitext(
        args.netlist_filename
    )

    sdn.compose(netlist, netlist_filename + "_tmr" + netlist_filename_ext)


def apply_tmr_to_netlist_from_config(netlist, tmr_config):
    """
    apply_tmr_to_netlist_from_config

    :param netlist: [description]
    :type netlist: [type]
    :param tmr_config: [description]
    :type tmr_config: [type]
    :raises TMRConfigError: [description]
    :return: [description]
    :rtype: [type]
    """

    hinstances_and_hports_to_replicate = set()
    valid_voter_point_dict = dict()

    print(tmr_config)
    # Check if there is both a voter_insertion and replication section
    if sorted(tmr_config.keys()) == sorted([VOTER_INSERTION, REPLICATION]):
        for section in tmr_config.items():
            print(section)

            if section[0] == REPLICATION:
                hinstances_and_hports_to_replicate = create_replication_list(
                    netlist, section
                )
            if section[0] == VOTER_INSERTION:
                valid_voter_point_dict = create_valid_voter_point_dict(
                    netlist, section, hinstances_and_hports_to_replicate
                )
    else:
        # Sections were incorrect. Either included an unrecognized section and/or missing a section
        unrecognized_sections = list()
        for section in tmr_config.keys():
            if section not in [VOTER_INSERTION, REPLICATION]:
                unrecognized_sections.append(section)
        if unrecognized_sections:
            exception_msg = " Unrecognized Section(s):"
            for section in unrecognized_sections:
                exception_msg += " " + section
            raise TMRConfigError(exception_msg)
        raise TMRConfigError(
            "Missing either 'voter_insertion' or 'replication' section"
        )

    apply_tmr_to_netlist(
        netlist,
        XILINX,
        hinstances_and_hports_to_replicate,
        valid_voter_point_dict,
    )
    return netlist


def create_replication_list(netlist, section):
    hports_to_replicate = set()
    hinstances_to_replicate = set()
    if sorted(section[1].keys()) == sorted(
        [INSTANCES_TO_REPLICATE, PORTS_TO_REPLICATE]
    ):
        for replication_list in section[1].items():
            if replication_list[0] == INSTANCES_TO_REPLICATE:
                for value in replication_list:
                    if value == ALL:
                        hinstances_to_replicate.add(
                            netlist.get_hinstances(
                                recursive=True,
                                filter=lambda x: x.item.reference.is_leaf()
                                is True,
                            )
                        )
            if replication_list[0] == PORTS_TO_REPLICATE:
                for value in replication_list:
                    if value == ALL:
                        hports_to_replicate.add(netlist.get_hports())
                    if value == TOP_LEVEL_INPUT_PORTS:
                        hports_to_replicate.add(
                            netlist.get_hports(
                                filter=lambda x: x.item.direction is sdn.IN
                            )
                        )
                    if value == TOP_LEVEL_OUTPUT_PORTS:
                        hports_to_replicate.add(
                            netlist.get_hports(
                                filter=lambda x: x.item.direction is sdn.OUT
                            )
                        )
                    if value == TOP_LEVEL_INOUTPUT_PORTS:
                        hports_to_replicate.add(
                            netlist.get_hports(
                                filter=lambda x: x.item.direction is sdn.INOUT
                            )
                        )

    hinstances_to_replicate = [list(x) for x in hinstances_to_replicate][0]
    hports_to_replicate = [list(x) for x in hports_to_replicate][0]

    return [*hinstances_to_replicate, *hports_to_replicate]


def create_valid_voter_point_dict(
    netlist, voter_insertion_section, hinstances_and_hports_to_replicate
):
    valid_voters_at_instances_set = set()
    valid_voters_at_ports_set = set()
    valid_voter_point_dict = dict()
    for voter_algorithm in voter_insertion_section[1].items():
        for valid_voter_list in voter_algorithm[1].items():
            if valid_voter_list[0] == INSTANCES_AT_VALID_POINTS:
                for value in valid_voter_list:
                    if value == ALL:
                        valid_voters_at_instances_set.add(
                            (
                                netlist.get_hinstances(
                                    recursive=True,
                                    filter=lambda x: x.item.reference.is_leaf()
                                    is True,
                                )
                            )
                        )
            if valid_voter_list[0] == PORTS_AT_VALID_POINTS:
                for value in valid_voter_list:
                    if value == ALL:
                        valid_voters_at_ports_set.add(netlist.get_hports())

        valid_voters_at_instances_set = [
            list(x) for x in valid_voters_at_instances_set
        ][0]
        valid_voters_at_ports_set = [
            list(x) for x in valid_voters_at_ports_set
        ][0]
        valid_voter_point_set = set()
        valid_voter_point_set.update(valid_voters_at_instances_set)
        valid_voter_point_set.update(valid_voters_at_ports_set)

        rep_set = set()
        rep_set.update(hinstances_and_hports_to_replicate)

        valid_voter_point_set = valid_voter_point_set.intersection(rep_set)

        valid_voter_point_dict[voter_algorithm[0]] = valid_voter_point_set

    return valid_voter_point_dict


class TMRConfigError(Exception):
    """Exception raised for errors in the TMR config file.

    Attributes:
        message -- explanation of the error
    """


if __name__ == "__main__":
    main()
