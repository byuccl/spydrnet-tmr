"""
Toggle DWC Example
-------------------

This is an example of doing DWC on a basic design using SpyDrNet TMR.

First, we start with a simple design that includes a LUT and a flip flop. The following block is SystemVerilog code:

.. code-block:: sv

   module toggle(
      input wire logic clk, reset,
      output logic out
      );
   
      always_ff @(posedge clk)
         if (reset)
            out <= 0;
         else
            out <= ~out;
   endmodule

.. figure:: ../../figures/toggle_original.png
   :width: 600px
   :align: center
   
   Original Design

Then we find the instances and ports to replicate. Note that in the following code that both the 'reset' and 'out' ports are specified, while the 'clk' port is not. We also find the detector insertion points.

.. code-block::

    hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)

    hports_to_replicate = list(netlist.get_hports(filter = lambda x: (not "clk" in x.name)is True))
    ports_to_replicate = list(x.item for x in hports_to_replicate)

    insertion_points = find_voter_insertion_points_before_ff([*hinstances_to_replicate, *hports_to_replicate], {'FDRE', 'FDSE', 'FDPE', 'FDCE'})

Next, we duplicate the design using apply_nmr(). The instances and ports we specified are passed as two of the parameters. We also pass '2' and 'DWC' as number of replications and the applicable suffix, respectively.

.. code-block::

   replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 2, name_suffix='DWC', rename_original=True)

.. figure:: ../../figures/toggle_just_dwc.png
   :width: 600px
   :align: center
   
   Design After Duplication

Then we insert detectors using insert_organs().

.. code-block::

    detectors = insert_organs(replicas, insertion_points, XilinxDWCDetector(), 'DETECTOR')

.. figure:: ../../figures/toggle_disconnected_detectors.png
   :width: 600px
   :align: center
   
   Duplicated Design with Disconnected Detectors

Note that the detectors' outputs are not connected to anything. To fix this,we create output ports in the top module and connect the detectors' outputs to them.

.. code-block::

    i = 0
    for detector_instance in netlist.get_instances(patterns="*DETECTOR*"):
        for port in detector_instance.get_ports(filter=lambda x: x.direction is sdn.OUT):
            for pin in port.get_pins(selection = Selection.OUTSIDE,filter=lambda x: (x.inner_pin.port.direction is sdn.OUT and x.instance.name is detector_instance.name)is True):
                new_port = netlist.top_instance.reference.create_port(name="dwc_out_"+str(i),direction=sdn.OUT)
                new_pin = new_port.create_pin()
                if pin.wire:
                    pin.wire.connect_pin(new_pin)
                else:
                    new_cable = netlist.top_instance.reference.create_cable(name="dwc_cable_"+str(i))
                    new_wire = new_cable.create_wire()
                    new_wire.connect_pin(pin)
                    new_wire.connect_pin(new_pin)
                i += 1

.. figure:: ../../figures/toggle_dwc_final.png
    :width: 600px
    :align: center
    
    Final Design

**See the full code below**
"""
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.analysis.voter_insertion.find_voter_insertion_points_before_ff import (
    find_voter_insertion_points_before_ff,
)
from spydrnet_tmr.transformation.replication.organ import XilinxDWCDetector
from spydrnet.util.selection import Selection


netlist = sdn.load_example_netlist_by_name("toggle")

uniquify(netlist)

hinstances_to_replicate = list(
    netlist.get_hinstances(
        recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
    )
)
instances_to_replicate = list(x.item for x in hinstances_to_replicate)

hports_to_replicate = list(
    netlist.get_hports(filter=lambda x: (not "clk" in x.name) is True)
)
ports_to_replicate = list(x.item for x in hports_to_replicate)

insertion_points = find_voter_insertion_points_before_ff(
    [*hinstances_to_replicate, *hports_to_replicate],
    {"FDRE", "FDSE", "FDPE", "FDCE"},
)

replicas = apply_nmr(
    [*instances_to_replicate, *ports_to_replicate],
    2,
    name_suffix="DWC",
    rename_original=True,
)

detectors = insert_organs(
    replicas, insertion_points, XilinxDWCDetector(), "DETECTOR"
)


# create output ports for Detector outputs
i = 0
for detector_instance in netlist.get_instances(patterns="*DETECTOR*"):
    for port in detector_instance.get_ports(
        filter=lambda x: x.direction is sdn.OUT
    ):
        for pin in port.get_pins(
            selection=Selection.OUTSIDE,
            filter=lambda x: (
                x.inner_pin.port.direction is sdn.OUT
                and x.instance.name is detector_instance.name
            )
            is True,
        ):
            new_port = netlist.top_instance.reference.create_port(
                name="dwc_out_" + str(i), direction=sdn.OUT
            )
            new_pin = new_port.create_pin()
            if pin.wire:
                pin.wire.connect_pin(new_pin)
            else:
                new_cable = netlist.top_instance.reference.create_cable(
                    name="dwc_cable_" + str(i)
                )
                new_wire = new_cable.create_wire()
                new_wire.connect_pin(pin)
                new_wire.connect_pin(new_pin)
            i += 1


# compose out the netlist
netlist.compose("toggle_dwc.edf")
