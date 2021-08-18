"""
Surface Pins Example
--------------------

This is an example of using surface_pins to bring pins to the top module. Although this example surfaces detector's pins in DWC, other pins can be surfaced as well (e.g. a flipflop's reset pin)

First, parse the original netlist and specify what to replicate.

.. code-block::

    netlist = sdn.load_example_netlist_by_name('hierarchical_luts')

    uniquify(netlist)

    hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)

    hports_to_replicate = list(netlist.get_hports(filter = lambda x: (not "clk" in x.name)is True))
    ports_to_replicate = list(x.item for x in hports_to_replicate)

Then find the detector insertion points. This is done manually in this example by going to the bottom hierarchical level and getting the instance's output pins.

.. code-block::

    insertion_points = []
    for instance in netlist.get_instances():
        if 'sub1' in instance.parent.name:
            insertion_points.append(next(instance.get_pins(selection=selection.Selection.OUTSIDE,filter=lambda x: x.inner_pin.port.direction is sdn.OUT)))

Replicate and insert detectors

.. code-block::

    replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 2, name_suffix='DWC', rename_original=True)
    detectors = insert_organs(replicas, insertion_points, XilinxDWCDetector(), 'DETECTOR')

As seen in the schematic below, the detector's output are not connected, and they are buried some levels down in hierarchy. The surface_pins functions provides an easy way to brings the detectors' output pins up to the top level.

.. figure:: ../../figures/hluts_detectors_beneath.png
   :width: 600px
   :align: center


Specify which pins to surface and call surface_pins to bring them to the top level module. Do this by taking the return of insert_organs() and getting all output pins of the instances (which are the organs that were inserted). Compose the resulting netlist.

.. code-block::

    pins_to_surface = []
    for key in detectors.keys():
        pins_to_surface += list((next(x.get_pins(selection=Selection.OUTSIDE,filter=lambda x:(x.inner_pin.port.direction is sdn.OUT)))) for x in voters[key])
    surface_pins(pins_to_surface)

    netlist.compose("hierarchical_luts_dwc_detectors.edf")

See the resulting schematic.

.. figure:: ../../figures/hluts_detectors_surfaced.png
   :width: 600px
   :align: center

**See the full code below**

"""
import spydrnet as sdn
from spydrnet.uniquify import uniquify
from spydrnet.util.selection import Selection
from spydrnet_tmr import apply_nmr, insert_organs
from spydrnet_tmr.transformation.replication.organ import (
    XilinxDWCDetector,
)
from spydrnet_tmr.transformation.surface_pins import surface_pins


def run():
    netlist = sdn.load_example_netlist_by_name("hierarchical_luts")
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

    insertion_points = []
    for instance in netlist.get_instances():
        if "sub1" in instance.parent.name:
            print(instance.name, "of", instance.parent.name)
            insertion_points.append(
                next(
                    instance.get_pins(
                        selection=Selection.OUTSIDE,
                        filter=lambda x: x.inner_pin.port.direction is sdn.OUT,
                    )
                )
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

    pins_to_surface = []
    for key in detectors.keys():
        pins_to_surface += list((next(x.get_pins(selection=Selection.OUTSIDE,filter=lambda x:(x.inner_pin.port.direction is sdn.OUT)))) for x in detectors[key])
    surface_pins(pins_to_surface)

    netlist.compose("hierarchical_luts_dwc.edf")


run()
