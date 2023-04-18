## Clock (uncomment both lines)
 set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { clk }];
 create_clock -period 10.00 [get_ports { clk }];

## Buttons
 set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { btnc }];
 set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { btnu }];
 set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { btnl }];
 set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { btnr }];
 set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { btnd }];

## Seven-Segment Display
 set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { segment[0] }];
 set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { segment[1] }];
 set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { segment[2] }];
 set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { segment[3] }];
 set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { segment[4] }];
 set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { segment[5] }];
 set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { segment[6] }];
 set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { segment[7] }];
 set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33 } [get_ports { anode[0] }];
 set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports { anode[1] }];
 set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { anode[2] }];
 set_property -dict { PACKAGE_PIN W4    IOSTANDARD LVCMOS33 } [get_ports { anode[3] }];

## VGA Connector
 set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[0] }];
 set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[1] }];
 set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[2] }];
 set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[3] }];

 set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[0] }];
 set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[1] }];
 set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[2] }];
 set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[3] }];

 set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[0] }];
 set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[1] }];
 set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[2] }];
 set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[3] }];

 set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { VGA_HS }];
 set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { VGA_VS }];

## Configuration options, use for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]