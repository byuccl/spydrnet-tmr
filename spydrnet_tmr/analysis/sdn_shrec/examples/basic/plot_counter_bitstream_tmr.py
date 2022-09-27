"""
Two-Bit Counter Bitstream TMR
=============================
Triplicates different circuit elements and inserts voters into simple two-bit 
counter design

In this example, a simple design with a two-bit counter with a one-shot detector for a Digilent BASYS3 board is used. The example is included in the `spydernet_shrec/support_files/EDIF_netlists` folder. 

Below is are the SystemVerilog modules used to create the design, as well as an .xdc constraints file.

.. code-block:: sv

    module two_bit_counter_top(
        input wire logic btnC, btnU, clk,
        output logic [1:0] led
    );
    
        logic btnU_one_shot;
        
        one_shot one_shot(.btn_press(btnU), .btn_output(btnU_one_shot), .clk(clk));
        
        two_bit_counter two_bit_conter(
            .reset(btnC), .clk(clk), .increment(btnU_one_shot), .count(led)
        );
    
    endmodule

.. code-block:: sv

    module one_shot(
        input wire logic btn_press, clk,
        output logic btn_output
    );
    
        logic btn_f1, btn_f2;
        
        always_ff @(posedge clk) begin
            btn_f1 <= btn_press;
            btn_f2 <= btn_f1;
        end
        
        assign btn_output = btn_f1 && !btn_f2;
    
    endmodule

.. code-block:: sv


    module two_bit_counter(
        input wire logic reset, increment, clk,
        output logic [1:0] count
    );
        
        
        always_ff @(posedge clk) begin
            if(reset)
                count <= 0;
            else if(increment)
                count <= count + 1;
        end
        
    endmodule

.. code-block::

    # Clock signal
    set_property PACKAGE_PIN W5 [get_ports clk]
        set_property IOSTANDARD LVCMOS33 [get_ports clk]
        create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

    # LEDs
    set_property PACKAGE_PIN U16 [get_ports {led[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
    set_property PACKAGE_PIN E19 [get_ports {led[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

    # Buttons
    set_property PACKAGE_PIN U18 [get_ports btnC]
        set_property IOSTANDARD LVCMOS33 [get_ports btnC]
    set_property PACKAGE_PIN T18 [get_ports btnU]
        set_property IOSTANDARD LVCMOS33 [get_ports btnU]

    set_property CONFIG_VOLTAGE 3.3 [current_design]
    set_property CFGBVS VCCO [current_design]

SpyDrNet SHREC allows for some flexibility when it comes to replicating instances and ports, and this is shown here in this example. Only the two LED ports ('led[1:0]') will be replicated from all of the top ports, which means the total LEDs used in the final netlist will be 6 (2 LEDs x 3 = 6 LEDs). All instances inside the netlist will be replicated.

The SpyDrNet SHREC TMR flow generally follows this set of steps:
1. Parse in a netlist with SpyDrNet. This can be done either by loading in your own netlist with `spydrnet.parse(<filename>)` or a pre-existing netlist with `spydrnet.load_example_netlist_by_name(<name>)` (SpyDrNet-SHREC has its own examples that can be loaded similarly with `spydrnet_shrec.load_example_netlist_by_name(<name>)`)
2. Set which instances to replicate. This example replicates all instances.
3. Set which ports to replicate. This example selects all hierarchical ports (ports between hierarchical modules), and only the LED port from the top-level ports.
4. Find insertion points for reduction and feedback voters.
5. Replicate the previously selected instances and ports.
6. Insert voters at the previously selected insertion points. 

Here is the constraints file for the design after triplication. The only difference is the constraints for all six of the new two-bit counter outputs. 

.. code-block::

    # Clock signal
    set_property PACKAGE_PIN W5 [get_ports clk]
        set_property IOSTANDARD LVCMOS33 [get_ports clk]
        create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

    # LEDs
    set_property PACKAGE_PIN U16 [get_ports {led_TMR_0[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led_TMR_0[0]}]
    set_property PACKAGE_PIN E19 [get_ports {led_TMR_0[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led_TMR_0[1]}]
    set_property PACKAGE_PIN U19 [get_ports {led_TMR_1[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led_TMR_1[0]}]
    set_property PACKAGE_PIN V19 [get_ports {led_TMR_1[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led_TMR_1[1]}]
    set_property PACKAGE_PIN W18 [get_ports {led_TMR_2[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led_TMR_2[0]}]
    set_property PACKAGE_PIN U15 [get_ports {led_TMR_2[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {led_TMR_2[1]}]

    # Buttons
    set_property PACKAGE_PIN U18 [get_ports btnC]
        set_property IOSTANDARD LVCMOS33 [get_ports btnC]
    set_property PACKAGE_PIN T18 [get_ports btnU]
        set_property IOSTANDARD LVCMOS33 [get_ports btnU]

    set_property CONFIG_VOLTAGE 3.3 [current_design]
    set_property CFGBVS VCCO [current_design]

This script will also build a bitstream if desired. To build it, simple set the `build_bitstream_flag` boolean to 'True' at the top of the script. A TCL script for Vivado's batch mode will be created that will load in the TMR netlist and build a bitstream for the correct part for the FPGA on the BASYS3 board. If Vivado is installed correctly, the script will then execute the commands in the auto-generated TCL script, and if successful, will output a bitstream (.bit) file ready to be downloaded to a board.

"""
import pathlib
from spydrnet.uniquify import uniquify
from spydrnet_tmr.transformation.replication.organ import XilinxTMRVoter
from spydrnet_tmr.support_files.xilinx_primitive_tokens import FF_CELLS
from spydrnet_tmr.support_files.vendor_names import XILINX
from spydrnet_tmr.utils.load_primitive_info import load_primitive_info
from spydrnet_tmr import apply_nmr, insert_organs
import spydrnet_shrec
from spydrnet_shrec.analysis.find_voter_insertion_points import (
    find_voter_insertion_points,
)

