"""
Process TMR Config
"""
import spydrnet as sdn

from spydrnet_tmr.config_constants import (
    ALL,
    NONE,
    EXCLUDE_PRIM,
    EXCLUDE_PORTS,
    EXCLUDE_HINST,
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


def process_config(netlist, tmr_config):
    """Process TMR Config

    This function process config information for a given netlist. It will
    determine which hinstances and hports will be replicated, as well as what
    voting algorithms will be used.

    A special dictionary is returned for which points are at valid voter
    locations. Many times, it is not desirable that a voter be placed at a
    certain location for critical paths or other circumstances, so it can be
    excluded from being considered by voter algorithms. "Valid voter points"
    in this case are defined as hinstances or hports. It is organized in the
    following manner:

    - `<voter_algorithm_name>`
        - `<list_of_valid_voter_points>`

    Each key is a string for a voter algorithm name, and the value is a list
    of hinstances and hports that will be considered for voter insertion.

    :param netlist: netlist for which the config will be processed
    :type netlist: netlist
    :param tmr_config: contains all the config info from a YAML config file
    :type tmr_config: dict
    :return: list of hinstances and hports that will be replicated, and valid voter point dictionary as described above
    """
    hinstances_and_hports_to_replicate = set()
    valid_voter_point_dict = dict()

    # Check if there is both a voter_insertion and replication section
    if sorted(tmr_config.keys()) == sorted([VOTER_INSERTION, REPLICATION]):
        for section in tmr_config.items():
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
    return hinstances_and_hports_to_replicate, valid_voter_point_dict


def create_replication_list(netlist, section):
    """Create Replication List

    This function generates a list of hinstances and hports that will be
    replicated.

    :param netlist: netlist for which replication list will be generated
    :type netlist: netlist
    :param section: config info for replication
    :type section: dict
    :return: hinstances and hports to be replicated
    :rtype: list
    """
    hports_to_replicate = []
    hinstances_to_replicate = []
    if sorted(section[1].keys()) == sorted(
        [INSTANCES_TO_REPLICATE, PORTS_TO_REPLICATE]
    ):
        for replication_list in section[1].items():
            if replication_list[0] == INSTANCES_TO_REPLICATE:
                for value in replication_list:
                    if len(replication_list) > 2:
                        print(
                            "Warning: Multiple options for instance replication. Lists will add to eachother"
                        )
                    if value == ALL:
                        for hinst in netlist.get_hinstances(
                            recursive=True,
                            filter=lambda x: x.item.reference.is_leaf()
                            is True,
                        ):
                            hinstances_to_replicate.append(hinst)
                    elif (
                        isinstance(value, dict)
                        and EXCLUDE_PRIM in value.keys()
                    ):
                        for hinst in netlist.get_hinstances(
                            recursive=True,
                            filter=lambda x: x.item.reference.is_leaf()
                            is True,
                        ):
                            if (
                                hinst.item.reference.name
                                not in value[EXCLUDE_PRIM]
                            ):
                                hinstances_to_replicate.append(hinst)
                    elif (
                        isinstance(value, dict)
                        and EXCLUDE_HINST in value.keys()
                    ):
                        for hinst in netlist.get_hinstances(
                            recursive=True,
                            filter=lambda x: x.item.reference.is_leaf()
                            is True,
                        ):
                            if hinst.name not in value[EXCLUDE_HINST]:
                                hinstances_to_replicate.append(hinst)
                    elif value == NONE:
                        pass
                    elif value == INSTANCES_TO_REPLICATE:
                        pass
                    else:
                        print("Unrecognized option for instance replication")
            if replication_list[0] == PORTS_TO_REPLICATE:
                if len(replication_list) > 2:
                    print(
                        "Warning: Multiple options for port replication. Lists will add to eachother"
                    )
                for value in replication_list:
                    if value == ALL:
                        for hport in netlist.get_hports():
                            hports_to_replicate.append(hport)
                    elif value == TOP_LEVEL_INPUT_PORTS:
                        for hport in netlist.get_hports(
                            filter=lambda x: x.item.direction is sdn.IN
                        ):
                            hports_to_replicate.append(hport)
                    elif value == TOP_LEVEL_OUTPUT_PORTS:
                        for hport in netlist.get_hports(
                            filter=lambda x: x.item.direction is sdn.OUT
                        ):
                            hports_to_replicate.append(hport)
                    elif value == TOP_LEVEL_INOUTPUT_PORTS:
                        for hport in netlist.get_hports(
                            filter=lambda x: x.item.direction is sdn.INOUT
                        ):
                            hports_to_replicate.append(hport)
                    elif (
                        isinstance(value, dict)
                        and EXCLUDE_PORTS in value.keys()
                    ):
                        for hport in netlist.get_hports():
                            if hport.item.name not in value[EXCLUDE_PORTS]:
                                hports_to_replicate.append(hport)
                    elif value == NONE:
                        pass
                    elif value == PORTS_TO_REPLICATE:
                        pass
                    else:
                        print("Unrecognized option for port replication")

    # Get rid of potential duplicates
    hinstances_to_replicate = set(hinstances_to_replicate)
    hports_to_replicate = set(hports_to_replicate)

    return [*hinstances_to_replicate, *hports_to_replicate]


def create_valid_voter_point_dict(
    netlist, voter_insertion_section, hinstances_and_hports_to_replicate
):
    """Create Valid Voter Point Dictionary

    For each voter algorithm provided in the config, create a list of all the
    valid hinstances and hports at which voters could be placed. This does not
    necessarily mean that voters will be placed at these locations, but they
    will at least be considered.

    :param netlist: netlist for which valid voter point dictionary will be generated
    :type netlist: netlist
    :param voter_insertion_section: section from config file with info for generated valid voter point dictionary
    :type voter_insertion_section: dict
    :param hinstances_and_hports_to_replicate: list of elements that will be replicated
    :type hinstances_and_hports_to_replicate: list
    :return: valid voter point dictionary
    :rtype: dict
    """
    valid_voter_point_dict = dict()
    for voter_algorithm in voter_insertion_section[1].items():
        valid_voters_at_instances = list()
        valid_voters_at_ports = list()
        for valid_voter_list in voter_algorithm[1].items():
            if valid_voter_list[0] == INSTANCES_AT_VALID_POINTS:
                for value in valid_voter_list:
                    if value == ALL:
                        for hinst in netlist.get_hinstances(
                            recursive=True,
                            filter=lambda x: x.item.reference.is_leaf()
                            is True,
                        ):
                            valid_voters_at_instances.append(hinst)
                    elif (
                        isinstance(value, dict)
                        and EXCLUDE_PRIM in value.keys()
                    ):
                        for hinst in netlist.get_hinstances(
                            recursive=True,
                            filter=lambda x: x.item.reference.is_leaf()
                            is True,
                        ):
                            if (
                                hinst.item.reference.name
                                not in value[EXCLUDE_PRIM]
                            ):
                                valid_voters_at_instances.append(hinst)
                    elif value == NONE:
                        pass
                    elif value == INSTANCES_AT_VALID_POINTS:
                        pass
                    else:
                        print(
                            'Unrecognized option for instances at valid points for "'
                            + voter_algorithm[0]
                            + '" algorithm'
                        )
            if valid_voter_list[0] == PORTS_AT_VALID_POINTS:
                for value in valid_voter_list:
                    if value == ALL:
                        for hport in netlist.get_hports():
                            valid_voters_at_ports.append(hport)
                    elif (
                        isinstance(value, dict)
                        and EXCLUDE_PORTS in value.keys()
                    ):
                        for hport in netlist.get_hports():
                            if hport.item.name not in value[EXCLUDE_PORTS]:
                                valid_voters_at_ports.append(hport)
                    elif value == NONE:
                        pass
                    elif value == PORTS_AT_VALID_POINTS:
                        pass
                    else:
                        print(
                            'Unrecognized option for ports at valid points for "'
                            + voter_algorithm[0]
                            + '" algorithm'
                        )

        valid_voters_at_instances = set(valid_voters_at_instances)
        valid_voters_at_ports = set(valid_voters_at_ports)

        valid_voter_point_set = set()

        valid_voter_point_set.update(valid_voters_at_instances)
        valid_voter_point_set.update(valid_voters_at_ports)

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
