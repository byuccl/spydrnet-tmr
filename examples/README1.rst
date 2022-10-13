.. _sec:examples:

Examples
========

A collection of examples to introduce the functionality, features, and uses of SpyDrNet-SHREC. To see more examples of things that can be done with SpyDrNet-SHREC, please see the `SpyDrNet-TMR documentation <https://byuccl.github.io/spydrnet-tmr/docs/1.0/index.html>`_

Usages
------

SpyDrNet-SHREC has been used in a number of different projects and applications. Three of the 
more recent usages have been the NetFPGA project, Cisco commericial networking projects, and
a recent publication on partial TMR in NSREC. A collections of scripts from these projects are
included and referenced here.

FPGA networking reliability
---------------------------

Several different implementations of partial TMR and partial DWC have been applied to two 
FPGA-based computer networking designs. The first design is a custom built design based on
an open source project, the NetFPGA. The second design is a Cisco FPGA-based networking
application called the Terminator.

Scripts for applying partial TMR and DWC to these designs are found in the 
FPGA-networking-reliability repository: https://github.com/byuccl/fpga-networking-reliability .
If you are unable to access this repository, please ask for permission from an BYUCCL organization admin.

These scripts are located in https://github.com/byuccl/fpga-networking-reliability/tree/master/scripts .

There are three scripts in the lut_dwc folder:

- dwc_terminator_sticky.py -- This script was used by a Cisco Intern to apply DWC to a newer build of the Cisco terminator design. This script uses a list of identified sensitive LUTs found in the terminator_luts_hierarchy folder. Any components found in the design that match the name of sensitive components in the list are chosen for replication. Anything that drives and is driven by componets selected for replication is also replicated. If a component is selected for triplication that is a part of a carry chain, the entire carry chain is replicated. A "find_detector_insertion_points" function in this scripts inserts a detector anywhere a replicated endpoint drives a non-replicated endpoint. This script brings detector clock and reset pins the the surface. It connects the clock source pins to the clock sink pins and it connects the resets to a reset driven by a JTAG module. Errors are detected by capturing register values and reading them out over JTAG.
- netfpga_switch_partial_dwc_sensitive_luts_driven_and_driven_by_logic.py -- This script is very similar to the previous, only it is for the net FPGA design.
- terminator_G1_partial_dwc_sensitive_luts_driven_and_driven_by_logic.py -- This script is very similar to the previous, only it is for the original terminator build project.

There are several scripts in the lut_tmr folder:

- netfpga_switch_partial_tmr_aggressive.py -- This script or the next was used in the original partial TMR experiment on the NetFPGA (Dec 2018 NSREC beam test).
- netfpga_switch_partial_tmr_conservative.py -- This script or the previous was used in the original partial TMR experiment on the NetFPGA (Dec 2018 NSREC beam test).
- netfpga_switch_partial_tmr_sensitive_luts.py -- This script is used in chapter 7 of Andrew Keller's dissertation.
- netfpga_switch_partial_tmr_sensitive_luts_comb_logic_and_reg_inbetween.py -- This script is used in chapter 7 of Andrew Keller's dissertation.
- netfpga_switch_partial_tmr_sensitive_luts_driven_and_driven_by_logic.py -- This script is used in chapter 7 of Andrew Keller's dissertation.
- netfpga_switch_partial_tmr_with_sensitive_luts_comb_logic.py -- This script is used in chapter 7 of Andrew Keller's dissertation.
- terminator_G1_partial_tmr_not_downstream_from_brams.py
- terminator_G1_partial_tmr_sensitive_luts_driven_and_driven_by_logic.py
- terminator_G1_partial_tmr_sensitive_luts_only.py

There is one script in the terminator_luts_hierarchy folder:

- sensitive_lut_analysis.py -- This script takes a list of objects identified as sensitive through fault injection or otherwise (such as sensitive_luts_final.txt in the same folder) and organizes them hierarchically to count the number of items identified within a hierarchical subregion. The script produces a file with the total count result at each hierarhical level (see counts_for_hierarchical_level.txt in the same folder). The result is best viewed as a yaml file in Notepad++ or another similar text editor that will allow the different levels of hierarchy to be collapsed. This script may help identify modules in hierarchy that disproportionately house more sensitive components than other modules within the design.

B13
---

Additional partial TMR scripts are included in the B13 folder. These scripts from the partial TMR study conducted for the following paper: https://ieeexplore.ieee.org/document/9395134


