.. _voter_algorithms:

Voter Algorithms
================

Insertion Algorithms
^^^^^^^^^^^^^^^^^^^^

Currently, SpyDrNet TMR employs the following voter insertion algorithms:

    * Place a voter after every high-fanout flip-flop
    * Place a voter after every flip-flop
    * Place a voter before every flip-flop

Voting Algorithms
^^^^^^^^^^^^^^^^^

Several different voting algorithms exist. Some are:

    * **Majority Vote**
    * **Split Vote** - if the two outside voters agree, use their signal. Otherwise, use the inside voter's signal.


Currently, SpyDrNet TMR only has voters that use the majority vote algorithm.