# Set this flag to 'True' to build the bitstream, and 'False' to skip it
build_bitstream_flag = False


def run():

    netlist_name = "two_bit_counter_top"
    netlist = spydrnet_shrec.load_example_netlist_by_name(netlist_name)

    uniquify(netlist)

    # set instances_to_replicate [get_cells -hierarchical -filter {PRIMITIVE_LEVEL==LEAF||PRIMITIVE_LEVEL==MACRO}]
    hinstances_to_replicate = list(
        netlist.get_hinstances(
            recursive=True, filter=lambda x: x.item.reference.is_leaf() is True
        )
    )
    instances_to_replicate = list(x.item for x in hinstances_to_replicate)

    # set ports_to_replicate [get_ports]
    hports_to_replicate = list(netlist.get_hports())
    ports_to_replicate = list(
        x.item for x in hports_to_replicate if x.name == str("led[1:0]")
    )

    primitive_info = load_primitive_info(netlist, XILINX)

    # find out where to insert reduction and feedback voters
    insertion_points = find_voter_insertion_points(
        netlist,
        [*hinstances_to_replicate, *hports_to_replicate],
        [cell.name for cell in primitive_info[FF_CELLS]],
    )

    # replicate instances and ports
    replicas = apply_nmr(
        [*instances_to_replicate, *ports_to_replicate],
        3,
        name_suffix="TMR",
        rename_original=True,
    )

    # insert voters on the selected drivers
    insert_organs(replicas, insertion_points, XilinxTMRVoter(), "VOTER")

    netlist_tmr_name = netlist_name + "_tmr"

    netlist.compose(netlist_tmr_name + ".edf")

    if build_bitstream_flag is True:

        repo_path = pathlib.Path(__file__).absolute().parent.resolve()
        # part for basys3 board
        part = "xc7a35tcpg236-1"

        build_bitstream_from_netlist(repo_path, netlist_tmr_name, part)


def build_bitstream_from_netlist(extract_path, netlist_name, part):
    import subprocess

    # build_set = ["datapath", ["xdc"], [ "constants", "alu", "regfile", "datapath" ] ]

    bitfile_filename = str(netlist_name + ".bit")

    print("Attempting to build bitfile ", bitfile_filename)

    tcl_build_script_filename = create_tcl_build_script(
        extract_path, netlist_name, part
    )

    # Generate bitfile
    build_cmd = [
        "vivado",
        "-nolog",
        "-mode",
        "batch",
        "-nojournal",
        "-source",
        tcl_build_script_filename,
    ]
    proc = subprocess.run(build_cmd, cwd=extract_path, check=False)
    if proc.returncode:
        return False

    # See if the bitfile exists (make sure it is newer)
    bitstream_file = extract_path / bitfile_filename
    if not bitstream_file.exists():
        print("Bistream file ", bitstream_file, " not created")
    else:
        print("Bitstream file ", bitstream_file, " exists")

    return True


def create_tcl_build_script(extract_path, netlist_name, part):
    tcl_build_script_filename = str(netlist_name + "_buildscript.tcl")
    tmp_tcl = extract_path / tcl_build_script_filename

    log = open(tmp_tcl, "w")
    log.write("# Bitfile Generation script\n")
    log.write("#\n")

    log.write("# Add netlist source\n")
    log.write("read_edif " + netlist_name + ".edf" + "\n")

    log.write("# Add XDC file\n")
    log.write("read_xdc " + netlist_name + ".xdc" + "\n")

    log.write("# Set source and part\n")
    log.write("link_design -name " + netlist_name + " -part " + part + "\n")

    log.write("# Implement Design\n")
    log.write("place_design\n")
    log.write("route_design\n")
    log.write("write_bitstream -force " + netlist_name + ".bit" + "\n")

    log.write("# End of build script\n")
    log.close()

    return tcl_build_script_filename


run()
