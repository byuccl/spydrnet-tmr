Yosys -> TMR -> F4PGA
=====================
   
Install F4PGA
~~~~~~~~~~~~~

Follow the walkthough on how to install F4PGA `here <https://f4pga-examples.readthedocs.io/en/latest/getting.html>`_.

Modify F4PGA Scripts
~~~~~~~~~~~~~~~~~~~~

Once F4PGA has been installed

1. Type in command line **~/opt/f4pga/xc7/install/share/symbiflow/scripts/xc7/**
2. Open synth.tcl. 

   * Add the “-nocarry” option to all of the synth_xilinx commands. 

3. Open conv.tcl. 

   * Add “hierarchy -purge_lib” as the first command, 
   * Add option “-blackbox” to both write_blif commands

Download all of the following files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

|simpleCounter.sv|

|simpleCounter.xdc|

|new_constraints.txt|

|tmr_script.py|

|common.mk|

|Makefile|

Running Yosys, SpyDrNet TMR, and F4PGA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once all of the files have been downloaded type navigate to their location and type in the command line
export F4PGA_INSTALL_DIR=~/opt/f4pga


>>> make -C .

Programming Device
^^^^^^^^^^^^^^^^^^

To download the bitstream to the board using the command line

>>> make download

Verifying if the Design Works
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The counter in this design increments when btnc is pressed. Once it reaches a count of 16 it rolls over to 0 and starts counting up again. If at any point btnu is pressed the count is reset to 0.
Since this is a TMR design there should be 3 sets of 4 leds in total.

* Set 1 (LEDS 0-3), Set 2 (LEDs 5-8), Set 3 (LEDs 10-13)

.. note:: 
   1. This example was designed using a BASYS 3 board. If a different FPGA is being used the simpleCounter.xdc and the new_constraints.txt file will need to be modified accordingly. 
   2. Make sure all of the files are in the same location. If not the path to the file will need to be specified
   3. If getting errors with common.mk make sure that all of the indents are tabs and not spaces.
   4. Downloading the bitstream can be done in the same command **make download -C .**


.. |simpleCounter.sv| replace::
   :download:`simpleCounter.sv <simpleCounter.sv>`


.. |simpleCounter.xdc| replace::
   :download:`simpleCounter.xdc <simpleCounter.xdc>`


.. |new_constraints.txt| replace::
   :download:`new_constraints.txtc <new_constraints.txt>`


.. |tmr_script.py| replace::
   :download:`tmr_script.py <tmr_script.py>`


.. |common.mk| replace::
   :download:`common.mk <common.mk>`


.. |Makefile| replace::
   :download:`Makefile <Makefile>`









