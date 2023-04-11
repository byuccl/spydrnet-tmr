Medium Yosys to F4PGA
=====================
   
F4PGA should have already been installed, if not do the basic Yosys/F4PGA `walkthrough <https://byuccl.github.io/spydrnet-tmr/docs/stable/simpleCounter/yosys_f4pga/index.html>`_.

Download all of the following files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

|pong.sv|

|top_pong.sv|

|BallDrawer.sv|

|bitmaptovga.sv|

|clk_generator.v|

|SevenSegmentControl.sv|

|VLineDrawer.sv|

|pong.xdc|

|new_constraints.txt|

|tmr_script.py|

|common.mk|

|Makefile|

Running Yosys, SpyDrNet TMR, and F4PGA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once all of the files have been downloaded type navigate to their location and type in the command line

>>> make -C .

or 

>>> make download -C .

**Note:** This will run Yosys and F4PGA then download the bitstream to the board

Programming Device
^^^^^^^^^^^^^^^^^^

To download the bitstream to the board using the command line

>>> make download

Verifying if the Design Works
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should be able to play a game of pong through VGA. BTNU and BTNL control the left paddle, BTNR and BTND control the right paddle and BTNC resets the game.

.. |pong.sv| replace::
   :download:`pong.sv <pong.sv>`

.. |top_pong.sv| replace::
   :download:`top_pong.sv <top_pong.sv>`

.. |BallDrawer.sv| replace::
   :download:`BallDrawer.sv <BallDrawer.sv>`

.. |bitmaptovga.sv| replace::
   :download:`bitmaptovga.sv <bitmaptovga.sv>`

.. |clk_generator.v| replace::
   :download:`clk_generator.v <clk_generator.v>`

.. |SevenSegmentControl.sv| replace::
   :download:`SevenSegmentControl.sv <SevenSegmentControl.sv>`

.. |VLineDrawer.sv| replace::
   :download:`VLineDrawer.sv <VLineDrawer.sv>`

.. |pong.xdc| replace::
   :download:`pong.xdc <pong.xdc>`

.. |new_constraints.txt| replace::
   :download:`new_constraints.txt <new_constraints.txt>`

.. |tmr_script.py| replace::
   :download:`tmr_script.py <tmr_script.py>`

.. |common.mk| replace::
   :download:`common.mk <common.mk>`

.. |Makefile| replace::
   :download:`Makefile <Makefile>`
