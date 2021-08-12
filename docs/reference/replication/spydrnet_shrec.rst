.. _spydrnet_tmr:

SpyDrNet TMR
==============

The following steps are taken to apply circuit replication using SpyDrNet TMR:

#. Export_
#. Parse_
#. Select_
#. Apply_
#. Compose_
#. Import_

Export
------

The netlist of the target design needs exported from wherever it originates into a format that SpyDrNet TMR can 
recognize. Currently that format is EDIF.

From Vivado
^^^^^^^^^^^

Netlists can be exported from Vivado using the following command (in either the synthesis or implementation view):

.. code:: tcl

    Vivado% write_edif <name_of_top_level_instance>.edf
    
Note that this command will export an unencrypted netlist and any encrypted portions of the netlist as separate files.
Traditionally, encrypted portions of IP cores have been treated as `blackboxes`, which the user may or may not want to
replicate.

.. todo:: Create a page that talks about blackboxes.
    
Accompanying constraints can be exported from Vivado using the following command:

.. code:: tcl

    Vivado% write_xdc -constraints ALL <name_of_top_level_instance>.xdc
    
The references made in the constraints match the name of components in the netlist. Replication is applied in such a 
way that the number of changes made to the orginal netlist are minimized. This is done to in turn minimize the number of
changes that are needed to preserve the functionality of the constraints.

Parse
-----

SpyDrNet TMR uses the SpyDrNet intermeidate representation. Netlists can be parsed into memory using the SpyDrNet 
framework. SpyDrNet TMR accepts these objects.

.. code:: python

    >>> import spydrnet as sdn
    >>> netlist = sdn.parse('<path_of_the_netlist_file>.edf')


Select
------

Here is where circuit replication gets interesting. The elements within a netlist must be selected for circuit 
replication. Most netlists will be rendered useless if all circuit elements are replicated. Things to consider are:

- Top level ports/pins, and
- Component instances

Top Level Ports and Pins
^^^^^^^^^^^^^^^^^^^^^^^^

Depending on the netlist usage, the user may or may not want to replicate top level ports or pins, or the user may want
to only replicate a subset of the top level ports or pins. SpyDrNet TMR requires that the ports for replication be
explicitly specified. That can be done through a get query or through an automated selection algorithm.

Ports can be specified directly or as hierarchical references. The following commands return the top level ports by 
direct reference and hierarchical reference respectively:

.. code:: python

    >>> ports_by_direct_reference = list(sdn.get_ports(netlist.top_instance))
    >>> ports_by_hierarchical_reference = list(sdn.get_hports(netlist))  # equivalent to the following
    >>> ports_by_hierarchical_reference = list(sdn.get_hports(netlist.top_instance))
    
Replicating a single pin on a port is not possible at this time.

Instances
^^^^^^^^^

Like ports, components too must be explicitly specified for replication. This can be done manually or through an
automated selection algorithm. There are many ways that circuit components can be selected.

Likely, the most commmon mode of selection (even for automated selections algorithms) will be through get queryies. Here
are some examples.

All leaf components (returns all components within the netlist that are leaf components - not hierarchical modules):

.. code:: python

    >>> def is_leaf(hinst):
    ...     reference = hinst.item.reference
    ...     if reference.is_leaf() is True:
    ...         return True
    ...     return False
    ...
    >>> leaf_cells = list(netlist.get_hinstances(recursive=True, filter=is_leaf))
    
Only combinational lookup tables:

.. code:: python

    >>> def is_leaf_and_combinational(hinst):
    ...     reference = hinst.item.reference
    ...     if reference.is_leaf() is True and reference.name.startswith("LUT") is True:
    ...         return True
    ...     return False
    ...
    >>> comb_insts = list(netlist.get_hinstances(recursive=True, filter=is_leaf_and_combinational)) 

