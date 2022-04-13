SpyDrNet-TMR and Symbiflow
===========================

As of version 1.11.0, `SpyDrNet <https://byuccl.github.io/spydrnet/docs/stable/index.html>`_ supports the EBLIF netlist format. This was done in hope that SpyDrNet-TMR could be used to replicate designs run through Symbiflow.

**Note:** The following is intended for designs targeted for Xilinx devices. Other device families have not been tested yet, but can likely follow a similar procedure.

Steps to Replicate Designs Inside of Symbiflow
-----------------------------------------------
1. Install symbiflow and enter the environment. See `this page <https://f4pga-examples.readthedocs.io/en/latest/getting.html>`_ in the Symbiflow documentation on how to do so.
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

5. Add command to execute python tmr script
   
   * Executing the python script needs to be done between symbiflow_synth and symbiflow_pack. Do one of the following two options:
   * As the last command in conv.tcl from the previous step, put: 
  
      >>> exec python3 $::env(TMR_SCRIPT) $::env(OUT_EBLIF) $::env(CONSTRAINT_NEW)

   * Or, in the line under the symbiflow_synth command in common.mk (so right under line 56), put:

      >>> python3 ${TMR_SCRIPT} ${BOARD_BUILDDIR}/${TOP}.eblif ${CONSTRAINT_NEW}

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

   export TMR_SCRIPT
   export CONSTRAINT_NEW

   include <path to common.mk>

2. **common.mk** - this is a common Makefile found under *symbiflow/symbiflow-examples/common*. You can copy and paste it into your current directory or just set the path to it. Either way, be sure to include a path to it.

3. **Verilog Source Files**

4. **XDC (Constraint File)** - constraints for the design as if it were not to be replicated. This keeps symbiflow_synth from running into errors.
5. **CONSTRAINT_NEW** - simple text file that contains port_name:pin pairs. Note that only ports that are replicated should be included.
   
   The following is a line from a constraints file for #4:

   .. code-block:: 

      set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; 
   
   And here are the matching replicated constraints for #5:

   .. code-block::

      sw_TMR_0[0] V17
      sw_TMR_1[0] V16
      sw_TMR_2[0] W16

6. **TMR_SCRIPT** - a python script that uses SpyDrNet to replicate the design. See next section.

Create the Python Script
^^^^^^^^^^^^^^^^^^^^^^^^^
In the TMR script, be sure to do the following:
   * Replicate design and insert voters
   * Connect unconnected pins to dummy nets. See :ref:`connect_unconn_to_dummy`.
   * Update constraints. See :ref:`update_constraints`.
   * Compose the netlist to the same file name that was parsed in.


**Tips:** 
   * If down the line symbiflow fails, try not replicating instances with “iopadmap” in their name that are next to non-replicated ports. E.g. inserting reduction voters. Don't put them between ports and instances called “iopadmap” (even if it's not a buffer). Put the voters on the inner side of those (before or after depending on port direction).
   * See also :ref:`fixup_netlist`

Running Symbiflow
^^^^^^^^^^^^^^^^^^
With all of the files in place, one should be able to run the following:

>>> TARGET="board_name" make -C .

Where <board_name> is replaced with the target board name (e.g. basys3). Symbiflow will run and generate a bitstream.

Synchronous Counter Example With Example Files
-----------------------------------------------

Notes: 
   * All files are in the same directory
   * Notice how we only replicate the output ports so those are the only constraints we need to specify in the CONSTRAINT_NEW file

**Makefile**

.. code-block:: make

   current_dir := ${CURDIR}
   TOP := synchronouscounter
   SOURCES := ${current_dir}/synchronouscounter.v
   TMR_SCRIPT := ${current_dir}/tmr_script.py

   export TMR_SCRIPT
   export CONSTRAINT_NEW

   XDC := ${current_dir}/constraints.xdc
   CONSTRAINT_NEW := ${current_dir}/new_constraints.txt

   include common.mk

**common.mk** (this file is as described above and can be copied exactly)

