import os
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_before_ff import (
    find_voter_insertion_points_before_ff,
)
from spydrnet_tmr.transformation.replication.nmr import apply_nmr
from spydrnet_tmr.transformation.replication.organ import (
    XilinxTMRVoter,
    XilinxDWCDetector,
)
from spydrnet_tmr.transformation.replication.organ_insertion import (
    insert_organs,
)
from spydrnet_tmr.utils.design_rule_check.design_rule_check import check_design


"""
Tests full TMR and DWC by replicating some small netlists and making sure each passes the DRC
"""


def test_tmr_using_drc_1():
    example = generate_netlists(3, "TMR", XilinxTMRVoter(), "VOTER")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert check_design(netlist1, netlist2, "TMR", "VOTER") is True
    remove_generated_netlists(example)


def test_tmr_using_drc_2():
    example = generate_netlists(3, "TMR", XilinxTMRVoter(), "VOTER")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert check_design(netlist1, netlist2, "TMR", "VOTER") is True
    remove_generated_netlists(example)


def test_dwc_using_drc_1():
    example = generate_netlists(2, "DWC", XilinxDWCDetector(), "DETECTOR")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert check_design(netlist1, netlist2, "DWC", "DETECTOR") is True
    remove_generated_netlists(example)


def test_dwc_using_drc_2():
    example = generate_netlists(2, "DWC", XilinxDWCDetector(), "DETECTOR")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert check_design(netlist1, netlist2, "DWC", "DETECTOR") is True
    remove_generated_netlists(example)


def generate_netlists(copy_amount, suffix, organ=None, organ_name=None):
    """
    Generates netlists needed for testing by selecting a random example from a list of small netlists, replicating the design, and composing the netlist.
    """

    examples_list = [
        "b13",
        "register_file",
        "three_stage_synchronizer",
        "synchronizer_test",
        "n_bit_counter",
        "lfsr_kc705",
        "lfsr_zybo",
        "fourBitCounter",
        "basic_clock_crossing",
    ]
    random_value = randint(0, len(examples_list) - 1)
    example_to_test = examples_list[random_value]

    netlist = sdn.load_example_netlist_by_name(example_to_test)

    uniquify(netlist)
    sdn.compose(netlist, example_to_test + ".edf")

    hinstances_to_replicate = list(
        netlist.get_hinstances(
            recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
        )
    )
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)
    hports_to_replicate = list(netlist.get_hports())
    ports_to_replicate = list(x.item for x in hports_to_replicate)

    insertion_points = find_voter_insertion_points_before_ff(
        netlist,
        [*hinstances_to_replicate, *hports_to_replicate],
        {"FDRE", "FDSE", "FDPE", "FDCE"},
    )
    replicas = apply_nmr(
        [*instances_to_replicate, *ports_to_replicate],
        copy_amount,
        name_suffix=suffix,
        rename_original=True,
    )

    organs = insert_organs(replicas, insertion_points, organ, organ_name)
    sdn.compose(netlist, example_to_test + "_modified.edf")

    return example_to_test


def remove_generated_netlists(example_name):
    os.remove(example_name + ".edf")
    os.remove(example_name + "_modified.edf")
