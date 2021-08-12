import os
from random import randint
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_before_ff import (
    find_voter_insertion_points_before_ff,
)
from spydrnet_tmr.transformation.replication.organ import (
    XilinxDWCDetector,
    XilinxTMRVoter,
)
from .check_replication_by_properties import compare_properties

"""
Test Replication By Properties
==============================

    Test replication and organ insertion using the function 'compare_properties()' in the module check_replication_by_properties.
"""

# Test replication
def test_triplication_using_steps():
    example = generate_netlists(3, "TMR")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert compare_properties(netlist1, netlist2, "TMR") is True
    remove_generated_netlists(example)


def test_duplication_using_steps():
    example = generate_netlists(2, "DWC")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert compare_properties(netlist1, netlist2, "DWC") is True
    remove_generated_netlists(example)


def test_full_tmr_using_steps():
    example = generate_netlists(3, "TMR", XilinxTMRVoter(), "VOTER")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert compare_properties(netlist1, netlist2, "TMR", "VOTER") is True
    remove_generated_netlists(example)


def test_full_dwc_using_steps():
    example = generate_netlists(2, "DWC", XilinxDWCDetector(), "DETECTOR")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert compare_properties(netlist1, netlist2, "DWC", "DETECTOR") is True
    remove_generated_netlists(example)


# Test the checking tool
def test_failed_check_replication_by_properties():
    example = generate_netlists(3, "TMR", XilinxTMRVoter(), "VOTER")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert compare_properties(netlist1, netlist2, "TMR", "fake") is False
    remove_generated_netlists(example)


def test_2_failed_check_replication_by_properties():
    example = generate_netlists(3, "TMR", XilinxTMRVoter(), "VOTER")
    netlist1 = sdn.parse(example + ".edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    for instance in netlist2.get_instances():
        if "EDIF.properties" in instance._data:
            instance["EDIF.properties"][0]["value"] = 5
    sdn.compose(netlist2, example + "_modified.edf")
    netlist2 = sdn.parse(example + "_modified.edf")
    assert compare_properties(netlist1, netlist2, "TMR", "VOTER") is False
    remove_generated_netlists(example)


def generate_netlists(copy_amount, suffix, organ=None, organ_name=None):
    """
    Generates netlists needed for testing by selecting a random example, replicating the design, and composing the netlist.
    """

    examples_list = [
        "b13",
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

    if organ is None:
        sdn.compose(netlist, example_to_test + "_modified.edf")
    else:
        organs = insert_organs(replicas, insertion_points, organ, organ_name)
        sdn.compose(netlist, example_to_test + "_modified.edf")

    return example_to_test


def remove_generated_netlists(example_name):
    os.remove(example_name + ".edf")
    os.remove(example_name + "_modified.edf")
