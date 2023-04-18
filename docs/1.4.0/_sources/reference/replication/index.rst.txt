Circuit Replication
===================

The goal of circuit replication is to replicate all or a subset of circuit components in a netlist to the n-th degree in
an automated way. Supporting this functionality includes the insertion of voters, detectors, and detection networks as
needed. This can be accomplished in many ways. It can be done using :ref:`spydrnet_tmr`. It can also be done at the 
:ref:`hdl_level`, or :ref:`natively` in vendor or third-party tools. Focus is given here to the use of 
:ref:`spydrnet_tmr`.

.. toctree::
   :maxdepth: 1
   
   spydrnet_tmr
   hdl_level
   natively