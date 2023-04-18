Medium Vivado to Vivado
=======================

This walkthrough uses a slightly more complicated design than the basic simpleCounter example.
  
Uploading the Verilog HDL into Vivado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create the project and add **pong.sv**, **top_pong.sv**, **BallDrawer.sv**, **bitmaptovga.sv**, **clk_generator.sv**, **SevenSegmentControl.sv**, and **VLineDrawer.sv** to the project.

Download: |pong.sv|

Download: |top_pong.sv|

Download: |BallDrawer.sv|

Download: |bitmaptovga.sv|

Download: |clk_generator.v|

Download: |SevenSegmentControl.sv|

Download: |VLineDrawer.sv|


Export the Netlist from Vivado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After adding the files to your project, go to the "Flow Navigator" window on the left hand side of the screen, and click on "Run Synthesis."

Once synthesis has been run expand the “Open Synthesized Design” tab under the “Synthesis” section, and click on the “Schematic” option.

To Export the Netlist click on File in the upper left, go down to Export, then click on Export Netlist.

* If downloading an EDIF file change the file type from .edn to .edf (The python script in this walkthrough uses .edf to run tmr on EDIF netlists).

Using the tcl command line in Vivado
""""""""""""""""""""""""""""""""""""

* To export the netlist using the tcl command line type **write_edif pong.edf** or **write_verilog pong.v**

Triplicating the design - SpyDrNet TMR 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If using the .edf file, download and run the following edf TMR python script.
   
Download: |edf_tmr_script.py|

If using the .v file, download and run the following verilog TMR python script.

Download: |verilog_tmr_script.py|

* Tip: Make sure that the python script(s) and the netlist(s) from vivado are both in the same location. 

SpyDrNet TMR to Vivado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create new project in Vivado and choose Post-synthesis Project.

If working with a .edf file, upload **pong_tmr.edf** and **pong_tmr.xdc** to the project.

If working with a .v file, upload **pong_tmr.v** and **pong_tmr.xdc** to the project.

**NOTE:** If the .xdc file is downloaded from the link below, rename the file from pong_tmr.xdc.txt to pong_tmr.xdc

Download: |pong_tmr.xdc|

Vivado to Bitstream
~~~~~~~~~~~~~~~~~~~

After adding the source files for your project, go to the "Flow Navigator" window on the left hand side of the screen, and click on "Generate Bitstream" under "Program and Debug."

Once the Bitstream has been generated click on "Open Hardware Manager" under the tab "Program and Debug", click on "Open Target" then click on "Auto Connect", next click on "Program Device". 

A window should open up, click on program to download the bitstream to your device.

Verifying if the Design Works
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should be able to play a game of pong through VGA. BTNU and BTNL control the left paddle, BTNR and BTND control the right paddle and BTNC resets the game.

Files:

|pong.sv|

.. |pong.sv| replace::
   :download:`pong.sv <pong.sv>`

|top_pong.sv|

.. |top_pong.sv| replace::
   :download:`top_pong.sv <top_pong.sv>`

|BallDrawer.sv|

.. |BallDrawer.sv| replace::
   :download:`BallDrawer.sv <BallDrawer.sv>`

|bitmaptovga.sv|

.. |bitmaptovga.sv| replace::
   :download:`bitmaptovga.sv <bitmaptovga.sv>`

|clk_generator.v|

.. |clk_generator.v| replace::
   :download:`clk_generator.v <clk_generator.v>`

|SevenSegmentControl.sv|

.. |SevenSegmentControl.sv| replace::
   :download:`SevenSegmentControl.sv <SevenSegmentControl.sv>`

|VLineDrawer.sv|

.. |VLineDrawer.sv| replace::
   :download:`VLineDrawer.sv <VLineDrawer.sv>`

|pong.edf|

.. |pong.edf| replace::
   :download:`pong.edf <pong.edf>`

|pong_tmr.edf|

.. |pong_tmr.edf| replace::
   :download:`pong_tmr.edf <pong_tmr.edf>`

|pong_tmr.xdc|

.. |pong_tmr.xdc| replace::
   :download:`pong_tmr.xdc <pong_tmr.xdc>`

|edf_tmr_script.py|

.. |edf_tmr_script.py| replace::
   :download:`edf_tmr_script.py <edf_tmr_script.py>`

|pong.v|

.. |pong.v| replace::
   :download:`pong.v <pong.v>`

|pong_tmr.v|

.. |pong_tmr.v| replace::
   :download:`pong_tmr.v <pong_tmr.v>`

|verilog_tmr_script.py|

.. |verilog_tmr_script.py| replace::
   :download:`verilog_tmr_script.py <verilog_tmr_script.py>`
