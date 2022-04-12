Integrating SpyDrNet-TMR Into Symbiflow
=======================================

As of version 1.11.0, SpyDrNet supports the EBLIF netlist format. This was done in hope that SpyDrNet-TMR could be used to replicate designs run through Symbiflow.

**Note:** The following is intended for designs targeted for Xilinx devices. Other device families have not been tested yet, but can likely follow a similar procedure.

Steps to Replicate Designs Inside of Symbiflow
-----------------------------------------------
1. Install symbiflow and enter the environment. See `this page <https://symbiflow-examples.readthedocs.io/en/latest/getting-symbiflow.html#>`_ in the Symbiflow documentation on how to do so.
2. Modify built-in symbiflow scripts
3. Create needed files
4. Run

Modify Built-In Symbiflow Scripts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Go into the INSTALL_DIR specified when installing symbiflow (which is likely ~/opt/symbiflow/) 
2. Go to /xc7/install/share/symbiflow/scripts/xc7/. This directory contains files used by symbiflow_synth.
3. Open synth.tcl. Add the "-nocarry" option to all of the synth_xilinx commands. This is done because replicating designs with carry adders doesn't work too well. However, if one is experienced with replicating designs and would still like carry adders, this part can be ommitted.
4. Open conv.tcl. Add the following:
   
   * "hierarchy -purgelib" as the first command
   * Add option "-blackbox" to both write_blif commands
   * As the last command, put “exec python3 $::env(TMR_SCRIPT) $::env(OUT_EBLIF)”. This will run the SpyDrNet TMR script. The environment variables are described later.

Create Needed Files
^^^^^^^^^^^^^^^^^^^
1. **Makefile** - create a new Makefile. Copy and paste the following into it and enter the needed information.

.. code-block::

   current_dir := ${CURDIR}
   TOP := <name of top module>
   SOURCES := ${current_dir}/<path to Verilog source files>
   TMR_SCRIPT := ${current_dir}/<path to python TMR script>

   XDC := ${current_dir}/<original constraints file>
   CONSTRAINT_NEW := ${current_dir}/<file detailing new constraints>

   include <path to common.mk>

2. **common.mk** - this is a common Makefile found under *symbiflow/symbiflow-examples/common*. You can copy and paste it into your current directory or just set the path to it. Either way, be sure to include a path to it.

3. **XDC (Constraint File)** - constraints for the design as if it were not to be replicated. This keeps symbiflow_synth from running into errors.
4. **CONSTRAINT_NEW** - simple text file that contains port_name:pin pairs. Note that only ports that are replicated should be included.
   
   The following is a line from a constraints file for #3:

   .. code-block:: 

      set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; 
   
   And here are the matching replicated constraints for #4:

   .. code-block::

      sw_TMR_0[0] V17
      sw_TMR_1[0] V16
      sw_TMR_2[0] W16

5. **TMR_SCRIPT** - a python script that uses SpyDrNet to replicate the design. See next section.

Create the Python Script
^^^^^^^^^^^^^^^^^^^^^^^^^
In the TMR script, be sure to do the following:
   * Replicate design and insert voters
   * Connect unconnected pins to dummy nets. See :ref:`connect_unconn_to_dummy`.
   * Update constraints. See :ref:`update_constraints`. 
   * Compose the netlist to the same file name that was parsed in.


**Tip:** 
If down the line symbiflow fails, try not replicating instances with “iopadmap” in their name that are next to non-replicated ports. E.g. inserting reduction voters. Don't put them between ports and instances called “iopadmap” (even if it's not a buffer). Put the voters on the inner side of those (before or after depending on port direction).

Running Symbiflow
^^^^^^^^^^^^^^^^^^
With all of the files in place, one should be able to run the following:

>>> TARGET="board_name" make -C .

Where <board_name> is replaced with the target board name (e.g. basys3). Symbiflow will run and generate a bitstream.


.. toctree::
   :maxdepth: 1
   
   update_constraints
   fix_unconn_nets
   fixup_netlist