.. code-block:: make

   TOP := $(strip ${TOP})
   TARGET := $(strip ${TARGET})

   BUILDDIR := ${current_dir}/build
   BOARD_BUILDDIR := ${BUILDDIR}/${TARGET}

   # Set board properties based on TARGET variable
   ifeq ($(TARGET),arty_35)
   DEVICE := xc7a50t_test
   BITSTREAM_DEVICE := artix7
   PARTNAME := xc7a35tcsg324-1
   else ifeq ($(TARGET),arty_100)
   DEVICE := xc7a100t_test
   BITSTREAM_DEVICE := artix7
   PARTNAME := xc7a100tcsg324-1
   else ifeq ($(TARGET),nexys4ddr)
   DEVICE := xc7a100t_test
   BITSTREAM_DEVICE := artix7
   PARTNAME := xc7a100tcsg324-1
   else ifeq ($(TARGET),zybo)
   DEVICE := xc7z010_test
   BITSTREAM_DEVICE := zynq7
   PARTNAME := xc7z010clg400-1
   else ifeq ($(TARGET),nexys_video)
   DEVICE := xc7a200t_test
   BITSTREAM_DEVICE := artix7
   PARTNAME := xc7a200tsbg484-1
   else ifeq ($(TARGET),basys3)
   DEVICE := xc7a50t_test
   BITSTREAM_DEVICE := artix7
   PARTNAME := xc7a35tcpg236-1
   else
   $(error Unsupported board type)
   endif

   # Determine the type of constraint being used
   ifneq (${XDC},)
   XDC_CMD := -x ${XDC}
   endif
   ifneq (${SDC},)
   SDC_CMD := -s ${SDC}
   endif
   ifneq (${PCF},)
   PCF_CMD := -p ${PCF}
   endif

   .DELETE_ON_ERROR:

   # Build design
   all: ${BOARD_BUILDDIR}/${TOP}.bit

   ${BOARD_BUILDDIR}:
      mkdir -p ${BOARD_BUILDDIR}

   ${BOARD_BUILDDIR}/${TOP}.eblif: ${SOURCES} ${XDC} ${SDC} ${PCF} | ${BOARD_BUILDDIR}
      cd ${BOARD_BUILDDIR} && symbiflow_synth -t ${TOP} -v ${SOURCES} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} ${XDC_CMD} 2>&1 > /dev/null
      # python3 ${TMR_SCRIPT} ${BOARD_BUILDDIR}/${TOP}.eblif ${CONSTRAINT_NEW}

   ${BOARD_BUILDDIR}/${TOP}.net: ${BOARD_BUILDDIR}/${TOP}.eblif
      cd ${BOARD_BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} ${SDC_CMD} 2>&1 > /dev/null

   ${BOARD_BUILDDIR}/${TOP}.place: ${BOARD_BUILDDIR}/${TOP}.net
      cd ${BOARD_BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} ${PCF_CMD} -n ${TOP}.net -P ${PARTNAME} ${SDC_CMD} 2>&1 > /dev/null

   ${BOARD_BUILDDIR}/${TOP}.route: ${BOARD_BUILDDIR}/${TOP}.place
      cd ${BOARD_BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} ${SDC_CMD} 2>&1 > /dev/null

   ${BOARD_BUILDDIR}/${TOP}.fasm: ${BOARD_BUILDDIR}/${TOP}.route
      cd ${BOARD_BUILDDIR} && symbiflow_write_fasm -e ${TOP}.eblif -d ${DEVICE}

   ${BOARD_BUILDDIR}/${TOP}.bit: ${BOARD_BUILDDIR}/${TOP}.fasm
      cd ${BOARD_BUILDDIR} && symbiflow_write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

   download: ${BOARD_BUILDDIR}/${TOP}.bit
      if [ $(TARGET)='arty_35' ]; then \
      openocd -f ~/opt/symbiflow/xc7/conda/envs/xc7/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 ${BOARD_BUILDDIR}/${TOP}.bit; exit"; \
      elif [ $(TARGET)='arty_100' ]; then \
      openocd -f ~/opt/symbiflow/xc7/conda/envs/xc7/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 ${BOARD_BUILDDIR}/${TOP}.bit; exit"; \
      elif [ $(TARGET)='basys3' ]; then \
      openocd -f ~/opt/symbiflow/xc7/conda/envs/xc7/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 ${BOARD_BUILDDIR}/${TOP}.bit; exit"; \
      else  \
      echo "The commands needed to download the bitstreams to the board type specified are not currently supported by the F4PGA makefiles. \
      Please see documentation for more information."; \
      fi


   clean:
      rm -rf ${BUILDDIR}

**Verilog Source File** (synchronouscounter.v)

