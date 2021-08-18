.. _voter_algorithms:

Voter Algorithms
================

Currently, SpyDrNet TMR employs the following voter insertion algorithms:

    * Place a feedback voter after every flip-flop. See :ref:`find_voter_insertion_after_ff`
    * Place a feedback voter before every flip-flop. See :ref:`find_voter_insertion_before_ff`
    * Place reduction voters where TMR boundaries are crossed (i.e. goes from triplicated to non triplicated). See :ref:`find_reduction_voter_points` and :ref:`identify_reduction_points`

.. toctree::
   :maxdepth: 2

   find_voter_insertion_points_before_ff
   find_voter_insertion_points_after_ff
   find_reduction_voter_points
   identify_reduction_points