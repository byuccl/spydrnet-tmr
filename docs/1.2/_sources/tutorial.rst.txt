Tutorial
========

It is highly recommended that one spends time learning and going through the tutorial and examples for SpyDrNet, as a good understanding of it is the foundation to using SpyDrNet TMR. See `SpyDrNet Tutorial <https://byuccl.github.io/spydrnet/docs/stable/tutorial.html>`_.

SpyDrNet TMR Features
-----------------------------

SpyDrNet TMR allows for easy replication of and organ insertion into designs.

**Triple Modular Redundancy (TMR)**
    * TMR is used to mask errors in FPGA computing. A design is triplicated and voters are inserted. If one of the domains becomes corrupted, the other two domains will override the output with a majority vote. TMR has proven to be effective in reducing errors in output.

**Duplicate With Compare (DWC)**
    * DWC is used to detect errors in FPGA computing. A design is duplicated and comparators inserted. During operation, outputs are continually compared to the other. When a difference is detected, an error is reported.

Doing Design Replication
------------------------

Parse
^^^^^^
    Parse a netlist file using the following command:

    .. code-block::

        netlist = sdn.parse('<netlist_filename>.edf')

    Or the following for a Verilog file
    
    .. code-block::

        netlist = sdn.parse('<netlist_filename>.v')

Uniquify
^^^^^^^^^
    Calling uniquify() will ensure that non-leaf definitions are instanced only once to prevent unintended transformations. In other words, each non-leaf instance is made into its own definition.
    
    .. code-block::

        uniquify(netlist)

Determine What To Replicate
^^^^^^^^^^^^^^^^^^^^^^^^^^^
    **Ports** - what top-level input and output ports should be replicated? It is up to the user. Users may want to replicate all of the ports, just input ports, just output ports, or no ports at all.

    **Instances** - to replicate the full design, this is all of the instances.

    Example Code for Finding Ports and Instances to Replicate:
    
    .. code-block::

        hinstances_to_replicate = list(netlist.get_hinstances(recursive=True, filter=lambda x: x.item.reference.is_leaf() is True))
        instances_to_replicate = list(x.item for x in hinstances_to_replicate)
        
        hports_to_replicate = list(netlist.get_hports(filter = lambda x: x.item.direction is sdn.IN))
        ports_to_replicate = list(x.item for x in hports_to_replicate)

Determine Organ Insertion Points
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    We call find_after_ff_voter_points() to determine where organs will be inserted. We pass the ports and instances to replicate and the flip flop types as parameters. A list of outer pins is returned. Each pin in the list corresponds to an instance's output at which an organ will be placed.
    
    Note: one does not have to use find_after_ff_voter_points() but can instead specify the outer pins themselves (one would probably not want to use this function when finding detector insertion points, as it will most likely find more places to put detectors than is desired).
    
    Other voter insertion point algorithms are available. See :ref:`voter_algorithms`
    
    .. code-block::

        insertion_points = find_after_ff_voter_points([*hinstances_to_replicate, *hports_to_replicate], {'FDRE', 'FDSE', 'FDPE', 'FDCE'})

Replicate the Design
^^^^^^^^^^^^^^^^^^^^^
    apply_nmr() will replicate the design until there are 'n' amount of them. A map of each element replicated to its replicas is returned. In this example it is replicated 3 times (triplicated).
    
    If we were doing DWC, '3' would be replaced by '2' and 'TMR' replaced by 'DWC'.
    
    .. code-block::

        replicas = apply_nmr([*instances_to_replicate, *ports_to_replicate], 3, name_suffix='TMR', rename_original=True)

Insert Organs
^^^^^^^^^^^^^
    insert_organs() will then insert the voters into the triplicated design (or detectors into the duplicated design). A map from each insertion point to the organs inserted there is returned.
    
    If we were doing DWC, 'XilinxTMRVoter' would be replaced by 'XilinxDWCDetector' and 'VOTER' replaced by 'DETECTOR'.
    
    .. code-block::

        voters = insert_organs(replicas, insertion_points, XilinxTMRVoter(), 'VOTER')

Compose
^^^^^^^
    Finally, compose an EDIF or Verilog netlist file from the modified netlist.
    
    .. code-block::
    
        sdn.compose(netlist,"<file_name>.edf")