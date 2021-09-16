'''
Design Rule Check Example
==========================

This is an example of using :ref:`drc_connections_after_replication_and_insertion` and :ref:`drc_properties_after_replication` found under *spydrnet_tmr.utils.design_rule_check*

* **Setup**:
    1. Do TMR with the example netlist 'b13'. Compose the resulting netlist as 'b13_modified.edf'.
    2. Parse the netlists

* **check_connections**:
    1. Call check_connections(). The design will pass the check
    2. Disconnect the output pin of the instance 'tx_conta_reg_TMR_1[6]'
    3. Call check_connections() again. Now the design will fail the check. View the comparison results in 'drc_connection_results_b13.txt'. See that the output of the instance 'tx_conta_reg_TMR_1[6]' is why it failed
    4. Reconnect the disconnected pin
    5. Call check_connections() again. Now the design will pass the check

* **check_properties_after_replication**:
    1. Run check_properties_after_replication(). It will pass
    2. Change the properties of the instance 'tx_conta_reg_TMR_1[6]'
    3. Run check_properties_after_replication() again. It will fail. View the comparison results in 'drc_property_results_b13.txt'. See that the properties of the instance 'tx_conta_reg_TMR_1[6]' are why it failed

.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none

    Identified 56 insertion points for feedback voters after flip-flop.
    CHECKING CONNECTIONS
    PASSED
    CHECKING CONNECTIONS
    FAILED
    CHECKING CONNECTIONS
    PASSED
    CHECKING PROPERTIES
    PASSED
    CHECKING PROPERTIES
    FAILED
'''


import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet.util.selection import Selection
from spydrnet_tmr import insert_organs, apply_nmr
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_after_ff import find_voter_insertion_points_after_ff
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
from spydrnet_tmr.transformation.replication.uniquify_nmr_property import uniquify_nmr_property
from spydrnet_tmr.utils.design_rule_check import check_connections
from spydrnet_tmr.utils.design_rule_check import check_properties_after_replication

def run():

    #setup
    get_modified_netlists('b13')

    #check_connections
    netlist1 = sdn.parse("b13.edf")
    netlist2 = sdn.parse("b13_modified.edf")
    check_connections(netlist1,netlist2,'TMR',['VOTER'],True)

    instance = next(netlist2.get_instances('tx_conta_reg_TMR_1[6]'),None)
    pin_to_disconnect = next(instance.get_pins(selection=Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT))
    wire = pin_to_disconnect.wire
    wire.disconnect_pin(pin_to_disconnect)
    check_connections(netlist1,netlist2,'TMR',['VOTER'],True)

    wire.connect_pin(pin_to_disconnect)
    check_connections(netlist1,netlist2,'TMR',['VOTER'],True)

    #check_properties_after_replication
    check_properties_after_replication(netlist1,netlist2,'TMR',['VOTER'],True)

    instance['EDIF.properties'] = [{'random properties':0000}]
    check_properties_after_replication(netlist1,netlist2,'TMR',['VOTER'],True)

def get_modified_netlists(netlist_name):

    netlist = sdn.load_example_netlist_by_name(netlist_name)
    uniquify(netlist)
    sdn.compose(netlist,netlist_name+".edf")

    hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)
    hports_to_replicate = list(netlist.get_hports())
    ports_to_replicate = list(x.item for x in hports_to_replicate)
    insertion_points = find_voter_insertion_points_after_ff([*hinstances_to_replicate, *hports_to_replicate], {'FDRE', 'FDSE', 'FDPE', 'FDCE'})
    replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)
    voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), 'VOTER')
    uniquify_nmr_property(replicas, {'HBLKNM', 'HLUTNM', 'SOFT_HLUTNM'}, "TMR")

    netlist.compose(netlist_name+"_modified.edf")

run()