Direct Verses Hierarchical References
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Selection of ports and instances may be given as direct or hierarchical reference. A direct reference refers to 
the element of a netlist directly without any consideration to that element's position in hierarchy. In a netlist 
where all non-leaf definitions are instanced only once, there is virtually no difference between a direct reference and
a hierarchical reference. In that situation, the contents of a definition (other than port configuration) is not shared
amoung multiple instances. In situations where a non-leaf cells is instanced more than once, a hierarchical reference
allows the user to point to a specific instance through multiple layers of hierarchy. This is useful for analysis and
also for differentiation between which specific elements should or should not be replicated.

Circuit replication behaves differently depending on the type of reference provided. If direct references are provided, 
all instances of the underlying definition or port will be affected by the replication. If a hierarchical reference is
provided, circuit replication will ensure that the underlying defintion is unique (instanced only one through out 
hierarchy). Making necessary copies and updating instance references to accomplish this can render the original 
reference invalid. When this happens an original to updated reference map is provided.

Voter/Detector Insertion Point Selection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Voters and detectors can be inserted in many different ways throughout a design. Previous work has explored various
voter insertion algorithms [Johnson2010]_.

Detectors tap into a signal. Voters cut signal paths (are inserted into signal paths). Therefore, detector and voter
insertion points may be specified by instance, port, or pin, but only voter insertion points can be customized to 
include only a subset of the end points. This customization comes in handy when a voter is desired to break a feedback 
path and increasing the critical path downstream is not desired.

.. todo:: Make a figure showing a lut-register pair with tight feedback driving a long chain of combinational logic. 
   show that a voter can be inserted between the register output and the LUT input without lengthening the downstream
   combinational path (beyond the added load of the voter - i.e., the voter is not placed in the critical path.

Voter Insertion Algorithms
++++++++++++++++++++++++++

.. todo:: Add details about the various voter insertion algorithms that could be used including split vote (if the two 
   on the end agree, have them use their own signal, if they disagree, use the middle signal).

Apply
-----

Partial circuit replication is applied in two or three stages depending on the type. The first stage is called *NMR*. 
In this stage, the selected instances and ports are replicated to the n-th degree and a map is returned from the 
selected components to their replicated counterparts. Other than the degree of replication, this stage is the same for
all replication types. The second stage is called *OrganInsertion*. This name stems from the orignal paper by John
Von Neumann where TMR was first proposed [VonNeumann1956]_. This stage inserts voters or detector at the desired 
insertion points. The final stage is called *NetworkInsertion*. NetworkInsertion inserts a network used to collect 
error detection signals. There is enormous flexible in the manner in which error detection signals signals can be 
collected. The final stage is only used for error signal collection [#f1]_.

NMR
^^^

inputs - netlist, ports to replicate (direct or hierarchical reference), instances to replicate (direct or 
hierarchical reference), naming suffix, degree of replication (1 - do nothing, 2, 3, 4, 5, ...)

output - modified netlist (not a duplicate), hierarchical reference map (invalid to valid), original to replicates 
(in the form they were provided in).

OrganInsertion
^^^^^^^^^^^^^^


NetworkInsertion
^^^^^^^^^^^^^^^^

Compose
-------

Import
------

References
----------
.. [Johnson2010] Jonathan M. Johnson and Michael J. Wirthlin. 2010. Voter insertion algorithms for FPGA designs using 
   triple modular redundancy. In Proceedings of the 18th annual ACM/SIGDA international symposium on Field programmable 
   gate arrays (FPGA ’10). Association for Computing Machinery, New York, NY, USA, 249–258. 
   DOI: https://doi.org/10.1145/1723112.1723154
   
.. [VonNeumann1956] Von Neumann, John. "Probabilistic logics and the synthesis of reliable organisms from unreliable 
   components." Automata studies 34 (1956): 43-98.

Footnotes
---------

.. [#f1] Imagine a TMR/DWC hybrid where voters are also detectors. (Think LUT6_2, one output is a voter, the other says
   that this domain is odd man out.)