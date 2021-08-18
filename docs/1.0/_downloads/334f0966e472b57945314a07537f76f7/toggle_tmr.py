"""
Toggle TMR Example
-------------------

This is an example of doing TMR on a basic design using SpyDrNet TMR.

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

Then we find the instances and ports to replicate. Note that in the following code that the only ports specified to be triplicated are the input ports that are not the clock (so just the reset port). We also find the voter insertion points.

.. code-block::

   hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
   instances_to_replicate = list(x.item for x in hinstances_to_replicate)

   hports_to_replicate = list(netlist.get_hports(filter = lambda x: x.item.direction is sdn.IN))
   for x in hports_to_replicate:
      if "clk" in x.name:
         hports_to_replicate.remove(x)
   ports_to_replicate = list(x.item for x in hports_to_replicate)

   insertion_points = find_voter_insertion_points_before_ff([*hinstances_to_replicate, *hports_to_replicate], {'FDRE', 'FDSE', 'FDPE', 'FDCE'})

Next, we triplicate the design using apply_nmr(). The instances and ports we specified are passed as two of the parameters. We also pass '3' and 'TMR' as number of replications and the applicable suffix, respectively.

.. code-block::

   replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)

.. figure:: ../../figures/toggle_just_tmr.png
   :width: 600px
   :align: center

   Design After Triplication

Then we insert voters using insert_organs().

.. code-block::

   voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), 'VOTER')

While viewing the schematic, note that the voters' outputs feed back into the flip flops. This will get the flip flop onto the correct state if its previous output was outvoted. Also note that one of the voters outputs to the 'out' port.

.. figure:: ../../figures/toggle_tmr_with_voters.png
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
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter


netlist = sdn.load_example_netlist_by_name("toggle")

uniquify(netlist)

hinstances_to_replicate = list(
    netlist.get_hinstances(
        recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
    )
)
instances_to_replicate = list(x.item for x in hinstances_to_replicate)

hports_to_replicate = list(
    netlist.get_hports(filter=lambda x: x.item.direction is sdn.IN)
)
for x in hports_to_replicate:
   if "clk" in x.name:
      hports_to_replicate.remove(x)
ports_to_replicate = list(x.item for x in hports_to_replicate)

insertion_points = find_voter_insertion_points_before_ff(
    [*hinstances_to_replicate, *hports_to_replicate],
    {"FDRE", "FDSE", "FDPE", "FDCE"},
)

replicas = apply_nmr(
    [*instances_to_replicate, *ports_to_replicate],
    3,
    name_suffix="TMR",
    rename_original=True,
)

voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), "VOTER")

netlist.compose("toggle_tmr.edf")