.. code-block:: Verilog

   module synchronouscounter(clk,reset,count);
	input clk,reset;
	output reg [3:0] count;

        always@(posedge clk)
        begin
                if(reset)
                        count <= 4'b0000;
                else
                        count <= count + 1;
        end

   endmodule

**XDC** (constraints.xdc)

.. code-block::

   set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { clk }]; 
   set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { reset }]; 
   set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { count[0] }]; 
   set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports { count[1] }]; 
   set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { count[2] }]; 
   set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { count[3] }]; 

**CONSTRAINT_NEW** (new_constraints.txt)

.. code-block:: text

   count_TMR_0[0] U16
   count_TMR_0[1] E19
   count_TMR_0[2] U19
   count_TMR_0[3] V19
   count_TMR_1[0] U15
   count_TMR_1[1] U14
   count_TMR_1[2] V14
   count_TMR_1[3] V13
   count_TMR_2[0] W3
   count_TMR_2[1] U3
   count_TMR_2[2] P3
   count_TMR_2[3] N3

**TMR_SCRIPT** (tmr_script.py)

.. code-block:: python

   import os
   import spydrnet as sdn
   from spydrnet.uniquify import uniquify
   from spydrnet_tmr.transformation.replication.nmr import apply_nmr
   from spydrnet_tmr.analysis.voter_insertion.find_after_ff_voter_points import find_after_ff_voter_points
   from spydrnet_tmr.analysis.identify_reduction_points import identify_reduction_points
   from spydrnet_tmr.support_files.vendor_names import XILINX
   from spydrnet_tmr.transformation.replication.organ import GenericEBLIFVoter
   from spydrnet_tmr.transformation.replication.organ_insertion import insert_organs
   from spydrnet.util.selection import Selection
   from spydrnet_tmr.symbiflow import fix_and_update_constraints
   from spydrnet_tmr.symbiflow import connect_unconn_to_dummy

   def run_tmr(netlist_name, new_constraints_file=None):

      print("Attempting to replicate design using Spydrnet")

      netlist = sdn.parse(netlist_name)


      uniquify(netlist)

      #    netlist.compose("before_TMR.eblif")

      hinstances = list(x for x in netlist.get_hinstances(filter = lambda x: x.item.is_leaf()
                                                         and "VCC" not in x.name
                                                         and "GND" not in x.name
                                                         and "ibuf" not in x.name.lower()
                                                         and "IBUF" not in x.item.reference.name ))

      instances = list(x.item for x in hinstances)

      hports = list(x for x in netlist.get_hports() if x.item.direction is sdn.OUT)
      ports = list(x.item for x in hports)

      # this will return an empty set because symbiflow renames primitives and spydrnet doesn't recognize them (e.g. FDRE is FDRE_ZINI)
      insertion_points = find_after_ff_voter_points(netlist, [*hinstances, *hports], XILINX)

      # so manually find the insertion points here
      for instance in netlist.get_instances():
         if "FDRE" in instance.reference.name:
               output_pin = next(pin for pin in instance.get_pins(selection=Selection.OUTSIDE,
                                 filter = lambda x: x.inner_pin.port.direction is sdn.OUT))
               insertion_points.add(output_pin)

      suffix = "TMR"
      replicas = apply_nmr([*instances, *ports], 3, suffix, True)

      # check for any points needing reduction voters and add them to the insertion points set
      insertion_points_more = identify_reduction_points(replicas, suffix)
      for point in insertion_points_more:
         insertion_points.add(point)

      print("Total Insertion Points Found: " + str(len(insertion_points)))
      voters = insert_organs(replicas, insertion_points, GenericEBLIFVoter(),"VOTER",True)

      connect_unconn_to_dummy(netlist)
      if os.path.isfile(new_constraints_file):
         fix_and_update_constraints(netlist, replicas, new_constraints_file, suffix)

      netlist.compose(netlist_name,write_blackbox=False,write_eblif_cname=False)
      print("Design successfully replicated using Spydrnet")


   import sys

   if __name__:
   if len(sys.argv) >= 3:
      run_tmr(sys.argv[1], sys.argv[2])
   else:
      run_tmr(sys.argv[1])

Functions Referenced
^^^^^^^^^^^^^^^^^^^^^
.. toctree::
   :maxdepth: 1
   
   update_constraints
   fix_unconn_nets
   fixup_netlist