// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Wed Feb 22 08:45:37 2023
// Host        : CB461-EE11769 running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog /home/emonlux/pong/pong.v
// Design      : top_pong
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module BallDrawer
   (ADDRARDADDR,
    vga_y,
    \ballY_reg[5] ,
    \FSM_sequential_cs_reg[2] ,
    \FSM_onehot_cs_reg[9]_0 ,
    Q,
    ram_reg_0_0,
    ram_reg_0_0_0,
    ram_reg_0_0_1,
    ram_reg_0_0_2,
    ram_reg_0_0_3,
    in16,
    ram_reg_3_2,
    ram_reg_0_0_4,
    ram_reg_3_2_0,
    btnc_IBUF,
    clk_100);
  output [15:0]ADDRARDADDR;
  output [0:0]vga_y;
  output \ballY_reg[5] ;
  output \FSM_sequential_cs_reg[2] ;
  output \FSM_onehot_cs_reg[9]_0 ;
  input [8:0]Q;
  input ram_reg_0_0;
  input ram_reg_0_0_0;
  input [7:0]ram_reg_0_0_1;
  input [2:0]ram_reg_0_0_2;
  input [5:0]ram_reg_0_0_3;
  input [5:0]in16;
  input [7:0]ram_reg_3_2;
  input ram_reg_0_0_4;
  input ram_reg_3_2_0;
  input btnc_IBUF;
  input clk_100;

  wire \<const1> ;
  wire [15:0]ADDRARDADDR;
  wire \FSM_onehot_cs[0]_i_1_n_0 ;
  wire \FSM_onehot_cs[10]_i_1_n_0 ;
  wire \FSM_onehot_cs[1]_i_1_n_0 ;
  wire \FSM_onehot_cs_reg[9]_0 ;
  wire \FSM_onehot_cs_reg_n_0_[0] ;
  wire \FSM_onehot_cs_reg_n_0_[10] ;
  wire \FSM_onehot_cs_reg_n_0_[1] ;
  wire \FSM_onehot_cs_reg_n_0_[2] ;
  wire \FSM_onehot_cs_reg_n_0_[3] ;
  wire \FSM_onehot_cs_reg_n_0_[4] ;
  wire \FSM_onehot_cs_reg_n_0_[5] ;
  wire \FSM_onehot_cs_reg_n_0_[6] ;
  wire \FSM_onehot_cs_reg_n_0_[7] ;
  wire \FSM_onehot_cs_reg_n_0_[8] ;
  wire \FSM_onehot_cs_reg_n_0_[9] ;
  wire \FSM_sequential_cs_reg[2] ;
  wire [8:0]Q;
  wire \ballY_reg[5] ;
  wire btnc_IBUF;
  wire clk_100;
  wire [5:0]in16;
  wire ram_reg_0_0;
  wire ram_reg_0_0_0;
  wire [7:0]ram_reg_0_0_1;
  wire [2:0]ram_reg_0_0_2;
  wire [5:0]ram_reg_0_0_3;
  wire ram_reg_0_0_4;
  wire ram_reg_0_0_i_23_n_0;
  wire ram_reg_0_0_i_24_n_0;
  wire ram_reg_0_0_i_25_n_0;
  wire ram_reg_0_0_i_26_n_0;
  wire ram_reg_0_0_i_27_n_0;
  wire ram_reg_0_0_i_29_n_0;
  wire ram_reg_0_0_i_30_n_0;
  wire ram_reg_0_0_i_31_n_0;
  wire ram_reg_0_0_i_33_n_0;
  wire ram_reg_0_0_i_34_n_0;
  wire ram_reg_0_0_i_35_n_0;
  wire ram_reg_0_0_i_36_n_0;
  wire ram_reg_0_0_i_37_n_0;
  wire ram_reg_0_0_i_38_n_0;
  wire ram_reg_0_0_i_39_n_0;
  wire ram_reg_0_0_i_40_n_0;
  wire ram_reg_0_0_i_42_n_0;
  wire ram_reg_0_0_i_46_n_0;
  wire [7:0]ram_reg_3_2;
  wire ram_reg_3_2_0;
  wire [0:0]vga_y;

  LUT4 #(
    .INIT(16'hDDD0)) 
    \FSM_onehot_cs[0]_i_1 
       (.I0(ram_reg_0_0),
        .I1(\FSM_onehot_cs_reg_n_0_[9] ),
        .I2(\FSM_onehot_cs_reg_n_0_[10] ),
        .I3(\FSM_onehot_cs_reg_n_0_[0] ),
        .O(\FSM_onehot_cs[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hABAAAAAA)) 
    \FSM_onehot_cs[10]_i_1 
       (.I0(\FSM_onehot_cs_reg_n_0_[9] ),
        .I1(ram_reg_0_0_2[2]),
        .I2(ram_reg_0_0_2[0]),
        .I3(ram_reg_0_0_2[1]),
        .I4(\FSM_onehot_cs_reg_n_0_[10] ),
        .O(\FSM_onehot_cs[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000200)) 
    \FSM_onehot_cs[1]_i_1 
       (.I0(\FSM_onehot_cs_reg_n_0_[0] ),
        .I1(ram_reg_0_0_2[2]),
        .I2(ram_reg_0_0_2[0]),
        .I3(ram_reg_0_0_2[1]),
        .I4(\FSM_onehot_cs_reg_n_0_[9] ),
        .O(\FSM_onehot_cs[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_cs_reg[0] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[0]_i_1_n_0 ),
        .Q(\FSM_onehot_cs_reg_n_0_[0] ),
        .S(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[10] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[10]_i_1_n_0 ),
        .Q(\FSM_onehot_cs_reg_n_0_[10] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[1] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs[1]_i_1_n_0 ),
        .Q(\FSM_onehot_cs_reg_n_0_[1] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[2] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[1] ),
        .Q(\FSM_onehot_cs_reg_n_0_[2] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[3] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[2] ),
        .Q(\FSM_onehot_cs_reg_n_0_[3] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[4] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[3] ),
        .Q(\FSM_onehot_cs_reg_n_0_[4] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[5] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[4] ),
        .Q(\FSM_onehot_cs_reg_n_0_[5] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[6] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[5] ),
        .Q(\FSM_onehot_cs_reg_n_0_[6] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[7] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[6] ),
        .Q(\FSM_onehot_cs_reg_n_0_[7] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[8] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[7] ),
        .Q(\FSM_onehot_cs_reg_n_0_[8] ),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "P3:00000001000,P4:00000010000,P2:00000000100,Finished:10000000000,P1:00000000010,Idle:00000000001,P9:01000000000,P7:00010000000,P8:00100000000,P6:00001000000,P5:00000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_cs_reg[9] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\FSM_onehot_cs_reg_n_0_[8] ),
        .Q(\FSM_onehot_cs_reg_n_0_[9] ),
        .R(btnc_IBUF));
  LUT4 #(
    .INIT(16'h0DFF)) 
    \FSM_sequential_cs[0]_i_3 
       (.I0(\FSM_onehot_cs_reg_n_0_[9] ),
        .I1(btnc_IBUF),
        .I2(ram_reg_0_0_2[0]),
        .I3(ram_reg_0_0_2[1]),
        .O(\FSM_onehot_cs_reg[9]_0 ));
  VCC VCC
       (.P(\<const1> ));
  LUT5 #(
    .INIT(32'hFFFF6A00)) 
    ram_reg_0_0_i_10
       (.I0(Q[8]),
        .I1(Q[7]),
        .I2(ram_reg_0_0_i_31_n_0),
        .I3(ram_reg_0_0),
        .I4(ram_reg_0_0_0),
        .O(ADDRARDADDR[8]));
  LUT6 #(
    .INIT(64'h0000003C000000AA)) 
    ram_reg_0_0_i_11
       (.I0(ram_reg_0_0_1[7]),
        .I1(Q[7]),
        .I2(ram_reg_0_0_i_31_n_0),
        .I3(ram_reg_0_0_2[2]),
        .I4(ram_reg_0_0_2[0]),
        .I5(ram_reg_0_0_2[1]),
        .O(ADDRARDADDR[7]));
  LUT6 #(
    .INIT(64'h000000C3000000AA)) 
    ram_reg_0_0_i_12
       (.I0(ram_reg_0_0_1[6]),
        .I1(Q[6]),
        .I2(ram_reg_0_0_i_33_n_0),
        .I3(ram_reg_0_0_2[2]),
        .I4(ram_reg_0_0_2[0]),
        .I5(ram_reg_0_0_2[1]),
        .O(ADDRARDADDR[6]));
  LUT6 #(
    .INIT(64'h00000000FF0099F0)) 
    ram_reg_0_0_i_13
       (.I0(Q[5]),
        .I1(ram_reg_0_0_i_34_n_0),
        .I2(ram_reg_0_0_1[5]),
        .I3(ram_reg_0_0_2[1]),
        .I4(ram_reg_0_0_2[0]),
        .I5(ram_reg_0_0_2[2]),
        .O(ADDRARDADDR[5]));
  LUT6 #(
    .INIT(64'h00000000FF0099F0)) 
    ram_reg_0_0_i_14
       (.I0(Q[4]),
        .I1(ram_reg_0_0_i_35_n_0),
        .I2(ram_reg_0_0_1[4]),
        .I3(ram_reg_0_0_2[1]),
        .I4(ram_reg_0_0_2[0]),
        .I5(ram_reg_0_0_2[2]),
        .O(ADDRARDADDR[4]));
  LUT6 #(
    .INIT(64'h0000000000FF99F0)) 
    ram_reg_0_0_i_15
       (.I0(Q[3]),
        .I1(ram_reg_0_0_i_36_n_0),
        .I2(ram_reg_0_0_1[3]),
        .I3(ram_reg_0_0_2[1]),
        .I4(ram_reg_0_0_2[0]),
        .I5(ram_reg_0_0_2[2]),
        .O(ADDRARDADDR[3]));
  LUT6 #(
    .INIT(64'h00000000FF0099F0)) 
    ram_reg_0_0_i_16
       (.I0(Q[2]),
        .I1(ram_reg_0_0_i_37_n_0),
        .I2(ram_reg_0_0_1[2]),
        .I3(ram_reg_0_0_2[1]),
        .I4(ram_reg_0_0_2[0]),
        .I5(ram_reg_0_0_2[2]),
        .O(ADDRARDADDR[2]));
  LUT6 #(
    .INIT(64'h0000000000FF99F0)) 
    ram_reg_0_0_i_17
       (.I0(ram_reg_0_0_i_38_n_0),
        .I1(ram_reg_0_0_i_39_n_0),
        .I2(ram_reg_0_0_1[1]),
        .I3(ram_reg_0_0_2[1]),
        .I4(ram_reg_0_0_2[0]),
        .I5(ram_reg_0_0_2[2]),
        .O(ADDRARDADDR[1]));
  LUT6 #(
    .INIT(64'h0000F09F0000F090)) 
    ram_reg_0_0_i_18
       (.I0(Q[0]),
        .I1(ram_reg_0_0_i_40_n_0),
        .I2(ram_reg_0_0_2[1]),
        .I3(ram_reg_0_0_2[0]),
        .I4(ram_reg_0_0_2[2]),
        .I5(ram_reg_0_0_1[0]),
        .O(ADDRARDADDR[0]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    ram_reg_0_0_i_22
       (.I0(ram_reg_3_2[5]),
        .I1(ram_reg_3_2[4]),
        .I2(ram_reg_3_2[3]),
        .I3(ram_reg_3_2[2]),
        .I4(ram_reg_0_0_i_27_n_0),
        .O(\ballY_reg[5] ));
  LUT6 #(
    .INIT(64'h6555555555555555)) 
    ram_reg_0_0_i_23
       (.I0(ram_reg_3_2[6]),
        .I1(ram_reg_0_0_i_27_n_0),
        .I2(ram_reg_3_2[2]),
        .I3(ram_reg_3_2[3]),
        .I4(ram_reg_3_2[4]),
        .I5(ram_reg_3_2[5]),
        .O(ram_reg_0_0_i_23_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h55559555)) 
    ram_reg_0_0_i_24
       (.I0(ram_reg_3_2[5]),
        .I1(ram_reg_3_2[4]),
        .I2(ram_reg_3_2[3]),
        .I3(ram_reg_3_2[2]),
        .I4(ram_reg_0_0_i_27_n_0),
        .O(ram_reg_0_0_i_24_n_0));
  LUT4 #(
    .INIT(16'h6555)) 
    ram_reg_0_0_i_25
       (.I0(ram_reg_3_2[4]),
        .I1(ram_reg_0_0_i_27_n_0),
        .I2(ram_reg_3_2[2]),
        .I3(ram_reg_3_2[3]),
        .O(ram_reg_0_0_i_25_n_0));
  LUT5 #(
    .INIT(32'h9AFF9A00)) 
    ram_reg_0_0_i_26
       (.I0(ram_reg_3_2[3]),
        .I1(ram_reg_0_0_i_27_n_0),
        .I2(ram_reg_3_2[2]),
        .I3(ram_reg_0_0_2[1]),
        .I4(ram_reg_0_0_3[2]),
        .O(ram_reg_0_0_i_26_n_0));
  LUT6 #(
    .INIT(64'h0000AAABAAABFFFF)) 
    ram_reg_0_0_i_27
       (.I0(btnc_IBUF),
        .I1(\FSM_onehot_cs_reg_n_0_[8] ),
        .I2(\FSM_onehot_cs_reg_n_0_[9] ),
        .I3(\FSM_onehot_cs_reg_n_0_[7] ),
        .I4(ram_reg_3_2[1]),
        .I5(ram_reg_0_0_i_42_n_0),
        .O(ram_reg_0_0_i_27_n_0));
  LUT6 #(
    .INIT(64'h9999999A66666665)) 
    ram_reg_0_0_i_29
       (.I0(ram_reg_0_0_i_42_n_0),
        .I1(btnc_IBUF),
        .I2(\FSM_onehot_cs_reg_n_0_[8] ),
        .I3(\FSM_onehot_cs_reg_n_0_[9] ),
        .I4(\FSM_onehot_cs_reg_n_0_[7] ),
        .I5(ram_reg_3_2[1]),
        .O(ram_reg_0_0_i_29_n_0));
  LUT6 #(
    .INIT(64'h0000FF5C0000005C)) 
    ram_reg_0_0_i_3
       (.I0(ram_reg_0_0_i_23_n_0),
        .I1(ram_reg_0_0_3[5]),
        .I2(ram_reg_0_0_2[1]),
        .I3(ram_reg_0_0_2[0]),
        .I4(ram_reg_0_0_2[2]),
        .I5(in16[5]),
        .O(ADDRARDADDR[15]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h5555AAA9)) 
    ram_reg_0_0_i_30
       (.I0(ram_reg_3_2[0]),
        .I1(\FSM_onehot_cs_reg_n_0_[6] ),
        .I2(\FSM_onehot_cs_reg_n_0_[4] ),
        .I3(\FSM_onehot_cs_reg_n_0_[5] ),
        .I4(btnc_IBUF),
        .O(ram_reg_0_0_i_30_n_0));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    ram_reg_0_0_i_31
       (.I0(Q[6]),
        .I1(Q[5]),
        .I2(Q[3]),
        .I3(ram_reg_0_0_i_37_n_0),
        .I4(Q[2]),
        .I5(Q[4]),
        .O(ram_reg_0_0_i_31_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hF7FFFFFF)) 
    ram_reg_0_0_i_33
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(ram_reg_0_0_i_37_n_0),
        .I3(Q[3]),
        .I4(Q[5]),
        .O(ram_reg_0_0_i_33_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hDFFF)) 
    ram_reg_0_0_i_34
       (.I0(Q[3]),
        .I1(ram_reg_0_0_i_37_n_0),
        .I2(Q[2]),
        .I3(Q[4]),
        .O(ram_reg_0_0_i_34_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    ram_reg_0_0_i_35
       (.I0(Q[2]),
        .I1(ram_reg_0_0_i_37_n_0),
        .I2(Q[3]),
        .O(ram_reg_0_0_i_35_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'hB)) 
    ram_reg_0_0_i_36
       (.I0(ram_reg_0_0_i_37_n_0),
        .I1(Q[2]),
        .O(ram_reg_0_0_i_36_n_0));
  LUT6 #(
    .INIT(64'h0000AAABAAABFFFF)) 
    ram_reg_0_0_i_37
       (.I0(btnc_IBUF),
        .I1(\FSM_onehot_cs_reg_n_0_[9] ),
        .I2(\FSM_onehot_cs_reg_n_0_[6] ),
        .I3(\FSM_onehot_cs_reg_n_0_[3] ),
        .I4(Q[1]),
        .I5(ram_reg_0_0_i_38_n_0),
        .O(ram_reg_0_0_i_37_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    ram_reg_0_0_i_38
       (.I0(Q[0]),
        .I1(\FSM_onehot_cs_reg_n_0_[8] ),
        .I2(\FSM_onehot_cs_reg_n_0_[5] ),
        .I3(\FSM_onehot_cs_reg_n_0_[2] ),
        .I4(btnc_IBUF),
        .O(ram_reg_0_0_i_38_n_0));
  LUT5 #(
    .INIT(32'h5555AAA9)) 
    ram_reg_0_0_i_39
       (.I0(Q[1]),
        .I1(\FSM_onehot_cs_reg_n_0_[3] ),
        .I2(\FSM_onehot_cs_reg_n_0_[6] ),
        .I3(\FSM_onehot_cs_reg_n_0_[9] ),
        .I4(btnc_IBUF),
        .O(ram_reg_0_0_i_39_n_0));
  LUT6 #(
    .INIT(64'h0000FF5C0000005C)) 
    ram_reg_0_0_i_4
       (.I0(ram_reg_0_0_i_24_n_0),
        .I1(ram_reg_0_0_3[4]),
        .I2(ram_reg_0_0_2[1]),
        .I3(ram_reg_0_0_2[0]),
        .I4(ram_reg_0_0_2[2]),
        .I5(in16[4]),
        .O(ADDRARDADDR[14]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hAAAB)) 
    ram_reg_0_0_i_40
       (.I0(btnc_IBUF),
        .I1(\FSM_onehot_cs_reg_n_0_[2] ),
        .I2(\FSM_onehot_cs_reg_n_0_[5] ),
        .I3(\FSM_onehot_cs_reg_n_0_[8] ),
        .O(ram_reg_0_0_i_40_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    ram_reg_0_0_i_42
       (.I0(ram_reg_3_2[0]),
        .I1(\FSM_onehot_cs_reg_n_0_[6] ),
        .I2(\FSM_onehot_cs_reg_n_0_[4] ),
        .I3(\FSM_onehot_cs_reg_n_0_[5] ),
        .I4(btnc_IBUF),
        .O(ram_reg_0_0_i_42_n_0));
  LUT6 #(
    .INIT(64'h1111111111111110)) 
    ram_reg_0_0_i_45
       (.I0(ram_reg_0_0_2[2]),
        .I1(ram_reg_0_0_2[0]),
        .I2(ram_reg_0_0_i_46_n_0),
        .I3(\FSM_onehot_cs_reg_n_0_[7] ),
        .I4(\FSM_onehot_cs_reg_n_0_[9] ),
        .I5(\FSM_onehot_cs_reg_n_0_[8] ),
        .O(\FSM_sequential_cs_reg[2] ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    ram_reg_0_0_i_46
       (.I0(\FSM_onehot_cs_reg_n_0_[2] ),
        .I1(\FSM_onehot_cs_reg_n_0_[1] ),
        .I2(\FSM_onehot_cs_reg_n_0_[3] ),
        .I3(\FSM_onehot_cs_reg_n_0_[5] ),
        .I4(\FSM_onehot_cs_reg_n_0_[4] ),
        .I5(\FSM_onehot_cs_reg_n_0_[6] ),
        .O(ram_reg_0_0_i_46_n_0));
  LUT6 #(
    .INIT(64'h0000FF5C0000005C)) 
    ram_reg_0_0_i_5
       (.I0(ram_reg_0_0_i_25_n_0),
        .I1(ram_reg_0_0_3[3]),
        .I2(ram_reg_0_0_2[1]),
        .I3(ram_reg_0_0_2[0]),
        .I4(ram_reg_0_0_2[2]),
        .I5(in16[3]),
        .O(ADDRARDADDR[13]));
  LUT4 #(
    .INIT(16'h00E2)) 
    ram_reg_0_0_i_6
       (.I0(ram_reg_0_0_i_26_n_0),
        .I1(ram_reg_0_0_2[0]),
        .I2(in16[2]),
        .I3(ram_reg_0_0_2[2]),
        .O(ADDRARDADDR[12]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00090000)) 
    ram_reg_0_0_i_7
       (.I0(ram_reg_3_2[2]),
        .I1(ram_reg_0_0_i_27_n_0),
        .I2(ram_reg_0_0_2[2]),
        .I3(ram_reg_0_0_2[0]),
        .I4(ram_reg_0_0_2[1]),
        .I5(ram_reg_0_0_4),
        .O(ADDRARDADDR[11]));
  LUT6 #(
    .INIT(64'h0000FF5C0000005C)) 
    ram_reg_0_0_i_8
       (.I0(ram_reg_0_0_i_29_n_0),
        .I1(ram_reg_0_0_3[1]),
        .I2(ram_reg_0_0_2[1]),
        .I3(ram_reg_0_0_2[0]),
        .I4(ram_reg_0_0_2[2]),
        .I5(in16[1]),
        .O(ADDRARDADDR[10]));
  LUT6 #(
    .INIT(64'h00F700F400070004)) 
    ram_reg_0_0_i_9
       (.I0(ram_reg_0_0_i_30_n_0),
        .I1(ram_reg_0_0_2[1]),
        .I2(ram_reg_0_0_2[0]),
        .I3(ram_reg_0_0_2[2]),
        .I4(ram_reg_0_0_3[0]),
        .I5(in16[0]),
        .O(ADDRARDADDR[9]));
  LUT5 #(
    .INIT(32'hFFFF6A00)) 
    ram_reg_2_0_i_1
       (.I0(ram_reg_3_2[7]),
        .I1(ram_reg_3_2[6]),
        .I2(\ballY_reg[5] ),
        .I3(ram_reg_0_0),
        .I4(ram_reg_3_2_0),
        .O(vga_y));
endmodule

module BitmapToVga
   (VGA_HS_OBUF,
    VGA_VS_OBUF,
    VGA_B_OBUF,
    VGA_G_OBUF,
    VGA_R_OBUF,
    clk_25,
    clk_100,
    ram_reg_0_0,
    ADDRARDADDR,
    vga_color,
    WEA,
    vga_y,
    ram_reg_2_0,
    btnc_IBUF);
  output VGA_HS_OBUF;
  output VGA_VS_OBUF;
  output [0:0]VGA_B_OBUF;
  output [0:0]VGA_G_OBUF;
  output [0:0]VGA_R_OBUF;
  input clk_25;
  input clk_100;
  input ram_reg_0_0;
  input [15:0]ADDRARDADDR;
  input [2:0]vga_color;
  input [0:0]WEA;
  input [0:0]vga_y;
  input [0:0]ram_reg_2_0;
  input btnc_IBUF;

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]ADDRARDADDR;
  wire [0:0]VGA_B_OBUF;
  wire [0:0]VGA_G_OBUF;
  wire VGA_HS_OBUF;
  wire [0:0]VGA_R_OBUF;
  wire \VGA_R_OBUF[3]_inst_i_2_n_0 ;
  wire \VGA_R_OBUF[3]_inst_i_3_n_0 ;
  wire VGA_VS_OBUF;
  wire VGA_hsync_i_1_n_0;
  wire VGA_hsync_i_2_n_0;
  wire VGA_vsync_i_1_n_0;
  wire VGA_vsync_i_2_n_0;
  wire [0:0]WEA;
  wire btnc_IBUF;
  wire clk_100;
  wire clk_25;
  wire \hcount[9]_i_1_n_0 ;
  wire \hcount[9]_i_3_n_0 ;
  wire hcount_clear;
  wire [9:1]hcount_reg;
  wire [0:0]hcount_reg__0;
  wire [9:0]p_0_in;
  wire [9:0]p_0_in__0;
  wire ram_reg_0_0;
  wire [0:0]ram_reg_2_0;
  wire \vcount[9]_i_1_n_0 ;
  wire \vcount[9]_i_4_n_0 ;
  wire \vcount[9]_i_5_n_0 ;
  wire \vcount[9]_i_6_n_0 ;
  wire [8:1]vcount_reg;
  wire [9:0]vcount_reg__0;
  wire [2:0]vga_color;
  wire [0:0]vga_y;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT5 #(
    .INIT(32'hFFFFEEEA)) 
    \VGA_R_OBUF[3]_inst_i_2 
       (.I0(\VGA_R_OBUF[3]_inst_i_3_n_0 ),
        .I1(hcount_reg[9]),
        .I2(hcount_reg[8]),
        .I3(hcount_reg[7]),
        .I4(vcount_reg__0[9]),
        .O(\VGA_R_OBUF[3]_inst_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \VGA_R_OBUF[3]_inst_i_3 
       (.I0(vcount_reg[6]),
        .I1(vcount_reg[5]),
        .I2(vcount_reg[8]),
        .I3(vcount_reg[7]),
        .O(\VGA_R_OBUF[3]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF8F1FFFFFFFFF)) 
    VGA_hsync_i_1
       (.I0(hcount_reg[5]),
        .I1(hcount_reg[6]),
        .I2(hcount_reg[7]),
        .I3(VGA_hsync_i_2_n_0),
        .I4(hcount_reg[8]),
        .I5(hcount_reg[9]),
        .O(VGA_hsync_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hAAAAA888)) 
    VGA_hsync_i_2
       (.I0(hcount_reg[4]),
        .I1(hcount_reg[2]),
        .I2(hcount_reg[1]),
        .I3(hcount_reg__0),
        .I4(hcount_reg[3]),
        .O(VGA_hsync_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    VGA_hsync_reg
       (.C(clk_25),
        .CE(\<const1> ),
        .D(VGA_hsync_i_1_n_0),
        .Q(VGA_HS_OBUF),
        .R(\<const0> ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8000)) 
    VGA_vsync_i_1
       (.I0(vcount_reg[3]),
        .I1(vcount_reg__0[0]),
        .I2(vcount_reg[1]),
        .I3(vcount_reg[2]),
        .I4(vcount_reg[4]),
        .I5(VGA_vsync_i_2_n_0),
        .O(VGA_vsync_i_1_n_0));
  LUT6 #(
    .INIT(64'hBFBFBFFFFFFFFFFF)) 
    VGA_vsync_i_2
       (.I0(vcount_reg__0[9]),
        .I1(vcount_reg[3]),
        .I2(vcount_reg[2]),
        .I3(vcount_reg__0[0]),
        .I4(vcount_reg[1]),
        .I5(\VGA_R_OBUF[3]_inst_i_3_n_0 ),
        .O(VGA_vsync_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    VGA_vsync_reg
       (.C(clk_25),
        .CE(\<const1> ),
        .D(VGA_vsync_i_1_n_0),
        .Q(VGA_VS_OBUF),
        .R(\<const0> ));
  VgaRam VgaRam_inst
       (.ADDRARDADDR(ADDRARDADDR),
        .Q(vcount_reg),
        .\VGA_B[0] (\VGA_R_OBUF[3]_inst_i_2_n_0 ),
        .VGA_B_OBUF(VGA_B_OBUF),
        .VGA_G_OBUF(VGA_G_OBUF),
        .VGA_R_OBUF(VGA_R_OBUF),
        .WEA(WEA),
        .clk_100(clk_100),
        .clk_25(clk_25),
        .ram_reg_0_0_0(ram_reg_0_0),
        .ram_reg_2_0_0(ram_reg_2_0),
        .ram_reg_3_2_0(hcount_reg),
        .vga_color(vga_color),
        .vga_y(vga_y));
  LUT1 #(
    .INIT(2'h1)) 
    \hcount[0]_i_1 
       (.I0(hcount_reg__0),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \hcount[1]_i_1 
       (.I0(hcount_reg__0),
        .I1(hcount_reg[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \hcount[2]_i_1 
       (.I0(hcount_reg[2]),
        .I1(hcount_reg[1]),
        .I2(hcount_reg__0),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \hcount[3]_i_1 
       (.I0(hcount_reg[3]),
        .I1(hcount_reg__0),
        .I2(hcount_reg[1]),
        .I3(hcount_reg[2]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \hcount[4]_i_1 
       (.I0(hcount_reg[4]),
        .I1(hcount_reg[3]),
        .I2(hcount_reg[2]),
        .I3(hcount_reg[1]),
        .I4(hcount_reg__0),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \hcount[5]_i_1 
       (.I0(hcount_reg[5]),
        .I1(hcount_reg__0),
        .I2(hcount_reg[1]),
        .I3(hcount_reg[2]),
        .I4(hcount_reg[3]),
        .I5(hcount_reg[4]),
        .O(p_0_in[5]));
  LUT3 #(
    .INIT(8'h6A)) 
    \hcount[6]_i_1 
       (.I0(hcount_reg[6]),
        .I1(\hcount[9]_i_3_n_0 ),
        .I2(hcount_reg[5]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \hcount[7]_i_1 
       (.I0(hcount_reg[7]),
        .I1(hcount_reg[5]),
        .I2(hcount_reg[6]),
        .I3(\hcount[9]_i_3_n_0 ),
        .O(p_0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \hcount[8]_i_1 
       (.I0(hcount_reg[8]),
        .I1(hcount_reg[7]),
        .I2(hcount_reg[6]),
        .I3(hcount_reg[5]),
        .I4(\hcount[9]_i_3_n_0 ),
        .O(p_0_in[8]));
  LUT2 #(
    .INIT(4'hE)) 
    \hcount[9]_i_1 
       (.I0(btnc_IBUF),
        .I1(hcount_clear),
        .O(\hcount[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \hcount[9]_i_2 
       (.I0(hcount_reg[9]),
        .I1(\hcount[9]_i_3_n_0 ),
        .I2(hcount_reg[5]),
        .I3(hcount_reg[6]),
        .I4(hcount_reg[7]),
        .I5(hcount_reg[8]),
        .O(p_0_in[9]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \hcount[9]_i_3 
       (.I0(hcount_reg[4]),
        .I1(hcount_reg[3]),
        .I2(hcount_reg[2]),
        .I3(hcount_reg[1]),
        .I4(hcount_reg__0),
        .O(\hcount[9]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[0] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[0]),
        .Q(hcount_reg__0),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[1] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[1]),
        .Q(hcount_reg[1]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[2] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[2]),
        .Q(hcount_reg[2]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[3] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[3]),
        .Q(hcount_reg[3]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[4] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[4]),
        .Q(hcount_reg[4]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[5] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[5]),
        .Q(hcount_reg[5]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[6] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[6]),
        .Q(hcount_reg[6]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[7] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[7]),
        .Q(hcount_reg[7]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[8] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[8]),
        .Q(hcount_reg[8]),
        .R(\hcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hcount_reg[9] 
       (.C(clk_25),
        .CE(\<const1> ),
        .D(p_0_in[9]),
        .Q(hcount_reg[9]),
        .R(\hcount[9]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \vcount[0]_i_1 
       (.I0(vcount_reg__0[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \vcount[1]_i_1 
       (.I0(vcount_reg__0[0]),
        .I1(vcount_reg[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \vcount[2]_i_1 
       (.I0(vcount_reg[2]),
        .I1(vcount_reg[1]),
        .I2(vcount_reg__0[0]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \vcount[3]_i_1 
       (.I0(vcount_reg[3]),
        .I1(vcount_reg__0[0]),
        .I2(vcount_reg[1]),
        .I3(vcount_reg[2]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \vcount[4]_i_1 
       (.I0(vcount_reg[4]),
        .I1(vcount_reg[2]),
        .I2(vcount_reg[1]),
        .I3(vcount_reg__0[0]),
        .I4(vcount_reg[3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \vcount[5]_i_1 
       (.I0(vcount_reg[5]),
        .I1(vcount_reg[3]),
        .I2(vcount_reg__0[0]),
        .I3(vcount_reg[1]),
        .I4(vcount_reg[2]),
        .I5(vcount_reg[4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \vcount[6]_i_1 
       (.I0(vcount_reg[6]),
        .I1(\vcount[9]_i_5_n_0 ),
        .I2(vcount_reg[5]),
        .O(p_0_in__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \vcount[7]_i_1 
       (.I0(vcount_reg[7]),
        .I1(\vcount[9]_i_5_n_0 ),
        .I2(vcount_reg[5]),
        .I3(vcount_reg[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \vcount[8]_i_1 
       (.I0(vcount_reg[8]),
        .I1(vcount_reg[6]),
        .I2(vcount_reg[5]),
        .I3(\vcount[9]_i_5_n_0 ),
        .I4(vcount_reg[7]),
        .O(p_0_in__0[8]));
  LUT3 #(
    .INIT(8'hBA)) 
    \vcount[9]_i_1 
       (.I0(btnc_IBUF),
        .I1(\vcount[9]_i_4_n_0 ),
        .I2(hcount_clear),
        .O(\vcount[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000800)) 
    \vcount[9]_i_2 
       (.I0(\hcount[9]_i_3_n_0 ),
        .I1(hcount_reg[9]),
        .I2(hcount_reg[7]),
        .I3(hcount_reg[8]),
        .I4(hcount_reg[5]),
        .I5(hcount_reg[6]),
        .O(hcount_clear));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \vcount[9]_i_3 
       (.I0(vcount_reg__0[9]),
        .I1(vcount_reg[6]),
        .I2(vcount_reg[5]),
        .I3(vcount_reg[8]),
        .I4(vcount_reg[7]),
        .I5(\vcount[9]_i_5_n_0 ),
        .O(p_0_in__0[9]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \vcount[9]_i_4 
       (.I0(vcount_reg__0[0]),
        .I1(vcount_reg[5]),
        .I2(vcount_reg[1]),
        .I3(vcount_reg[6]),
        .I4(\vcount[9]_i_6_n_0 ),
        .O(\vcount[9]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \vcount[9]_i_5 
       (.I0(vcount_reg[4]),
        .I1(vcount_reg[2]),
        .I2(vcount_reg[1]),
        .I3(vcount_reg__0[0]),
        .I4(vcount_reg[3]),
        .O(\vcount[9]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF7FF)) 
    \vcount[9]_i_6 
       (.I0(vcount_reg[3]),
        .I1(vcount_reg[2]),
        .I2(vcount_reg[8]),
        .I3(vcount_reg__0[9]),
        .I4(vcount_reg[4]),
        .I5(vcount_reg[7]),
        .O(\vcount[9]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[0] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[0]),
        .Q(vcount_reg__0[0]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[1] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[1]),
        .Q(vcount_reg[1]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[2] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[2]),
        .Q(vcount_reg[2]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[3] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[3]),
        .Q(vcount_reg[3]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[4] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[4]),
        .Q(vcount_reg[4]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[5] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[5]),
        .Q(vcount_reg[5]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[6] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[6]),
        .Q(vcount_reg[6]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[7] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[7]),
        .Q(vcount_reg[7]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[8] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[8]),
        .Q(vcount_reg[8]),
        .R(\vcount[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \vcount_reg[9] 
       (.C(clk_25),
        .CE(hcount_clear),
        .D(p_0_in__0[9]),
        .Q(vcount_reg__0[9]),
        .R(\vcount[9]_i_1_n_0 ));
endmodule

module Pong
   (\ballY_reg[6]_0 ,
    \ballY_reg[6]_1 ,
    vga_color,
    ADDRARDADDR,
    vga_y,
    segment_OBUF,
    WEA,
    clk_100,
    btnc_IBUF,
    btnd_IBUF,
    btnr_IBUF,
    btnl_IBUF,
    btnu_IBUF,
    anode_select);
  output \ballY_reg[6]_0 ;
  output [0:0]\ballY_reg[6]_1 ;
  output [2:0]vga_color;
  output [15:0]ADDRARDADDR;
  output [0:0]vga_y;
  output [6:0]segment_OBUF;
  output [0:0]WEA;
  input clk_100;
  input btnc_IBUF;
  input btnd_IBUF;
  input btnr_IBUF;
  input btnl_IBUF;
  input btnu_IBUF;
  input [1:0]anode_select;

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]ADDRARDADDR;
  wire BallDrawer_inst_n_17;
  wire BallDrawer_inst_n_18;
  wire BallDrawer_inst_n_19;
  wire \FSM_onehot_cs[0]_i_2_n_0 ;
  wire \FSM_sequential_cs[0]_i_2_n_0 ;
  wire \FSM_sequential_cs[0]_i_4_n_0 ;
  wire \FSM_sequential_cs[2]_i_10_n_0 ;
  wire \FSM_sequential_cs[2]_i_3_n_0 ;
  wire \FSM_sequential_cs[2]_i_4_n_0 ;
  wire \FSM_sequential_cs[2]_i_5_n_0 ;
  wire \FSM_sequential_cs[2]_i_6_n_0 ;
  wire \FSM_sequential_cs[2]_i_7_n_0 ;
  wire \FSM_sequential_cs[2]_i_8_n_0 ;
  wire \FSM_sequential_cs[2]_i_9_n_0 ;
  wire [7:0]LPaddleY;
  wire \LPaddleY[3]_i_1_n_0 ;
  wire \LPaddleY[3]_i_2_n_0 ;
  wire \LPaddleY[4]_i_1_n_0 ;
  wire \LPaddleY[4]_i_2_n_0 ;
  wire \LPaddleY[4]_i_3_n_0 ;
  wire \LPaddleY[5]_i_2_n_0 ;
  wire \LPaddleY[5]_i_3_n_0 ;
  wire \LPaddleY[5]_i_4_n_0 ;
  wire \LPaddleY[5]_i_5_n_0 ;
  wire \LPaddleY[6]_i_2_n_0 ;
  wire \LPaddleY[6]_i_3_n_0 ;
  wire \LPaddleY[6]_i_4_n_0 ;
  wire \LPaddleY[7]_i_1_n_0 ;
  wire \LPaddleY[7]_i_3_n_0 ;
  wire \LPaddleY[7]_i_4_n_0 ;
  wire [7:0]P1score;
  wire P1score1;
  wire \P1score[7]_i_1_n_0 ;
  wire \P1score[7]_i_4_n_0 ;
  wire \P1score[7]_i_5_n_0 ;
  wire [7:0]P2score;
  wire \P2score[7]_i_3_n_0 ;
  wire \P2score[7]_i_4_n_0 ;
  wire [7:0]RPaddleY;
  wire \RPaddleY[0]_i_1_n_0 ;
  wire \RPaddleY[1]_i_1_n_0 ;
  wire \RPaddleY[2]_i_1_n_0 ;
  wire \RPaddleY[3]_i_1_n_0 ;
  wire \RPaddleY[3]_i_2_n_0 ;
  wire \RPaddleY[4]_i_1_n_0 ;
  wire \RPaddleY[4]_i_2_n_0 ;
  wire \RPaddleY[4]_i_3_n_0 ;
  wire \RPaddleY[5]_i_1_n_0 ;
  wire \RPaddleY[5]_i_2_n_0 ;
  wire \RPaddleY[5]_i_3_n_0 ;
  wire \RPaddleY[5]_i_4_n_0 ;
  wire \RPaddleY[5]_i_5_n_0 ;
  wire \RPaddleY[6]_i_1_n_0 ;
  wire \RPaddleY[6]_i_2_n_0 ;
  wire \RPaddleY[6]_i_3_n_0 ;
  wire \RPaddleY[6]_i_4_n_0 ;
  wire \RPaddleY[7]_i_1_n_0 ;
  wire \RPaddleY[7]_i_2_n_0 ;
  wire \RPaddleY[7]_i_3_n_0 ;
  wire \RPaddleY[7]_i_4_n_0 ;
  wire VLineDrawer_inst_n_10;
  wire VLineDrawer_inst_n_13;
  wire VLineDrawer_inst_n_14;
  wire VLineDrawer_inst_n_7;
  wire [0:0]WEA;
  wire \_inferred__4/i__carry__0_n_0 ;
  wire \_inferred__4/i__carry__0_n_1 ;
  wire \_inferred__4/i__carry__0_n_2 ;
  wire \_inferred__4/i__carry__0_n_3 ;
  wire \_inferred__4/i__carry__1_n_3 ;
  wire \_inferred__4/i__carry_n_0 ;
  wire \_inferred__4/i__carry_n_1 ;
  wire \_inferred__4/i__carry_n_2 ;
  wire \_inferred__4/i__carry_n_3 ;
  wire \_inferred__5/i__carry__0_n_0 ;
  wire \_inferred__5/i__carry__0_n_1 ;
  wire \_inferred__5/i__carry__0_n_2 ;
  wire \_inferred__5/i__carry__0_n_3 ;
  wire \_inferred__5/i__carry__1_n_3 ;
  wire \_inferred__5/i__carry_n_0 ;
  wire \_inferred__5/i__carry_n_1 ;
  wire \_inferred__5/i__carry_n_2 ;
  wire \_inferred__5/i__carry_n_3 ;
  wire [1:0]anode_select;
  wire ballMovingDown_i_1_n_0;
  wire ballMovingDown_i_2_n_0;
  wire ballMovingDown_i_3_n_0;
  wire ballMovingDown_i_4_n_0;
  wire ballMovingDown_i_5_n_0;
  wire ballMovingRight;
  wire ballMovingRight0;
  wire ballMovingRight28_in;
  wire ballMovingRight2_carry__0_i_1_n_0;
  wire ballMovingRight2_carry__0_i_2_n_0;
  wire ballMovingRight2_carry_i_10_n_0;
  wire ballMovingRight2_carry_i_11_n_0;
  wire ballMovingRight2_carry_i_1_n_0;
  wire ballMovingRight2_carry_i_2_n_0;
  wire ballMovingRight2_carry_i_3_n_0;
  wire ballMovingRight2_carry_i_4_n_0;
  wire ballMovingRight2_carry_i_5_n_0;
  wire ballMovingRight2_carry_i_6_n_0;
  wire ballMovingRight2_carry_i_7_n_0;
  wire ballMovingRight2_carry_i_8_n_0;
  wire ballMovingRight2_carry_i_9_n_0;
  wire ballMovingRight2_carry_n_0;
  wire ballMovingRight2_carry_n_1;
  wire ballMovingRight2_carry_n_2;
  wire ballMovingRight2_carry_n_3;
  wire ballMovingRight3;
  wire \ballMovingRight3_inferred__0/i__carry_n_0 ;
  wire \ballMovingRight3_inferred__0/i__carry_n_1 ;
  wire \ballMovingRight3_inferred__0/i__carry_n_2 ;
  wire \ballMovingRight3_inferred__0/i__carry_n_3 ;
  wire ballMovingRight_i_1_n_0;
  wire ballMovingRight_i_2_n_0;
  wire ballMovingRight_i_3_n_0;
  wire ballMovingRight_i_5_n_0;
  wire ballMovingRight_reg_n_0;
  wire \ballX[0]_i_1_n_0 ;
  wire \ballX[4]_i_2_n_0 ;
  wire \ballX[4]_i_3_n_0 ;
  wire \ballX[4]_i_4_n_0 ;
  wire \ballX[4]_i_5_n_0 ;
  wire \ballX[8]_i_1_n_0 ;
  wire \ballX[8]_i_3_n_0 ;
  wire \ballX[8]_i_4_n_0 ;
  wire \ballX[8]_i_5_n_0 ;
  wire \ballX[8]_i_6_n_0 ;
  wire [8:0]ballX_reg;
  wire \ballX_reg[4]_i_1_n_0 ;
  wire \ballX_reg[4]_i_1_n_1 ;
  wire \ballX_reg[4]_i_1_n_2 ;
  wire \ballX_reg[4]_i_1_n_3 ;
  wire \ballX_reg[4]_i_1_n_4 ;
  wire \ballX_reg[4]_i_1_n_5 ;
  wire \ballX_reg[4]_i_1_n_6 ;
  wire \ballX_reg[4]_i_1_n_7 ;
  wire \ballX_reg[8]_i_2_n_1 ;
  wire \ballX_reg[8]_i_2_n_2 ;
  wire \ballX_reg[8]_i_2_n_3 ;
  wire \ballX_reg[8]_i_2_n_4 ;
  wire \ballX_reg[8]_i_2_n_5 ;
  wire \ballX_reg[8]_i_2_n_6 ;
  wire \ballX_reg[8]_i_2_n_7 ;
  wire \ballY[0]_i_1_n_0 ;
  wire \ballY[4]_i_2_n_0 ;
  wire \ballY[4]_i_3_n_0 ;
  wire \ballY[4]_i_4_n_0 ;
  wire \ballY[4]_i_5_n_0 ;
  wire \ballY[4]_i_6_n_0 ;
  wire \ballY[7]_i_2_n_0 ;
  wire \ballY[7]_i_3_n_0 ;
  wire \ballY[7]_i_4_n_0 ;
  wire [7:0]ballY_reg;
  wire \ballY_reg[4]_i_1_n_0 ;
  wire \ballY_reg[4]_i_1_n_1 ;
  wire \ballY_reg[4]_i_1_n_2 ;
  wire \ballY_reg[4]_i_1_n_3 ;
  wire \ballY_reg[4]_i_1_n_4 ;
  wire \ballY_reg[4]_i_1_n_5 ;
  wire \ballY_reg[4]_i_1_n_6 ;
  wire \ballY_reg[4]_i_1_n_7 ;
  wire \ballY_reg[6]_0 ;
  wire [0:0]\ballY_reg[6]_1 ;
  wire \ballY_reg[7]_i_1_n_2 ;
  wire \ballY_reg[7]_i_1_n_3 ;
  wire \ballY_reg[7]_i_1_n_5 ;
  wire \ballY_reg[7]_i_1_n_6 ;
  wire \ballY_reg[7]_i_1_n_7 ;
  wire btnc_IBUF;
  wire btnd_IBUF;
  wire btnl_IBUF;
  wire btnr_IBUF;
  wire btnu_IBUF;
  wire clearX;
  wire \clearX[0]_i_1_n_0 ;
  wire \clearX[1]_i_1_n_0 ;
  wire \clearX[2]_i_1_n_0 ;
  wire \clearX[3]_i_1_n_0 ;
  wire \clearX[4]_i_1_n_0 ;
  wire \clearX[5]_i_1_n_0 ;
  wire \clearX[6]_i_1_n_0 ;
  wire \clearX[7]_i_1_n_0 ;
  wire \clearX[8]_i_2_n_0 ;
  wire \clearX[8]_i_3_n_0 ;
  wire \clearX_reg_n_0_[0] ;
  wire \clearX_reg_n_0_[1] ;
  wire \clearX_reg_n_0_[2] ;
  wire \clearX_reg_n_0_[3] ;
  wire \clearX_reg_n_0_[4] ;
  wire \clearX_reg_n_0_[5] ;
  wire \clearX_reg_n_0_[6] ;
  wire \clearX_reg_n_0_[7] ;
  wire \clearX_reg_n_0_[8] ;
  wire clearY;
  wire \clearY[7]_i_3_n_0 ;
  wire \clearY[7]_i_4_n_0 ;
  wire [7:0]clearY_reg;
  wire clk_100;
  wire [2:0]cs;
  wire erasing;
  wire i__carry__0_i_1__0_n_0;
  wire i__carry__0_i_1__1_n_0;
  wire i__carry__0_i_2__0_n_0;
  wire i__carry__0_i_2__1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3__0_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4__0_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_5__0_n_0;
  wire i__carry__0_i_5_n_0;
  wire i__carry__0_i_6__0_n_0;
  wire i__carry__0_i_6_n_0;
  wire i__carry__0_i_7__0_n_0;
  wire i__carry__0_i_7_n_0;
  wire i__carry__0_i_8__0_n_0;
  wire i__carry__0_i_8_n_0;
  wire i__carry__1_i_1__0_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry_i_1__0_n_0;
  wire i__carry_i_1__1_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2__0_n_0;
  wire i__carry_i_2__1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3__0_n_0;
  wire i__carry_i_3__1_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4__0_n_0;
  wire i__carry_i_4__1_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_6_n_0;
  wire i__carry_i_7_n_0;
  wire i__carry_i_8_n_0;
  wire in;
  wire [6:0]in16;
  wire [2:0]ns;
  wire [8:8]p_0_in;
  wire [7:0]p_0_in__1;
  wire [7:0]p_0_in__2;
  wire [7:0]p_0_in__3;
  wire [7:0]p_1_in;
  wire ram_reg_0_0_i_32_n_0;
  wire ram_reg_0_0_i_44_n_0;
  wire [6:0]segment_OBUF;
  wire \segment_OBUF[6]_inst_i_2_n_0 ;
  wire \segment_OBUF[6]_inst_i_3_n_0 ;
  wire \segment_OBUF[6]_inst_i_4_n_0 ;
  wire \segment_OBUF[6]_inst_i_5_n_0 ;
  wire \timerCount[0]_i_3_n_0 ;
  wire [31:0]timerCount_reg;
  wire \timerCount_reg[0]_i_2_n_0 ;
  wire \timerCount_reg[0]_i_2_n_1 ;
  wire \timerCount_reg[0]_i_2_n_2 ;
  wire \timerCount_reg[0]_i_2_n_3 ;
  wire \timerCount_reg[0]_i_2_n_4 ;
  wire \timerCount_reg[0]_i_2_n_5 ;
  wire \timerCount_reg[0]_i_2_n_6 ;
  wire \timerCount_reg[0]_i_2_n_7 ;
  wire \timerCount_reg[12]_i_1_n_0 ;
  wire \timerCount_reg[12]_i_1_n_1 ;
  wire \timerCount_reg[12]_i_1_n_2 ;
  wire \timerCount_reg[12]_i_1_n_3 ;
  wire \timerCount_reg[12]_i_1_n_4 ;
  wire \timerCount_reg[12]_i_1_n_5 ;
  wire \timerCount_reg[12]_i_1_n_6 ;
  wire \timerCount_reg[12]_i_1_n_7 ;
  wire \timerCount_reg[16]_i_1_n_0 ;
  wire \timerCount_reg[16]_i_1_n_1 ;
  wire \timerCount_reg[16]_i_1_n_2 ;
  wire \timerCount_reg[16]_i_1_n_3 ;
  wire \timerCount_reg[16]_i_1_n_4 ;
  wire \timerCount_reg[16]_i_1_n_5 ;
  wire \timerCount_reg[16]_i_1_n_6 ;
  wire \timerCount_reg[16]_i_1_n_7 ;
  wire \timerCount_reg[20]_i_1_n_0 ;
  wire \timerCount_reg[20]_i_1_n_1 ;
  wire \timerCount_reg[20]_i_1_n_2 ;
  wire \timerCount_reg[20]_i_1_n_3 ;
  wire \timerCount_reg[20]_i_1_n_4 ;
  wire \timerCount_reg[20]_i_1_n_5 ;
  wire \timerCount_reg[20]_i_1_n_6 ;
  wire \timerCount_reg[20]_i_1_n_7 ;
  wire \timerCount_reg[24]_i_1_n_0 ;
  wire \timerCount_reg[24]_i_1_n_1 ;
  wire \timerCount_reg[24]_i_1_n_2 ;
  wire \timerCount_reg[24]_i_1_n_3 ;
  wire \timerCount_reg[24]_i_1_n_4 ;
  wire \timerCount_reg[24]_i_1_n_5 ;
  wire \timerCount_reg[24]_i_1_n_6 ;
  wire \timerCount_reg[24]_i_1_n_7 ;
  wire \timerCount_reg[28]_i_1_n_1 ;
  wire \timerCount_reg[28]_i_1_n_2 ;
  wire \timerCount_reg[28]_i_1_n_3 ;
  wire \timerCount_reg[28]_i_1_n_4 ;
  wire \timerCount_reg[28]_i_1_n_5 ;
  wire \timerCount_reg[28]_i_1_n_6 ;
  wire \timerCount_reg[28]_i_1_n_7 ;
  wire \timerCount_reg[4]_i_1_n_0 ;
  wire \timerCount_reg[4]_i_1_n_1 ;
  wire \timerCount_reg[4]_i_1_n_2 ;
  wire \timerCount_reg[4]_i_1_n_3 ;
  wire \timerCount_reg[4]_i_1_n_4 ;
  wire \timerCount_reg[4]_i_1_n_5 ;
  wire \timerCount_reg[4]_i_1_n_6 ;
  wire \timerCount_reg[4]_i_1_n_7 ;
  wire \timerCount_reg[8]_i_1_n_0 ;
  wire \timerCount_reg[8]_i_1_n_1 ;
  wire \timerCount_reg[8]_i_1_n_2 ;
  wire \timerCount_reg[8]_i_1_n_3 ;
  wire \timerCount_reg[8]_i_1_n_4 ;
  wire \timerCount_reg[8]_i_1_n_5 ;
  wire \timerCount_reg[8]_i_1_n_6 ;
  wire \timerCount_reg[8]_i_1_n_7 ;
  wire timerRst;
  wire [2:0]vga_color;
  wire [0:0]vga_y;

  BallDrawer BallDrawer_inst
       (.ADDRARDADDR(ADDRARDADDR),
        .\FSM_onehot_cs_reg[9]_0 (BallDrawer_inst_n_19),
        .\FSM_sequential_cs_reg[2] (BallDrawer_inst_n_18),
        .Q(ballX_reg),
        .\ballY_reg[5] (BallDrawer_inst_n_17),
        .btnc_IBUF(btnc_IBUF),
        .clk_100(clk_100),
        .in16({in16[6:3],in16[1:0]}),
        .ram_reg_0_0(\FSM_onehot_cs[0]_i_2_n_0 ),
        .ram_reg_0_0_0(ram_reg_0_0_i_32_n_0),
        .ram_reg_0_0_1({\clearX_reg_n_0_[7] ,\clearX_reg_n_0_[6] ,\clearX_reg_n_0_[5] ,\clearX_reg_n_0_[4] ,\clearX_reg_n_0_[3] ,\clearX_reg_n_0_[2] ,\clearX_reg_n_0_[1] ,\clearX_reg_n_0_[0] }),
        .ram_reg_0_0_2(cs),
        .ram_reg_0_0_3({clearY_reg[6:3],clearY_reg[1:0]}),
        .ram_reg_0_0_4(VLineDrawer_inst_n_13),
        .ram_reg_3_2(ballY_reg),
        .ram_reg_3_2_0(VLineDrawer_inst_n_7),
        .vga_y(vga_y));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \FSM_onehot_cs[0]_i_2 
       (.I0(cs[2]),
        .I1(cs[0]),
        .I2(cs[1]),
        .O(\FSM_onehot_cs[0]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h54)) 
    \FSM_sequential_cs[0]_i_2 
       (.I0(cs[0]),
        .I1(\FSM_sequential_cs[0]_i_4_n_0 ),
        .I2(\clearY[7]_i_3_n_0 ),
        .O(\FSM_sequential_cs[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    \FSM_sequential_cs[0]_i_4 
       (.I0(\clearY[7]_i_4_n_0 ),
        .I1(clearY_reg[4]),
        .I2(clearY_reg[7]),
        .I3(clearY_reg[5]),
        .I4(clearY_reg[6]),
        .O(\FSM_sequential_cs[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \FSM_sequential_cs[2]_i_10 
       (.I0(timerCount_reg[14]),
        .I1(timerCount_reg[0]),
        .I2(timerCount_reg[19]),
        .I3(timerCount_reg[5]),
        .O(\FSM_sequential_cs[2]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_cs[2]_i_3 
       (.I0(\FSM_sequential_cs[2]_i_5_n_0 ),
        .I1(timerCount_reg[31]),
        .I2(timerCount_reg[30]),
        .I3(timerCount_reg[11]),
        .I4(timerCount_reg[22]),
        .I5(\FSM_sequential_cs[2]_i_6_n_0 ),
        .O(\FSM_sequential_cs[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFBF)) 
    \FSM_sequential_cs[2]_i_4 
       (.I0(\FSM_sequential_cs[2]_i_7_n_0 ),
        .I1(timerCount_reg[6]),
        .I2(timerCount_reg[16]),
        .I3(timerCount_reg[12]),
        .I4(timerCount_reg[21]),
        .I5(\FSM_sequential_cs[2]_i_8_n_0 ),
        .O(\FSM_sequential_cs[2]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_cs[2]_i_5 
       (.I0(timerCount_reg[29]),
        .I1(timerCount_reg[2]),
        .I2(timerCount_reg[13]),
        .I3(timerCount_reg[20]),
        .O(\FSM_sequential_cs[2]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \FSM_sequential_cs[2]_i_6 
       (.I0(timerCount_reg[1]),
        .I1(timerCount_reg[28]),
        .I2(timerCount_reg[24]),
        .I3(timerCount_reg[17]),
        .I4(\FSM_sequential_cs[2]_i_9_n_0 ),
        .O(\FSM_sequential_cs[2]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \FSM_sequential_cs[2]_i_7 
       (.I0(timerCount_reg[18]),
        .I1(timerCount_reg[10]),
        .I2(timerCount_reg[9]),
        .I3(timerCount_reg[15]),
        .O(\FSM_sequential_cs[2]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_cs[2]_i_8 
       (.I0(timerCount_reg[7]),
        .I1(timerCount_reg[25]),
        .I2(timerCount_reg[4]),
        .I3(timerCount_reg[27]),
        .I4(\FSM_sequential_cs[2]_i_10_n_0 ),
        .O(\FSM_sequential_cs[2]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_cs[2]_i_9 
       (.I0(timerCount_reg[26]),
        .I1(timerCount_reg[3]),
        .I2(timerCount_reg[23]),
        .I3(timerCount_reg[8]),
        .O(\FSM_sequential_cs[2]_i_9_n_0 ));
  (* FSM_ENCODED_STATES = "INIT:000,BALL:010,MOVE:100,PADDLE_R:011,WAIT_TIMER:101,PADDLE_L:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_cs_reg[0] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(ns[0]),
        .Q(cs[0]),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "INIT:000,BALL:010,MOVE:100,PADDLE_R:011,WAIT_TIMER:101,PADDLE_L:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_cs_reg[1] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(VLineDrawer_inst_n_10),
        .Q(cs[1]),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "INIT:000,BALL:010,MOVE:100,PADDLE_R:011,WAIT_TIMER:101,PADDLE_L:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_cs_reg[2] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(ns[2]),
        .Q(cs[2]),
        .R(btnc_IBUF));
  GND GND
       (.G(\<const0> ));
  LUT5 #(
    .INIT(32'h0400040C)) 
    \LPaddleY[0]_i_1 
       (.I0(\LPaddleY[6]_i_2_n_0 ),
        .I1(LPaddleY[0]),
        .I2(clearX),
        .I3(btnu_IBUF),
        .I4(\LPaddleY[5]_i_2_n_0 ),
        .O(p_1_in[0]));
  LUT5 #(
    .INIT(32'h00001013)) 
    \LPaddleY[1]_i_1 
       (.I0(\LPaddleY[6]_i_2_n_0 ),
        .I1(clearX),
        .I2(btnu_IBUF),
        .I3(\LPaddleY[5]_i_2_n_0 ),
        .I4(LPaddleY[1]),
        .O(p_1_in[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFF40044334)) 
    \LPaddleY[2]_i_1 
       (.I0(\LPaddleY[6]_i_2_n_0 ),
        .I1(btnu_IBUF),
        .I2(LPaddleY[1]),
        .I3(LPaddleY[2]),
        .I4(\LPaddleY[5]_i_2_n_0 ),
        .I5(clearX),
        .O(p_1_in[2]));
  LUT2 #(
    .INIT(4'h2)) 
    \LPaddleY[3]_i_1 
       (.I0(cs[2]),
        .I1(\LPaddleY[3]_i_2_n_0 ),
        .O(\LPaddleY[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF1E0000FF1E8787)) 
    \LPaddleY[3]_i_2 
       (.I0(LPaddleY[1]),
        .I1(LPaddleY[2]),
        .I2(LPaddleY[3]),
        .I3(\LPaddleY[6]_i_2_n_0 ),
        .I4(btnu_IBUF),
        .I5(\LPaddleY[5]_i_2_n_0 ),
        .O(\LPaddleY[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000001455550014)) 
    \LPaddleY[4]_i_1 
       (.I0(clearX),
        .I1(LPaddleY[4]),
        .I2(\LPaddleY[4]_i_2_n_0 ),
        .I3(\LPaddleY[5]_i_2_n_0 ),
        .I4(btnu_IBUF),
        .I5(\LPaddleY[4]_i_3_n_0 ),
        .O(\LPaddleY[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \LPaddleY[4]_i_2 
       (.I0(LPaddleY[2]),
        .I1(LPaddleY[1]),
        .I2(LPaddleY[3]),
        .O(\LPaddleY[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FF00FFFF01FF)) 
    \LPaddleY[4]_i_3 
       (.I0(LPaddleY[7]),
        .I1(LPaddleY[6]),
        .I2(LPaddleY[5]),
        .I3(\LPaddleY[6]_i_4_n_0 ),
        .I4(LPaddleY[3]),
        .I5(LPaddleY[4]),
        .O(\LPaddleY[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFABBAAAAAABBA)) 
    \LPaddleY[5]_i_1 
       (.I0(clearX),
        .I1(\LPaddleY[5]_i_2_n_0 ),
        .I2(LPaddleY[5]),
        .I3(\LPaddleY[5]_i_3_n_0 ),
        .I4(btnu_IBUF),
        .I5(\LPaddleY[5]_i_4_n_0 ),
        .O(p_1_in[5]));
  LUT6 #(
    .INIT(64'h8808080808080808)) 
    \LPaddleY[5]_i_2 
       (.I0(LPaddleY[6]),
        .I1(LPaddleY[7]),
        .I2(\LPaddleY[5]_i_5_n_0 ),
        .I3(LPaddleY[0]),
        .I4(LPaddleY[1]),
        .I5(LPaddleY[2]),
        .O(\LPaddleY[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \LPaddleY[5]_i_3 
       (.I0(LPaddleY[3]),
        .I1(LPaddleY[1]),
        .I2(LPaddleY[2]),
        .I3(LPaddleY[4]),
        .O(\LPaddleY[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000FF5500A8)) 
    \LPaddleY[5]_i_4 
       (.I0(\LPaddleY[6]_i_4_n_0 ),
        .I1(LPaddleY[7]),
        .I2(LPaddleY[6]),
        .I3(LPaddleY[3]),
        .I4(LPaddleY[5]),
        .I5(LPaddleY[4]),
        .O(\LPaddleY[5]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \LPaddleY[5]_i_5 
       (.I0(LPaddleY[3]),
        .I1(LPaddleY[5]),
        .I2(LPaddleY[4]),
        .O(\LPaddleY[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hF1F0F1FFF2FFF2F0)) 
    \LPaddleY[6]_i_1 
       (.I0(\LPaddleY[7]_i_3_n_0 ),
        .I1(\LPaddleY[6]_i_2_n_0 ),
        .I2(\LPaddleY[6]_i_3_n_0 ),
        .I3(btnu_IBUF),
        .I4(\LPaddleY[7]_i_4_n_0 ),
        .I5(LPaddleY[6]),
        .O(p_1_in[6]));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \LPaddleY[6]_i_2 
       (.I0(LPaddleY[4]),
        .I1(LPaddleY[5]),
        .I2(LPaddleY[3]),
        .I3(LPaddleY[6]),
        .I4(LPaddleY[7]),
        .I5(\LPaddleY[6]_i_4_n_0 ),
        .O(\LPaddleY[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h01FF0101)) 
    \LPaddleY[6]_i_3 
       (.I0(cs[1]),
        .I1(cs[0]),
        .I2(cs[2]),
        .I3(btnu_IBUF),
        .I4(\LPaddleY[5]_i_2_n_0 ),
        .O(\LPaddleY[6]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \LPaddleY[6]_i_4 
       (.I0(LPaddleY[1]),
        .I1(LPaddleY[2]),
        .O(\LPaddleY[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h000E000F)) 
    \LPaddleY[7]_i_1 
       (.I0(btnl_IBUF),
        .I1(btnu_IBUF),
        .I2(cs[1]),
        .I3(cs[0]),
        .I4(cs[2]),
        .O(\LPaddleY[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F570F070)) 
    \LPaddleY[7]_i_2 
       (.I0(btnu_IBUF),
        .I1(\LPaddleY[7]_i_3_n_0 ),
        .I2(LPaddleY[7]),
        .I3(LPaddleY[6]),
        .I4(\LPaddleY[7]_i_4_n_0 ),
        .I5(clearX),
        .O(p_1_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \LPaddleY[7]_i_3 
       (.I0(LPaddleY[2]),
        .I1(LPaddleY[1]),
        .I2(LPaddleY[4]),
        .I3(LPaddleY[5]),
        .I4(LPaddleY[3]),
        .O(\LPaddleY[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \LPaddleY[7]_i_4 
       (.I0(LPaddleY[4]),
        .I1(LPaddleY[2]),
        .I2(LPaddleY[1]),
        .I3(LPaddleY[3]),
        .I4(LPaddleY[5]),
        .O(\LPaddleY[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[0] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(LPaddleY[0]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[1] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(LPaddleY[1]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[2] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(p_1_in[2]),
        .Q(LPaddleY[2]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[3] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(\LPaddleY[3]_i_1_n_0 ),
        .Q(LPaddleY[3]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[4] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(\LPaddleY[4]_i_1_n_0 ),
        .Q(LPaddleY[4]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[5] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(p_1_in[5]),
        .Q(LPaddleY[5]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[6] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(p_1_in[6]),
        .Q(LPaddleY[6]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \LPaddleY_reg[7] 
       (.C(clk_100),
        .CE(\LPaddleY[7]_i_1_n_0 ),
        .D(p_1_in[7]),
        .Q(LPaddleY[7]),
        .R(\<const0> ));
  LUT1 #(
    .INIT(2'h1)) 
    \P1score[0]_i_1 
       (.I0(P1score[0]),
        .O(p_0_in__2[0]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \P1score[1]_i_1 
       (.I0(P1score[0]),
        .I1(P1score[1]),
        .O(p_0_in__2[1]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \P1score[2]_i_1 
       (.I0(P1score[2]),
        .I1(P1score[1]),
        .I2(P1score[0]),
        .O(p_0_in__2[2]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \P1score[3]_i_1 
       (.I0(P1score[3]),
        .I1(P1score[0]),
        .I2(P1score[1]),
        .I3(P1score[2]),
        .O(p_0_in__2[3]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \P1score[4]_i_1 
       (.I0(P1score[4]),
        .I1(P1score[2]),
        .I2(P1score[1]),
        .I3(P1score[0]),
        .I4(P1score[3]),
        .O(p_0_in__2[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \P1score[5]_i_1 
       (.I0(P1score[5]),
        .I1(P1score[3]),
        .I2(P1score[0]),
        .I3(P1score[1]),
        .I4(P1score[2]),
        .I5(P1score[4]),
        .O(p_0_in__2[5]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \P1score[6]_i_1 
       (.I0(P1score[6]),
        .I1(\P1score[7]_i_4_n_0 ),
        .O(p_0_in__2[6]));
  LUT4 #(
    .INIT(16'h0400)) 
    \P1score[7]_i_1 
       (.I0(cs[1]),
        .I1(cs[2]),
        .I2(cs[0]),
        .I3(ballMovingRight),
        .O(\P1score[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \P1score[7]_i_2 
       (.I0(P1score[7]),
        .I1(\P1score[7]_i_4_n_0 ),
        .I2(P1score[6]),
        .O(p_0_in__2[7]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h20000000)) 
    \P1score[7]_i_3 
       (.I0(\P1score[7]_i_5_n_0 ),
        .I1(ballX_reg[1]),
        .I2(ballX_reg[2]),
        .I3(ballX_reg[3]),
        .I4(ballX_reg[0]),
        .O(ballMovingRight));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \P1score[7]_i_4 
       (.I0(P1score[5]),
        .I1(P1score[3]),
        .I2(P1score[0]),
        .I3(P1score[1]),
        .I4(P1score[2]),
        .I5(P1score[4]),
        .O(\P1score[7]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h10000000)) 
    \P1score[7]_i_5 
       (.I0(ballX_reg[7]),
        .I1(ballX_reg[6]),
        .I2(ballX_reg[5]),
        .I3(ballX_reg[8]),
        .I4(ballX_reg[4]),
        .O(\P1score[7]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[0] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[0]),
        .Q(P1score[0]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[1] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[1]),
        .Q(P1score[1]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[2] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[2]),
        .Q(P1score[2]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[3] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[3]),
        .Q(P1score[3]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[4] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[4]),
        .Q(P1score[4]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[5] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[5]),
        .Q(P1score[5]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[6] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[6]),
        .Q(P1score[6]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P1score_reg[7] 
       (.C(clk_100),
        .CE(\P1score[7]_i_1_n_0 ),
        .D(p_0_in__2[7]),
        .Q(P1score[7]),
        .R(clearX));
  LUT1 #(
    .INIT(2'h1)) 
    \P2score[0]_i_1 
       (.I0(P2score[0]),
        .O(p_0_in__3[0]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \P2score[1]_i_1 
       (.I0(P2score[0]),
        .I1(P2score[1]),
        .O(p_0_in__3[1]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \P2score[2]_i_1 
       (.I0(P2score[2]),
        .I1(P2score[1]),
        .I2(P2score[0]),
        .O(p_0_in__3[2]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \P2score[3]_i_1 
       (.I0(P2score[3]),
        .I1(P2score[0]),
        .I2(P2score[1]),
        .I3(P2score[2]),
        .O(p_0_in__3[3]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \P2score[4]_i_1 
       (.I0(P2score[4]),
        .I1(P2score[2]),
        .I2(P2score[1]),
        .I3(P2score[0]),
        .I4(P2score[3]),
        .O(p_0_in__3[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \P2score[5]_i_1 
       (.I0(P2score[5]),
        .I1(P2score[3]),
        .I2(P2score[0]),
        .I3(P2score[1]),
        .I4(P2score[2]),
        .I5(P2score[4]),
        .O(p_0_in__3[5]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \P2score[6]_i_1 
       (.I0(P2score[6]),
        .I1(\P2score[7]_i_4_n_0 ),
        .O(p_0_in__3[6]));
  LUT5 #(
    .INIT(32'h00020000)) 
    \P2score[7]_i_1 
       (.I0(\ballX[8]_i_1_n_0 ),
        .I1(ballX_reg[3]),
        .I2(ballX_reg[1]),
        .I3(ballX_reg[0]),
        .I4(\P2score[7]_i_3_n_0 ),
        .O(P1score1));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \P2score[7]_i_2 
       (.I0(P2score[7]),
        .I1(\P2score[7]_i_4_n_0 ),
        .I2(P2score[6]),
        .O(p_0_in__3[7]));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \P2score[7]_i_3 
       (.I0(ballX_reg[2]),
        .I1(ballX_reg[8]),
        .I2(ballX_reg[4]),
        .I3(ballX_reg[5]),
        .I4(ballX_reg[6]),
        .I5(ballX_reg[7]),
        .O(\P2score[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \P2score[7]_i_4 
       (.I0(P2score[5]),
        .I1(P2score[3]),
        .I2(P2score[0]),
        .I3(P2score[1]),
        .I4(P2score[2]),
        .I5(P2score[4]),
        .O(\P2score[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[0] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[0]),
        .Q(P2score[0]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[1] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[1]),
        .Q(P2score[1]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[2] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[2]),
        .Q(P2score[2]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[3] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[3]),
        .Q(P2score[3]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[4] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[4]),
        .Q(P2score[4]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[5] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[5]),
        .Q(P2score[5]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[6] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[6]),
        .Q(P2score[6]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \P2score_reg[7] 
       (.C(clk_100),
        .CE(P1score1),
        .D(p_0_in__3[7]),
        .Q(P2score[7]),
        .R(clearX));
  LUT5 #(
    .INIT(32'h0400040C)) 
    \RPaddleY[0]_i_1 
       (.I0(\RPaddleY[6]_i_2_n_0 ),
        .I1(RPaddleY[0]),
        .I2(clearX),
        .I3(btnr_IBUF),
        .I4(\RPaddleY[5]_i_3_n_0 ),
        .O(\RPaddleY[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00001013)) 
    \RPaddleY[1]_i_1 
       (.I0(\RPaddleY[6]_i_2_n_0 ),
        .I1(clearX),
        .I2(btnr_IBUF),
        .I3(\RPaddleY[5]_i_3_n_0 ),
        .I4(RPaddleY[1]),
        .O(\RPaddleY[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF40044334)) 
    \RPaddleY[2]_i_1 
       (.I0(\RPaddleY[6]_i_2_n_0 ),
        .I1(btnr_IBUF),
        .I2(RPaddleY[1]),
        .I3(RPaddleY[2]),
        .I4(\RPaddleY[5]_i_3_n_0 ),
        .I5(clearX),
        .O(\RPaddleY[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \RPaddleY[3]_i_1 
       (.I0(cs[2]),
        .I1(\RPaddleY[3]_i_2_n_0 ),
        .O(\RPaddleY[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888CCCC8B88CCFFB)) 
    \RPaddleY[3]_i_2 
       (.I0(\RPaddleY[6]_i_2_n_0 ),
        .I1(btnr_IBUF),
        .I2(RPaddleY[1]),
        .I3(RPaddleY[2]),
        .I4(RPaddleY[3]),
        .I5(\RPaddleY[5]_i_3_n_0 ),
        .O(\RPaddleY[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000001455550014)) 
    \RPaddleY[4]_i_1 
       (.I0(clearX),
        .I1(RPaddleY[4]),
        .I2(\RPaddleY[4]_i_2_n_0 ),
        .I3(\RPaddleY[5]_i_3_n_0 ),
        .I4(btnr_IBUF),
        .I5(\RPaddleY[4]_i_3_n_0 ),
        .O(\RPaddleY[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \RPaddleY[4]_i_2 
       (.I0(RPaddleY[2]),
        .I1(RPaddleY[1]),
        .I2(RPaddleY[3]),
        .O(\RPaddleY[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FF00FFFF01FF)) 
    \RPaddleY[4]_i_3 
       (.I0(RPaddleY[7]),
        .I1(RPaddleY[6]),
        .I2(RPaddleY[5]),
        .I3(\RPaddleY[6]_i_4_n_0 ),
        .I4(RPaddleY[3]),
        .I5(RPaddleY[4]),
        .O(\RPaddleY[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAABEAAAAAABE)) 
    \RPaddleY[5]_i_1 
       (.I0(clearX),
        .I1(RPaddleY[5]),
        .I2(\RPaddleY[5]_i_2_n_0 ),
        .I3(\RPaddleY[5]_i_3_n_0 ),
        .I4(btnr_IBUF),
        .I5(\RPaddleY[5]_i_4_n_0 ),
        .O(\RPaddleY[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \RPaddleY[5]_i_2 
       (.I0(RPaddleY[3]),
        .I1(RPaddleY[1]),
        .I2(RPaddleY[2]),
        .I3(RPaddleY[4]),
        .O(\RPaddleY[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8808080808080808)) 
    \RPaddleY[5]_i_3 
       (.I0(RPaddleY[6]),
        .I1(RPaddleY[7]),
        .I2(\RPaddleY[5]_i_5_n_0 ),
        .I3(RPaddleY[0]),
        .I4(RPaddleY[1]),
        .I5(RPaddleY[2]),
        .O(\RPaddleY[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000FF5500A8)) 
    \RPaddleY[5]_i_4 
       (.I0(\RPaddleY[6]_i_4_n_0 ),
        .I1(RPaddleY[7]),
        .I2(RPaddleY[6]),
        .I3(RPaddleY[3]),
        .I4(RPaddleY[5]),
        .I5(RPaddleY[4]),
        .O(\RPaddleY[5]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \RPaddleY[5]_i_5 
       (.I0(RPaddleY[3]),
        .I1(RPaddleY[5]),
        .I2(RPaddleY[4]),
        .O(\RPaddleY[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hF1F0F1FFF2FFF2F0)) 
    \RPaddleY[6]_i_1 
       (.I0(\RPaddleY[7]_i_3_n_0 ),
        .I1(\RPaddleY[6]_i_2_n_0 ),
        .I2(\RPaddleY[6]_i_3_n_0 ),
        .I3(btnr_IBUF),
        .I4(\RPaddleY[7]_i_4_n_0 ),
        .I5(RPaddleY[6]),
        .O(\RPaddleY[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \RPaddleY[6]_i_2 
       (.I0(RPaddleY[4]),
        .I1(RPaddleY[5]),
        .I2(RPaddleY[3]),
        .I3(RPaddleY[6]),
        .I4(RPaddleY[7]),
        .I5(\RPaddleY[6]_i_4_n_0 ),
        .O(\RPaddleY[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h01FF0101)) 
    \RPaddleY[6]_i_3 
       (.I0(cs[1]),
        .I1(cs[0]),
        .I2(cs[2]),
        .I3(btnr_IBUF),
        .I4(\RPaddleY[5]_i_3_n_0 ),
        .O(\RPaddleY[6]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \RPaddleY[6]_i_4 
       (.I0(RPaddleY[1]),
        .I1(RPaddleY[2]),
        .O(\RPaddleY[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00000E0F)) 
    \RPaddleY[7]_i_1 
       (.I0(btnd_IBUF),
        .I1(btnr_IBUF),
        .I2(cs[0]),
        .I3(cs[2]),
        .I4(cs[1]),
        .O(\RPaddleY[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F570F070)) 
    \RPaddleY[7]_i_2 
       (.I0(btnr_IBUF),
        .I1(\RPaddleY[7]_i_3_n_0 ),
        .I2(RPaddleY[7]),
        .I3(RPaddleY[6]),
        .I4(\RPaddleY[7]_i_4_n_0 ),
        .I5(clearX),
        .O(\RPaddleY[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \RPaddleY[7]_i_3 
       (.I0(RPaddleY[2]),
        .I1(RPaddleY[1]),
        .I2(RPaddleY[4]),
        .I3(RPaddleY[5]),
        .I4(RPaddleY[3]),
        .O(\RPaddleY[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \RPaddleY[7]_i_4 
       (.I0(RPaddleY[4]),
        .I1(RPaddleY[2]),
        .I2(RPaddleY[1]),
        .I3(RPaddleY[3]),
        .I4(RPaddleY[5]),
        .O(\RPaddleY[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[0] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[0]_i_1_n_0 ),
        .Q(RPaddleY[0]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[1] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[1]_i_1_n_0 ),
        .Q(RPaddleY[1]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[2] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[2]_i_1_n_0 ),
        .Q(RPaddleY[2]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[3] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[3]_i_1_n_0 ),
        .Q(RPaddleY[3]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[4] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[4]_i_1_n_0 ),
        .Q(RPaddleY[4]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[5] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[5]_i_1_n_0 ),
        .Q(RPaddleY[5]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[6] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[6]_i_1_n_0 ),
        .Q(RPaddleY[6]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \RPaddleY_reg[7] 
       (.C(clk_100),
        .CE(\RPaddleY[7]_i_1_n_0 ),
        .D(\RPaddleY[7]_i_2_n_0 ),
        .Q(RPaddleY[7]),
        .R(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  VLineDrawer VLineDrawer_inst
       (.D({ns[2],VLineDrawer_inst_n_10,ns[0]}),
        .\FSM_sequential_cs_reg[0]_0 (\FSM_sequential_cs[0]_i_2_n_0 ),
        .\FSM_sequential_cs_reg[0]_1 (BallDrawer_inst_n_19),
        .\FSM_sequential_cs_reg[1]_0 (VLineDrawer_inst_n_14),
        .\FSM_sequential_cs_reg[1]_1 (cs),
        .\FSM_sequential_cs_reg[2] (VLineDrawer_inst_n_7),
        .\FSM_sequential_cs_reg[2]_0 (VLineDrawer_inst_n_13),
        .\FSM_sequential_cs_reg[2]_1 (\FSM_sequential_cs[2]_i_3_n_0 ),
        .\FSM_sequential_cs_reg[2]_2 (\FSM_sequential_cs[2]_i_4_n_0 ),
        .Q(ballY_reg[7:6]),
        .WEA(WEA),
        .\ballY_reg[6] (\ballY_reg[6]_0 ),
        .\ballY_reg[6]_0 (\ballY_reg[6]_1 ),
        .btnc_IBUF(btnc_IBUF),
        .clearX(clearX),
        .clk_100(clk_100),
        .\count_reg[6]_0 ({in16[6:3],in16[1:0]}),
        .erasing(erasing),
        .ram_reg_0_0(\FSM_onehot_cs[0]_i_2_n_0 ),
        .ram_reg_0_0_0(BallDrawer_inst_n_17),
        .ram_reg_0_0_1({clearY_reg[7],clearY_reg[2]}),
        .ram_reg_1_2(ram_reg_0_0_i_44_n_0),
        .ram_reg_1_2_0(BallDrawer_inst_n_18),
        .timerRst(timerRst),
        .y_out_carry__0_0(RPaddleY),
        .y_out_carry__0_1(LPaddleY));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__4/i__carry 
       (.CI(\<const0> ),
        .CO({\_inferred__4/i__carry_n_0 ,\_inferred__4/i__carry_n_1 ,\_inferred__4/i__carry_n_2 ,\_inferred__4/i__carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({LPaddleY[3],ballY_reg[2:0]}),
        .S({i__carry_i_1__0_n_0,i__carry_i_2__0_n_0,i__carry_i_3__0_n_0,i__carry_i_4__0_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__4/i__carry__0 
       (.CI(\_inferred__4/i__carry_n_0 ),
        .CO({\_inferred__4/i__carry__0_n_0 ,\_inferred__4/i__carry__0_n_1 ,\_inferred__4/i__carry__0_n_2 ,\_inferred__4/i__carry__0_n_3 }),
        .CYINIT(\<const0> ),
        .DI({i__carry__0_i_1__0_n_0,i__carry__0_i_2__0_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0}),
        .S({i__carry__0_i_5_n_0,i__carry__0_i_6_n_0,i__carry__0_i_7_n_0,i__carry__0_i_8_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__4/i__carry__1 
       (.CI(\_inferred__4/i__carry__0_n_0 ),
        .CO(\_inferred__4/i__carry__1_n_3 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,i__carry__1_i_1_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__5/i__carry 
       (.CI(\<const0> ),
        .CO({\_inferred__5/i__carry_n_0 ,\_inferred__5/i__carry_n_1 ,\_inferred__5/i__carry_n_2 ,\_inferred__5/i__carry_n_3 }),
        .CYINIT(\<const1> ),
        .DI({RPaddleY[3],ballY_reg[2:0]}),
        .S({i__carry_i_1__1_n_0,i__carry_i_2__1_n_0,i__carry_i_3__1_n_0,i__carry_i_4__1_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__5/i__carry__0 
       (.CI(\_inferred__5/i__carry_n_0 ),
        .CO({\_inferred__5/i__carry__0_n_0 ,\_inferred__5/i__carry__0_n_1 ,\_inferred__5/i__carry__0_n_2 ,\_inferred__5/i__carry__0_n_3 }),
        .CYINIT(\<const0> ),
        .DI({i__carry__0_i_1__1_n_0,i__carry__0_i_2__1_n_0,i__carry__0_i_3__0_n_0,i__carry__0_i_4__0_n_0}),
        .S({i__carry__0_i_5__0_n_0,i__carry__0_i_6__0_n_0,i__carry__0_i_7__0_n_0,i__carry__0_i_8__0_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__5/i__carry__1 
       (.CI(\_inferred__5/i__carry__0_n_0 ),
        .CO(\_inferred__5/i__carry__1_n_3 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,\<const0> ,\<const0> ,i__carry__1_i_1__0_n_0}));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF0004)) 
    ballMovingDown_i_1
       (.I0(ballMovingDown_i_2_n_0),
        .I1(ballMovingDown_i_3_n_0),
        .I2(ballY_reg[3]),
        .I3(ballY_reg[2]),
        .I4(clearX),
        .I5(ballMovingDown_i_4_n_0),
        .O(ballMovingDown_i_1_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    ballMovingDown_i_2
       (.I0(ballY_reg[7]),
        .I1(ballY_reg[6]),
        .I2(ballY_reg[4]),
        .I3(ballY_reg[5]),
        .O(ballMovingDown_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h1)) 
    ballMovingDown_i_3
       (.I0(ballY_reg[1]),
        .I1(ballY_reg[0]),
        .O(ballMovingDown_i_3_n_0));
  LUT6 #(
    .INIT(64'hAAA8AAAAAAAAAAAA)) 
    ballMovingDown_i_4
       (.I0(in),
        .I1(ballMovingDown_i_5_n_0),
        .I2(ballY_reg[1]),
        .I3(ballY_reg[4]),
        .I4(ballY_reg[0]),
        .I5(ballY_reg[5]),
        .O(ballMovingDown_i_4_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    ballMovingDown_i_5
       (.I0(ballY_reg[7]),
        .I1(ballY_reg[6]),
        .I2(ballY_reg[3]),
        .I3(ballY_reg[2]),
        .O(ballMovingDown_i_5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ballMovingDown_reg
       (.C(clk_100),
        .CE(\<const1> ),
        .D(ballMovingDown_i_1_n_0),
        .Q(in),
        .R(\<const0> ));
  (* COMPARATOR_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 ballMovingRight2_carry
       (.CI(\<const0> ),
        .CO({ballMovingRight2_carry_n_0,ballMovingRight2_carry_n_1,ballMovingRight2_carry_n_2,ballMovingRight2_carry_n_3}),
        .CYINIT(\<const0> ),
        .DI({ballMovingRight2_carry_i_1_n_0,ballMovingRight2_carry_i_2_n_0,ballMovingRight2_carry_i_3_n_0,ballMovingRight2_carry_i_4_n_0}),
        .S({ballMovingRight2_carry_i_5_n_0,ballMovingRight2_carry_i_6_n_0,ballMovingRight2_carry_i_7_n_0,ballMovingRight2_carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 ballMovingRight2_carry__0
       (.CI(ballMovingRight2_carry_n_0),
        .CO(ballMovingRight28_in),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,ballMovingRight2_carry__0_i_1_n_0}),
        .S({\<const0> ,\<const0> ,\<const0> ,ballMovingRight2_carry__0_i_2_n_0}));
  LUT3 #(
    .INIT(8'h80)) 
    ballMovingRight2_carry__0_i_1
       (.I0(ballMovingRight2_carry_i_9_n_0),
        .I1(ballY_reg[7]),
        .I2(ballY_reg[6]),
        .O(ballMovingRight2_carry__0_i_1_n_0));
  LUT3 #(
    .INIT(8'h7F)) 
    ballMovingRight2_carry__0_i_2
       (.I0(ballY_reg[6]),
        .I1(ballY_reg[7]),
        .I2(ballMovingRight2_carry_i_9_n_0),
        .O(ballMovingRight2_carry__0_i_2_n_0));
  LUT5 #(
    .INIT(32'h15403D54)) 
    ballMovingRight2_carry_i_1
       (.I0(LPaddleY[7]),
        .I1(ballMovingRight2_carry_i_9_n_0),
        .I2(ballY_reg[6]),
        .I3(ballY_reg[7]),
        .I4(LPaddleY[6]),
        .O(ballMovingRight2_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h666AAAAAAAAAAAAA)) 
    ballMovingRight2_carry_i_10
       (.I0(ballY_reg[5]),
        .I1(ballY_reg[4]),
        .I2(ballY_reg[0]),
        .I3(ballY_reg[1]),
        .I4(ballY_reg[3]),
        .I5(ballY_reg[2]),
        .O(ballMovingRight2_carry_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h6A6A6AAA)) 
    ballMovingRight2_carry_i_11
       (.I0(ballY_reg[4]),
        .I1(ballY_reg[2]),
        .I2(ballY_reg[3]),
        .I3(ballY_reg[1]),
        .I4(ballY_reg[0]),
        .O(ballMovingRight2_carry_i_11_n_0));
  LUT4 #(
    .INIT(16'h44D4)) 
    ballMovingRight2_carry_i_2
       (.I0(LPaddleY[5]),
        .I1(ballMovingRight2_carry_i_10_n_0),
        .I2(ballMovingRight2_carry_i_11_n_0),
        .I3(LPaddleY[4]),
        .O(ballMovingRight2_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h11154440333D5554)) 
    ballMovingRight2_carry_i_3
       (.I0(LPaddleY[3]),
        .I1(ballY_reg[2]),
        .I2(ballY_reg[0]),
        .I3(ballY_reg[1]),
        .I4(ballY_reg[3]),
        .I5(LPaddleY[2]),
        .O(ballMovingRight2_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h4153)) 
    ballMovingRight2_carry_i_4
       (.I0(LPaddleY[1]),
        .I1(ballY_reg[0]),
        .I2(ballY_reg[1]),
        .I3(LPaddleY[0]),
        .O(ballMovingRight2_carry_i_4_n_0));
  LUT5 #(
    .INIT(32'h09906009)) 
    ballMovingRight2_carry_i_5
       (.I0(ballY_reg[7]),
        .I1(LPaddleY[7]),
        .I2(ballY_reg[6]),
        .I3(ballMovingRight2_carry_i_9_n_0),
        .I4(LPaddleY[6]),
        .O(ballMovingRight2_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ballMovingRight2_carry_i_6
       (.I0(ballMovingRight2_carry_i_10_n_0),
        .I1(LPaddleY[5]),
        .I2(ballMovingRight2_carry_i_11_n_0),
        .I3(LPaddleY[4]),
        .O(ballMovingRight2_carry_i_6_n_0));
  LUT6 #(
    .INIT(64'h0909099060606009)) 
    ballMovingRight2_carry_i_7
       (.I0(ballY_reg[3]),
        .I1(LPaddleY[3]),
        .I2(ballY_reg[2]),
        .I3(ballY_reg[0]),
        .I4(ballY_reg[1]),
        .I5(LPaddleY[2]),
        .O(ballMovingRight2_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h0690)) 
    ballMovingRight2_carry_i_8
       (.I0(ballY_reg[1]),
        .I1(LPaddleY[1]),
        .I2(ballY_reg[0]),
        .I3(LPaddleY[0]),
        .O(ballMovingRight2_carry_i_8_n_0));
  LUT6 #(
    .INIT(64'hA800000000000000)) 
    ballMovingRight2_carry_i_9
       (.I0(ballY_reg[4]),
        .I1(ballY_reg[0]),
        .I2(ballY_reg[1]),
        .I3(ballY_reg[3]),
        .I4(ballY_reg[2]),
        .I5(ballY_reg[5]),
        .O(ballMovingRight2_carry_i_9_n_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ballMovingRight3_inferred__0/i__carry 
       (.CI(\<const0> ),
        .CO({\ballMovingRight3_inferred__0/i__carry_n_0 ,\ballMovingRight3_inferred__0/i__carry_n_1 ,\ballMovingRight3_inferred__0/i__carry_n_2 ,\ballMovingRight3_inferred__0/i__carry_n_3 }),
        .CYINIT(\<const0> ),
        .DI({i__carry_i_1_n_0,i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0}),
        .S({i__carry_i_5_n_0,i__carry_i_6_n_0,i__carry_i_7_n_0,i__carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ballMovingRight3_inferred__0/i__carry__0 
       (.CI(\ballMovingRight3_inferred__0/i__carry_n_0 ),
        .CO(ballMovingRight3),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,p_0_in}),
        .S({\<const0> ,\<const0> ,\<const0> ,i__carry__0_i_2_n_0}));
  LUT6 #(
    .INIT(64'hEEEEEEEEFFEFFFEE)) 
    ballMovingRight_i_1
       (.I0(ballMovingRight_i_2_n_0),
        .I1(clearX),
        .I2(ballMovingRight_i_3_n_0),
        .I3(ballMovingRight0),
        .I4(ballMovingRight_reg_n_0),
        .I5(ballMovingRight),
        .O(ballMovingRight_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    ballMovingRight_i_2
       (.I0(\P2score[7]_i_3_n_0 ),
        .I1(ballX_reg[0]),
        .I2(ballX_reg[1]),
        .I3(ballX_reg[3]),
        .O(ballMovingRight_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000000000000200)) 
    ballMovingRight_i_3
       (.I0(\P1score[7]_i_5_n_0 ),
        .I1(ballX_reg[3]),
        .I2(ballX_reg[2]),
        .I3(ballMovingRight3),
        .I4(\_inferred__5/i__carry__1_n_3 ),
        .I5(ballMovingRight_i_5_n_0),
        .O(ballMovingRight_i_3_n_0));
  LUT6 #(
    .INIT(64'h2000000000000000)) 
    ballMovingRight_i_4
       (.I0(\P2score[7]_i_3_n_0 ),
        .I1(\_inferred__4/i__carry__1_n_3 ),
        .I2(ballMovingRight28_in),
        .I3(ballX_reg[1]),
        .I4(ballX_reg[3]),
        .I5(ballX_reg[0]),
        .O(ballMovingRight0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    ballMovingRight_i_5
       (.I0(ballX_reg[1]),
        .I1(ballX_reg[0]),
        .I2(ballMovingRight_reg_n_0),
        .O(ballMovingRight_i_5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ballMovingRight_reg
       (.C(clk_100),
        .CE(\<const1> ),
        .D(ballMovingRight_i_1_n_0),
        .Q(ballMovingRight_reg_n_0),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \ballX[0]_i_1 
       (.I0(ballX_reg[0]),
        .O(\ballX[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[4]_i_2 
       (.I0(ballX_reg[3]),
        .I1(ballX_reg[4]),
        .O(\ballX[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[4]_i_3 
       (.I0(ballX_reg[2]),
        .I1(ballX_reg[3]),
        .O(\ballX[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[4]_i_4 
       (.I0(ballX_reg[1]),
        .I1(ballX_reg[2]),
        .O(\ballX[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[4]_i_5 
       (.I0(ballX_reg[1]),
        .I1(ballMovingRight_reg_n_0),
        .O(\ballX[4]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \ballX[8]_i_1 
       (.I0(cs[0]),
        .I1(cs[2]),
        .I2(cs[1]),
        .O(\ballX[8]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[8]_i_3 
       (.I0(ballX_reg[7]),
        .I1(ballX_reg[8]),
        .O(\ballX[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[8]_i_4 
       (.I0(ballX_reg[6]),
        .I1(ballX_reg[7]),
        .O(\ballX[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[8]_i_5 
       (.I0(ballX_reg[5]),
        .I1(ballX_reg[6]),
        .O(\ballX[8]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballX[8]_i_6 
       (.I0(ballX_reg[4]),
        .I1(ballX_reg[5]),
        .O(\ballX[8]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ballX_reg[0] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX[0]_i_1_n_0 ),
        .Q(ballX_reg[0]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballX_reg[1] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[4]_i_1_n_7 ),
        .Q(ballX_reg[1]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballX_reg[2] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[4]_i_1_n_6 ),
        .Q(ballX_reg[2]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballX_reg[3] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[4]_i_1_n_5 ),
        .Q(ballX_reg[3]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballX_reg[4] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[4]_i_1_n_4 ),
        .Q(ballX_reg[4]),
        .R(clearX));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ballX_reg[4]_i_1 
       (.CI(\<const0> ),
        .CO({\ballX_reg[4]_i_1_n_0 ,\ballX_reg[4]_i_1_n_1 ,\ballX_reg[4]_i_1_n_2 ,\ballX_reg[4]_i_1_n_3 }),
        .CYINIT(ballX_reg[0]),
        .DI({ballX_reg[3:1],ballMovingRight_reg_n_0}),
        .O({\ballX_reg[4]_i_1_n_4 ,\ballX_reg[4]_i_1_n_5 ,\ballX_reg[4]_i_1_n_6 ,\ballX_reg[4]_i_1_n_7 }),
        .S({\ballX[4]_i_2_n_0 ,\ballX[4]_i_3_n_0 ,\ballX[4]_i_4_n_0 ,\ballX[4]_i_5_n_0 }));
  FDSE #(
    .INIT(1'b1)) 
    \ballX_reg[5] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[8]_i_2_n_7 ),
        .Q(ballX_reg[5]),
        .S(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballX_reg[6] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[8]_i_2_n_6 ),
        .Q(ballX_reg[6]),
        .R(clearX));
  FDSE #(
    .INIT(1'b1)) 
    \ballX_reg[7] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[8]_i_2_n_5 ),
        .Q(ballX_reg[7]),
        .S(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballX_reg[8] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballX_reg[8]_i_2_n_4 ),
        .Q(ballX_reg[8]),
        .R(clearX));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ballX_reg[8]_i_2 
       (.CI(\ballX_reg[4]_i_1_n_0 ),
        .CO({\ballX_reg[8]_i_2_n_1 ,\ballX_reg[8]_i_2_n_2 ,\ballX_reg[8]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,ballX_reg[6:4]}),
        .O({\ballX_reg[8]_i_2_n_4 ,\ballX_reg[8]_i_2_n_5 ,\ballX_reg[8]_i_2_n_6 ,\ballX_reg[8]_i_2_n_7 }),
        .S({\ballX[8]_i_3_n_0 ,\ballX[8]_i_4_n_0 ,\ballX[8]_i_5_n_0 ,\ballX[8]_i_6_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \ballY[0]_i_1 
       (.I0(ballY_reg[0]),
        .O(\ballY[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \ballY[4]_i_2 
       (.I0(ballY_reg[1]),
        .O(\ballY[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballY[4]_i_3 
       (.I0(ballY_reg[3]),
        .I1(ballY_reg[4]),
        .O(\ballY[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballY[4]_i_4 
       (.I0(ballY_reg[2]),
        .I1(ballY_reg[3]),
        .O(\ballY[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballY[4]_i_5 
       (.I0(ballY_reg[1]),
        .I1(ballY_reg[2]),
        .O(\ballY[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballY[4]_i_6 
       (.I0(ballY_reg[1]),
        .I1(in),
        .O(\ballY[4]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballY[7]_i_2 
       (.I0(ballY_reg[6]),
        .I1(ballY_reg[7]),
        .O(\ballY[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballY[7]_i_3 
       (.I0(ballY_reg[5]),
        .I1(ballY_reg[6]),
        .O(\ballY[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \ballY[7]_i_4 
       (.I0(ballY_reg[4]),
        .I1(ballY_reg[5]),
        .O(\ballY[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ballY_reg[0] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY[0]_i_1_n_0 ),
        .Q(ballY_reg[0]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballY_reg[1] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY_reg[4]_i_1_n_7 ),
        .Q(ballY_reg[1]),
        .R(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballY_reg[2] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY_reg[4]_i_1_n_6 ),
        .Q(ballY_reg[2]),
        .R(clearX));
  FDSE #(
    .INIT(1'b1)) 
    \ballY_reg[3] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY_reg[4]_i_1_n_5 ),
        .Q(ballY_reg[3]),
        .S(clearX));
  FDSE #(
    .INIT(1'b1)) 
    \ballY_reg[4] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY_reg[4]_i_1_n_4 ),
        .Q(ballY_reg[4]),
        .S(clearX));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ballY_reg[4]_i_1 
       (.CI(\<const0> ),
        .CO({\ballY_reg[4]_i_1_n_0 ,\ballY_reg[4]_i_1_n_1 ,\ballY_reg[4]_i_1_n_2 ,\ballY_reg[4]_i_1_n_3 }),
        .CYINIT(ballY_reg[0]),
        .DI({ballY_reg[3:1],\ballY[4]_i_2_n_0 }),
        .O({\ballY_reg[4]_i_1_n_4 ,\ballY_reg[4]_i_1_n_5 ,\ballY_reg[4]_i_1_n_6 ,\ballY_reg[4]_i_1_n_7 }),
        .S({\ballY[4]_i_3_n_0 ,\ballY[4]_i_4_n_0 ,\ballY[4]_i_5_n_0 ,\ballY[4]_i_6_n_0 }));
  FDSE #(
    .INIT(1'b1)) 
    \ballY_reg[5] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY_reg[7]_i_1_n_7 ),
        .Q(ballY_reg[5]),
        .S(clearX));
  FDSE #(
    .INIT(1'b1)) 
    \ballY_reg[6] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY_reg[7]_i_1_n_6 ),
        .Q(ballY_reg[6]),
        .S(clearX));
  FDRE #(
    .INIT(1'b0)) 
    \ballY_reg[7] 
       (.C(clk_100),
        .CE(\ballX[8]_i_1_n_0 ),
        .D(\ballY_reg[7]_i_1_n_5 ),
        .Q(ballY_reg[7]),
        .R(clearX));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ballY_reg[7]_i_1 
       (.CI(\ballY_reg[4]_i_1_n_0 ),
        .CO({\ballY_reg[7]_i_1_n_2 ,\ballY_reg[7]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,ballY_reg[5:4]}),
        .O({\ballY_reg[7]_i_1_n_5 ,\ballY_reg[7]_i_1_n_6 ,\ballY_reg[7]_i_1_n_7 }),
        .S({\<const0> ,\ballY[7]_i_2_n_0 ,\ballY[7]_i_3_n_0 ,\ballY[7]_i_4_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \clearX[0]_i_1 
       (.I0(\clearX_reg_n_0_[0] ),
        .O(\clearX[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \clearX[1]_i_1 
       (.I0(\clearX_reg_n_0_[0] ),
        .I1(\clearX_reg_n_0_[1] ),
        .O(\clearX[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \clearX[2]_i_1 
       (.I0(\clearX_reg_n_0_[2] ),
        .I1(\clearX_reg_n_0_[1] ),
        .I2(\clearX_reg_n_0_[0] ),
        .O(\clearX[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \clearX[3]_i_1 
       (.I0(\clearX_reg_n_0_[3] ),
        .I1(\clearX_reg_n_0_[0] ),
        .I2(\clearX_reg_n_0_[1] ),
        .I3(\clearX_reg_n_0_[2] ),
        .O(\clearX[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \clearX[4]_i_1 
       (.I0(\clearX_reg_n_0_[4] ),
        .I1(\clearX_reg_n_0_[2] ),
        .I2(\clearX_reg_n_0_[1] ),
        .I3(\clearX_reg_n_0_[0] ),
        .I4(\clearX_reg_n_0_[3] ),
        .O(\clearX[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \clearX[5]_i_1 
       (.I0(\clearX_reg_n_0_[5] ),
        .I1(\clearX_reg_n_0_[3] ),
        .I2(\clearX_reg_n_0_[0] ),
        .I3(\clearX_reg_n_0_[1] ),
        .I4(\clearX_reg_n_0_[2] ),
        .I5(\clearX_reg_n_0_[4] ),
        .O(\clearX[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'hF00B)) 
    \clearX[6]_i_1 
       (.I0(\clearX_reg_n_0_[7] ),
        .I1(\clearX_reg_n_0_[8] ),
        .I2(\clearX[8]_i_3_n_0 ),
        .I3(\clearX_reg_n_0_[6] ),
        .O(\clearX[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \clearX[7]_i_1 
       (.I0(\clearX_reg_n_0_[7] ),
        .I1(\clearX[8]_i_3_n_0 ),
        .I2(\clearX_reg_n_0_[6] ),
        .O(\clearX[7]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \clearX[8]_i_1 
       (.I0(cs[2]),
        .I1(cs[0]),
        .I2(cs[1]),
        .O(clearX));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'hDE20)) 
    \clearX[8]_i_2 
       (.I0(\clearX_reg_n_0_[7] ),
        .I1(\clearX[8]_i_3_n_0 ),
        .I2(\clearX_reg_n_0_[6] ),
        .I3(\clearX_reg_n_0_[8] ),
        .O(\clearX[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \clearX[8]_i_3 
       (.I0(\clearX_reg_n_0_[5] ),
        .I1(\clearX_reg_n_0_[3] ),
        .I2(\clearX_reg_n_0_[0] ),
        .I3(\clearX_reg_n_0_[1] ),
        .I4(\clearX_reg_n_0_[2] ),
        .I5(\clearX_reg_n_0_[4] ),
        .O(\clearX[8]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[0] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[0]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[0] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[1] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[1]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[1] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[2] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[2]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[2] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[3] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[3]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[3] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[4] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[4]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[4] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[5] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[5]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[5] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[6] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[6]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[6] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[7] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[7]_i_1_n_0 ),
        .Q(\clearX_reg_n_0_[7] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearX_reg[8] 
       (.C(clk_100),
        .CE(clearX),
        .D(\clearX[8]_i_2_n_0 ),
        .Q(\clearX_reg_n_0_[8] ),
        .R(btnc_IBUF));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \clearY[0]_i_1 
       (.I0(clearY_reg[0]),
        .O(p_0_in__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \clearY[1]_i_1 
       (.I0(clearY_reg[0]),
        .I1(clearY_reg[1]),
        .O(p_0_in__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \clearY[2]_i_1 
       (.I0(clearY_reg[2]),
        .I1(clearY_reg[1]),
        .I2(clearY_reg[0]),
        .O(p_0_in__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \clearY[3]_i_1 
       (.I0(clearY_reg[3]),
        .I1(clearY_reg[0]),
        .I2(clearY_reg[1]),
        .I3(clearY_reg[2]),
        .O(p_0_in__1[3]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \clearY[4]_i_1 
       (.I0(clearY_reg[4]),
        .I1(clearY_reg[2]),
        .I2(clearY_reg[1]),
        .I3(clearY_reg[0]),
        .I4(clearY_reg[3]),
        .O(p_0_in__1[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \clearY[5]_i_1 
       (.I0(clearY_reg[5]),
        .I1(clearY_reg[3]),
        .I2(clearY_reg[0]),
        .I3(clearY_reg[1]),
        .I4(clearY_reg[2]),
        .I5(clearY_reg[4]),
        .O(p_0_in__1[5]));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \clearY[6]_i_1 
       (.I0(clearY_reg[6]),
        .I1(clearY_reg[4]),
        .I2(\clearY[7]_i_4_n_0 ),
        .I3(clearY_reg[5]),
        .O(p_0_in__1[6]));
  LUT4 #(
    .INIT(16'h0001)) 
    \clearY[7]_i_1 
       (.I0(cs[1]),
        .I1(cs[0]),
        .I2(cs[2]),
        .I3(\clearY[7]_i_3_n_0 ),
        .O(clearY));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \clearY[7]_i_2 
       (.I0(clearY_reg[7]),
        .I1(clearY_reg[5]),
        .I2(\clearY[7]_i_4_n_0 ),
        .I3(clearY_reg[4]),
        .I4(clearY_reg[6]),
        .O(p_0_in__1[7]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \clearY[7]_i_3 
       (.I0(\clearX[8]_i_3_n_0 ),
        .I1(\clearX_reg_n_0_[6] ),
        .I2(\clearX_reg_n_0_[8] ),
        .I3(\clearX_reg_n_0_[7] ),
        .O(\clearY[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \clearY[7]_i_4 
       (.I0(clearY_reg[3]),
        .I1(clearY_reg[0]),
        .I2(clearY_reg[1]),
        .I3(clearY_reg[2]),
        .O(\clearY[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[0] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[0]),
        .Q(clearY_reg[0]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[1] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[1]),
        .Q(clearY_reg[1]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[2] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[2]),
        .Q(clearY_reg[2]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[3] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[3]),
        .Q(clearY_reg[3]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[4] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[4]),
        .Q(clearY_reg[4]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[5] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[5]),
        .Q(clearY_reg[5]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[6] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[6]),
        .Q(clearY_reg[6]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \clearY_reg[7] 
       (.C(clk_100),
        .CE(clearY),
        .D(p_0_in__1[7]),
        .Q(clearY_reg[7]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    erasing_reg
       (.C(clk_100),
        .CE(\<const1> ),
        .D(VLineDrawer_inst_n_14),
        .Q(erasing),
        .R(btnc_IBUF));
  LUT3 #(
    .INIT(8'h80)) 
    i__carry__0_i_1
       (.I0(ballMovingRight2_carry_i_9_n_0),
        .I1(ballY_reg[7]),
        .I2(ballY_reg[6]),
        .O(p_0_in));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_1__0
       (.I0(ballY_reg[6]),
        .I1(LPaddleY[6]),
        .O(i__carry__0_i_1__0_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_1__1
       (.I0(ballY_reg[6]),
        .I1(RPaddleY[6]),
        .O(i__carry__0_i_1__1_n_0));
  LUT3 #(
    .INIT(8'h7F)) 
    i__carry__0_i_2
       (.I0(ballY_reg[6]),
        .I1(ballY_reg[7]),
        .I2(ballMovingRight2_carry_i_9_n_0),
        .O(i__carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_2__0
       (.I0(ballY_reg[6]),
        .I1(LPaddleY[6]),
        .O(i__carry__0_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_2__1
       (.I0(ballY_reg[6]),
        .I1(RPaddleY[6]),
        .O(i__carry__0_i_2__1_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_3
       (.I0(ballY_reg[4]),
        .I1(LPaddleY[4]),
        .O(i__carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_3__0
       (.I0(ballY_reg[4]),
        .I1(RPaddleY[4]),
        .O(i__carry__0_i_3__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_4
       (.I0(LPaddleY[3]),
        .O(i__carry__0_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_4__0
       (.I0(RPaddleY[3]),
        .O(i__carry__0_i_4__0_n_0));
  LUT4 #(
    .INIT(16'hD22D)) 
    i__carry__0_i_5
       (.I0(LPaddleY[6]),
        .I1(ballY_reg[6]),
        .I2(LPaddleY[7]),
        .I3(ballY_reg[7]),
        .O(i__carry__0_i_5_n_0));
  LUT4 #(
    .INIT(16'hD22D)) 
    i__carry__0_i_5__0
       (.I0(RPaddleY[6]),
        .I1(ballY_reg[6]),
        .I2(RPaddleY[7]),
        .I3(ballY_reg[7]),
        .O(i__carry__0_i_5__0_n_0));
  LUT4 #(
    .INIT(16'h6966)) 
    i__carry__0_i_6
       (.I0(LPaddleY[6]),
        .I1(ballY_reg[6]),
        .I2(LPaddleY[5]),
        .I3(ballY_reg[5]),
        .O(i__carry__0_i_6_n_0));
  LUT4 #(
    .INIT(16'h6966)) 
    i__carry__0_i_6__0
       (.I0(RPaddleY[6]),
        .I1(ballY_reg[6]),
        .I2(RPaddleY[5]),
        .I3(ballY_reg[5]),
        .O(i__carry__0_i_6__0_n_0));
  LUT4 #(
    .INIT(16'h2DD2)) 
    i__carry__0_i_7
       (.I0(LPaddleY[4]),
        .I1(ballY_reg[4]),
        .I2(LPaddleY[5]),
        .I3(ballY_reg[5]),
        .O(i__carry__0_i_7_n_0));
  LUT4 #(
    .INIT(16'h2DD2)) 
    i__carry__0_i_7__0
       (.I0(RPaddleY[4]),
        .I1(ballY_reg[4]),
        .I2(RPaddleY[5]),
        .I3(ballY_reg[5]),
        .O(i__carry__0_i_7__0_n_0));
  LUT3 #(
    .INIT(8'h69)) 
    i__carry__0_i_8
       (.I0(ballY_reg[4]),
        .I1(LPaddleY[4]),
        .I2(LPaddleY[3]),
        .O(i__carry__0_i_8_n_0));
  LUT3 #(
    .INIT(8'h69)) 
    i__carry__0_i_8__0
       (.I0(RPaddleY[4]),
        .I1(ballY_reg[4]),
        .I2(RPaddleY[3]),
        .O(i__carry__0_i_8__0_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__1_i_1
       (.I0(ballY_reg[7]),
        .I1(LPaddleY[7]),
        .O(i__carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__1_i_1__0
       (.I0(ballY_reg[7]),
        .I1(RPaddleY[7]),
        .O(i__carry__1_i_1__0_n_0));
  LUT5 #(
    .INIT(32'h15403D54)) 
    i__carry_i_1
       (.I0(RPaddleY[7]),
        .I1(ballMovingRight2_carry_i_9_n_0),
        .I2(ballY_reg[6]),
        .I3(ballY_reg[7]),
        .I4(RPaddleY[6]),
        .O(i__carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_1__0
       (.I0(LPaddleY[3]),
        .I1(ballY_reg[3]),
        .O(i__carry_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_1__1
       (.I0(RPaddleY[3]),
        .I1(ballY_reg[3]),
        .O(i__carry_i_1__1_n_0));
  LUT4 #(
    .INIT(16'h44D4)) 
    i__carry_i_2
       (.I0(RPaddleY[5]),
        .I1(ballMovingRight2_carry_i_10_n_0),
        .I2(ballMovingRight2_carry_i_11_n_0),
        .I3(RPaddleY[4]),
        .O(i__carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_2__0
       (.I0(ballY_reg[2]),
        .I1(LPaddleY[2]),
        .O(i__carry_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_2__1
       (.I0(ballY_reg[2]),
        .I1(RPaddleY[2]),
        .O(i__carry_i_2__1_n_0));
  LUT6 #(
    .INIT(64'h11154440333D5554)) 
    i__carry_i_3
       (.I0(RPaddleY[3]),
        .I1(ballY_reg[2]),
        .I2(ballY_reg[0]),
        .I3(ballY_reg[1]),
        .I4(ballY_reg[3]),
        .I5(RPaddleY[2]),
        .O(i__carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_3__0
       (.I0(ballY_reg[1]),
        .I1(LPaddleY[1]),
        .O(i__carry_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_3__1
       (.I0(ballY_reg[1]),
        .I1(RPaddleY[1]),
        .O(i__carry_i_3__1_n_0));
  LUT4 #(
    .INIT(16'h4153)) 
    i__carry_i_4
       (.I0(RPaddleY[1]),
        .I1(ballY_reg[0]),
        .I2(ballY_reg[1]),
        .I3(RPaddleY[0]),
        .O(i__carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4__0
       (.I0(ballY_reg[0]),
        .I1(LPaddleY[0]),
        .O(i__carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4__1
       (.I0(ballY_reg[0]),
        .I1(RPaddleY[0]),
        .O(i__carry_i_4__1_n_0));
  LUT5 #(
    .INIT(32'h09906009)) 
    i__carry_i_5
       (.I0(ballY_reg[7]),
        .I1(RPaddleY[7]),
        .I2(ballY_reg[6]),
        .I3(ballMovingRight2_carry_i_9_n_0),
        .I4(RPaddleY[6]),
        .O(i__carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    i__carry_i_6
       (.I0(ballMovingRight2_carry_i_10_n_0),
        .I1(RPaddleY[5]),
        .I2(ballMovingRight2_carry_i_11_n_0),
        .I3(RPaddleY[4]),
        .O(i__carry_i_6_n_0));
  LUT6 #(
    .INIT(64'h0909099060606009)) 
    i__carry_i_7
       (.I0(ballY_reg[3]),
        .I1(RPaddleY[3]),
        .I2(ballY_reg[2]),
        .I3(ballY_reg[0]),
        .I4(ballY_reg[1]),
        .I5(RPaddleY[2]),
        .O(i__carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h0690)) 
    i__carry_i_8
       (.I0(ballY_reg[1]),
        .I1(RPaddleY[1]),
        .I2(ballY_reg[0]),
        .I3(RPaddleY[0]),
        .O(i__carry_i_8_n_0));
  LUT4 #(
    .INIT(16'h0008)) 
    ram_reg_0_0_i_19
       (.I0(cs[1]),
        .I1(cs[0]),
        .I2(cs[2]),
        .I3(erasing),
        .O(vga_color[0]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'h4140)) 
    ram_reg_0_0_i_32
       (.I0(cs[2]),
        .I1(cs[0]),
        .I2(cs[1]),
        .I3(\clearX_reg_n_0_[8] ),
        .O(ram_reg_0_0_i_32_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    ram_reg_0_0_i_44
       (.I0(cs[0]),
        .I1(cs[2]),
        .O(ram_reg_0_0_i_44_n_0));
  LUT4 #(
    .INIT(16'h0004)) 
    ram_reg_0_1_i_1
       (.I0(cs[1]),
        .I1(cs[0]),
        .I2(cs[2]),
        .I3(erasing),
        .O(vga_color[1]));
  LUT4 #(
    .INIT(16'h0002)) 
    ram_reg_0_2_i_1
       (.I0(cs[1]),
        .I1(cs[0]),
        .I2(cs[2]),
        .I3(erasing),
        .O(vga_color[2]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h2190)) 
    \segment_OBUF[0]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_3_n_0 ),
        .O(segment_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h0179)) 
    \segment_OBUF[1]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_3_n_0 ),
        .O(segment_OBUF[1]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h1091)) 
    \segment_OBUF[2]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_4_n_0 ),
        .O(segment_OBUF[2]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h6109)) 
    \segment_OBUF[3]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_2_n_0 ),
        .O(segment_OBUF[3]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h3A22)) 
    \segment_OBUF[4]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_4_n_0 ),
        .O(segment_OBUF[4]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h4C14)) 
    \segment_OBUF[5]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_5_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_3_n_0 ),
        .O(segment_OBUF[5]));
  LUT4 #(
    .INIT(16'h9082)) 
    \segment_OBUF[6]_inst_i_1 
       (.I0(\segment_OBUF[6]_inst_i_2_n_0 ),
        .I1(\segment_OBUF[6]_inst_i_3_n_0 ),
        .I2(\segment_OBUF[6]_inst_i_4_n_0 ),
        .I3(\segment_OBUF[6]_inst_i_5_n_0 ),
        .O(segment_OBUF[6]));
  LUT6 #(
    .INIT(64'h55330F0055330FFF)) 
    \segment_OBUF[6]_inst_i_2 
       (.I0(P1score[7]),
        .I1(P1score[3]),
        .I2(P2score[7]),
        .I3(anode_select[0]),
        .I4(anode_select[1]),
        .I5(P2score[3]),
        .O(\segment_OBUF[6]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h3300550F33FF550F)) 
    \segment_OBUF[6]_inst_i_3 
       (.I0(P2score[6]),
        .I1(P1score[6]),
        .I2(P2score[2]),
        .I3(anode_select[0]),
        .I4(anode_select[1]),
        .I5(P1score[2]),
        .O(\segment_OBUF[6]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h3300550F33FF550F)) 
    \segment_OBUF[6]_inst_i_4 
       (.I0(P2score[5]),
        .I1(P1score[5]),
        .I2(P2score[1]),
        .I3(anode_select[0]),
        .I4(anode_select[1]),
        .I5(P1score[1]),
        .O(\segment_OBUF[6]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h3300550F33FF550F)) 
    \segment_OBUF[6]_inst_i_5 
       (.I0(P2score[4]),
        .I1(P1score[4]),
        .I2(P2score[0]),
        .I3(anode_select[0]),
        .I4(anode_select[1]),
        .I5(P1score[0]),
        .O(\segment_OBUF[6]_inst_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timerCount[0]_i_3 
       (.I0(timerCount_reg[0]),
        .O(\timerCount[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[0] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[0]_i_2_n_7 ),
        .Q(timerCount_reg[0]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[0]_i_2 
       (.CI(\<const0> ),
        .CO({\timerCount_reg[0]_i_2_n_0 ,\timerCount_reg[0]_i_2_n_1 ,\timerCount_reg[0]_i_2_n_2 ,\timerCount_reg[0]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\timerCount_reg[0]_i_2_n_4 ,\timerCount_reg[0]_i_2_n_5 ,\timerCount_reg[0]_i_2_n_6 ,\timerCount_reg[0]_i_2_n_7 }),
        .S({timerCount_reg[3:1],\timerCount[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[10] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[8]_i_1_n_5 ),
        .Q(timerCount_reg[10]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[11] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[8]_i_1_n_4 ),
        .Q(timerCount_reg[11]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[12] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[12]_i_1_n_7 ),
        .Q(timerCount_reg[12]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[12]_i_1 
       (.CI(\timerCount_reg[8]_i_1_n_0 ),
        .CO({\timerCount_reg[12]_i_1_n_0 ,\timerCount_reg[12]_i_1_n_1 ,\timerCount_reg[12]_i_1_n_2 ,\timerCount_reg[12]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\timerCount_reg[12]_i_1_n_4 ,\timerCount_reg[12]_i_1_n_5 ,\timerCount_reg[12]_i_1_n_6 ,\timerCount_reg[12]_i_1_n_7 }),
        .S(timerCount_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[13] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[12]_i_1_n_6 ),
        .Q(timerCount_reg[13]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[14] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[12]_i_1_n_5 ),
        .Q(timerCount_reg[14]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[15] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[12]_i_1_n_4 ),
        .Q(timerCount_reg[15]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[16] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[16]_i_1_n_7 ),
        .Q(timerCount_reg[16]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[16]_i_1 
       (.CI(\timerCount_reg[12]_i_1_n_0 ),
        .CO({\timerCount_reg[16]_i_1_n_0 ,\timerCount_reg[16]_i_1_n_1 ,\timerCount_reg[16]_i_1_n_2 ,\timerCount_reg[16]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\timerCount_reg[16]_i_1_n_4 ,\timerCount_reg[16]_i_1_n_5 ,\timerCount_reg[16]_i_1_n_6 ,\timerCount_reg[16]_i_1_n_7 }),
        .S(timerCount_reg[19:16]));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[17] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[16]_i_1_n_6 ),
        .Q(timerCount_reg[17]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[18] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[16]_i_1_n_5 ),
        .Q(timerCount_reg[18]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[19] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[16]_i_1_n_4 ),
        .Q(timerCount_reg[19]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[1] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[0]_i_2_n_6 ),
        .Q(timerCount_reg[1]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[20] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[20]_i_1_n_7 ),
        .Q(timerCount_reg[20]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[20]_i_1 
       (.CI(\timerCount_reg[16]_i_1_n_0 ),
        .CO({\timerCount_reg[20]_i_1_n_0 ,\timerCount_reg[20]_i_1_n_1 ,\timerCount_reg[20]_i_1_n_2 ,\timerCount_reg[20]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\timerCount_reg[20]_i_1_n_4 ,\timerCount_reg[20]_i_1_n_5 ,\timerCount_reg[20]_i_1_n_6 ,\timerCount_reg[20]_i_1_n_7 }),
        .S(timerCount_reg[23:20]));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[21] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[20]_i_1_n_6 ),
        .Q(timerCount_reg[21]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[22] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[20]_i_1_n_5 ),
        .Q(timerCount_reg[22]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[23] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[20]_i_1_n_4 ),
        .Q(timerCount_reg[23]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[24] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[24]_i_1_n_7 ),
        .Q(timerCount_reg[24]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[24]_i_1 
       (.CI(\timerCount_reg[20]_i_1_n_0 ),
        .CO({\timerCount_reg[24]_i_1_n_0 ,\timerCount_reg[24]_i_1_n_1 ,\timerCount_reg[24]_i_1_n_2 ,\timerCount_reg[24]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\timerCount_reg[24]_i_1_n_4 ,\timerCount_reg[24]_i_1_n_5 ,\timerCount_reg[24]_i_1_n_6 ,\timerCount_reg[24]_i_1_n_7 }),
        .S(timerCount_reg[27:24]));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[25] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[24]_i_1_n_6 ),
        .Q(timerCount_reg[25]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[26] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[24]_i_1_n_5 ),
        .Q(timerCount_reg[26]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[27] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[24]_i_1_n_4 ),
        .Q(timerCount_reg[27]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[28] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[28]_i_1_n_7 ),
        .Q(timerCount_reg[28]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[28]_i_1 
       (.CI(\timerCount_reg[24]_i_1_n_0 ),
        .CO({\timerCount_reg[28]_i_1_n_1 ,\timerCount_reg[28]_i_1_n_2 ,\timerCount_reg[28]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\timerCount_reg[28]_i_1_n_4 ,\timerCount_reg[28]_i_1_n_5 ,\timerCount_reg[28]_i_1_n_6 ,\timerCount_reg[28]_i_1_n_7 }),
        .S(timerCount_reg[31:28]));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[29] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[28]_i_1_n_6 ),
        .Q(timerCount_reg[29]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[2] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[0]_i_2_n_5 ),
        .Q(timerCount_reg[2]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[30] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[28]_i_1_n_5 ),
        .Q(timerCount_reg[30]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[31] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[28]_i_1_n_4 ),
        .Q(timerCount_reg[31]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[3] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[0]_i_2_n_4 ),
        .Q(timerCount_reg[3]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[4] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[4]_i_1_n_7 ),
        .Q(timerCount_reg[4]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[4]_i_1 
       (.CI(\timerCount_reg[0]_i_2_n_0 ),
        .CO({\timerCount_reg[4]_i_1_n_0 ,\timerCount_reg[4]_i_1_n_1 ,\timerCount_reg[4]_i_1_n_2 ,\timerCount_reg[4]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\timerCount_reg[4]_i_1_n_4 ,\timerCount_reg[4]_i_1_n_5 ,\timerCount_reg[4]_i_1_n_6 ,\timerCount_reg[4]_i_1_n_7 }),
        .S(timerCount_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[5] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[4]_i_1_n_6 ),
        .Q(timerCount_reg[5]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[6] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[4]_i_1_n_5 ),
        .Q(timerCount_reg[6]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[7] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[4]_i_1_n_4 ),
        .Q(timerCount_reg[7]),
        .R(timerRst));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[8] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[8]_i_1_n_7 ),
        .Q(timerCount_reg[8]),
        .R(timerRst));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \timerCount_reg[8]_i_1 
       (.CI(\timerCount_reg[4]_i_1_n_0 ),
        .CO({\timerCount_reg[8]_i_1_n_0 ,\timerCount_reg[8]_i_1_n_1 ,\timerCount_reg[8]_i_1_n_2 ,\timerCount_reg[8]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\timerCount_reg[8]_i_1_n_4 ,\timerCount_reg[8]_i_1_n_5 ,\timerCount_reg[8]_i_1_n_6 ,\timerCount_reg[8]_i_1_n_7 }),
        .S(timerCount_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \timerCount_reg[9] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\timerCount_reg[8]_i_1_n_6 ),
        .Q(timerCount_reg[9]),
        .R(timerRst));
endmodule

module SevenSegmentControl
   (anode_select,
    anode_OBUF,
    segment_OBUF,
    btnc_IBUF,
    clk_100);
  output [1:0]anode_select;
  output [2:0]anode_OBUF;
  output [0:0]segment_OBUF;
  input btnc_IBUF;
  input clk_100;

  wire \<const0> ;
  wire \<const1> ;
  wire [2:0]anode_OBUF;
  wire [1:0]anode_select;
  wire btnc_IBUF;
  wire clk_100;
  wire \count_val[0]_i_2_n_0 ;
  wire \count_val_reg[0]_i_1_n_0 ;
  wire \count_val_reg[0]_i_1_n_1 ;
  wire \count_val_reg[0]_i_1_n_2 ;
  wire \count_val_reg[0]_i_1_n_3 ;
  wire \count_val_reg[0]_i_1_n_4 ;
  wire \count_val_reg[0]_i_1_n_5 ;
  wire \count_val_reg[0]_i_1_n_6 ;
  wire \count_val_reg[0]_i_1_n_7 ;
  wire \count_val_reg[12]_i_1_n_0 ;
  wire \count_val_reg[12]_i_1_n_1 ;
  wire \count_val_reg[12]_i_1_n_2 ;
  wire \count_val_reg[12]_i_1_n_3 ;
  wire \count_val_reg[12]_i_1_n_4 ;
  wire \count_val_reg[12]_i_1_n_5 ;
  wire \count_val_reg[12]_i_1_n_6 ;
  wire \count_val_reg[12]_i_1_n_7 ;
  wire \count_val_reg[16]_i_1_n_7 ;
  wire \count_val_reg[4]_i_1_n_0 ;
  wire \count_val_reg[4]_i_1_n_1 ;
  wire \count_val_reg[4]_i_1_n_2 ;
  wire \count_val_reg[4]_i_1_n_3 ;
  wire \count_val_reg[4]_i_1_n_4 ;
  wire \count_val_reg[4]_i_1_n_5 ;
  wire \count_val_reg[4]_i_1_n_6 ;
  wire \count_val_reg[4]_i_1_n_7 ;
  wire \count_val_reg[8]_i_1_n_0 ;
  wire \count_val_reg[8]_i_1_n_1 ;
  wire \count_val_reg[8]_i_1_n_2 ;
  wire \count_val_reg[8]_i_1_n_3 ;
  wire \count_val_reg[8]_i_1_n_4 ;
  wire \count_val_reg[8]_i_1_n_5 ;
  wire \count_val_reg[8]_i_1_n_6 ;
  wire \count_val_reg[8]_i_1_n_7 ;
  wire \count_val_reg_n_0_[0] ;
  wire \count_val_reg_n_0_[10] ;
  wire \count_val_reg_n_0_[11] ;
  wire \count_val_reg_n_0_[12] ;
  wire \count_val_reg_n_0_[13] ;
  wire \count_val_reg_n_0_[14] ;
  wire \count_val_reg_n_0_[1] ;
  wire \count_val_reg_n_0_[2] ;
  wire \count_val_reg_n_0_[3] ;
  wire \count_val_reg_n_0_[4] ;
  wire \count_val_reg_n_0_[5] ;
  wire \count_val_reg_n_0_[6] ;
  wire \count_val_reg_n_0_[7] ;
  wire \count_val_reg_n_0_[8] ;
  wire \count_val_reg_n_0_[9] ;
  wire [0:0]segment_OBUF;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \anode_OBUF[0]_inst_i_1 
       (.I0(anode_select[1]),
        .I1(anode_select[0]),
        .O(anode_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \anode_OBUF[1]_inst_i_1 
       (.I0(anode_select[1]),
        .I1(anode_select[0]),
        .O(anode_OBUF[1]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \anode_OBUF[2]_inst_i_1 
       (.I0(anode_select[0]),
        .I1(anode_select[1]),
        .O(segment_OBUF));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \anode_OBUF[3]_inst_i_1 
       (.I0(anode_select[1]),
        .I1(anode_select[0]),
        .O(anode_OBUF[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \count_val[0]_i_2 
       (.I0(\count_val_reg_n_0_[0] ),
        .O(\count_val[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[0] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_7 ),
        .Q(\count_val_reg_n_0_[0] ),
        .R(btnc_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \count_val_reg[0]_i_1 
       (.CI(\<const0> ),
        .CO({\count_val_reg[0]_i_1_n_0 ,\count_val_reg[0]_i_1_n_1 ,\count_val_reg[0]_i_1_n_2 ,\count_val_reg[0]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\count_val_reg[0]_i_1_n_4 ,\count_val_reg[0]_i_1_n_5 ,\count_val_reg[0]_i_1_n_6 ,\count_val_reg[0]_i_1_n_7 }),
        .S({\count_val_reg_n_0_[3] ,\count_val_reg_n_0_[2] ,\count_val_reg_n_0_[1] ,\count_val[0]_i_2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[10] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_5 ),
        .Q(\count_val_reg_n_0_[10] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[11] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_4 ),
        .Q(\count_val_reg_n_0_[11] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[12] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_7 ),
        .Q(\count_val_reg_n_0_[12] ),
        .R(btnc_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \count_val_reg[12]_i_1 
       (.CI(\count_val_reg[8]_i_1_n_0 ),
        .CO({\count_val_reg[12]_i_1_n_0 ,\count_val_reg[12]_i_1_n_1 ,\count_val_reg[12]_i_1_n_2 ,\count_val_reg[12]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_val_reg[12]_i_1_n_4 ,\count_val_reg[12]_i_1_n_5 ,\count_val_reg[12]_i_1_n_6 ,\count_val_reg[12]_i_1_n_7 }),
        .S({anode_select[0],\count_val_reg_n_0_[14] ,\count_val_reg_n_0_[13] ,\count_val_reg_n_0_[12] }));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[13] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_6 ),
        .Q(\count_val_reg_n_0_[13] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[14] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_5 ),
        .Q(\count_val_reg_n_0_[14] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[15] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[12]_i_1_n_4 ),
        .Q(anode_select[0]),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[16] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[16]_i_1_n_7 ),
        .Q(anode_select[1]),
        .R(btnc_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \count_val_reg[16]_i_1 
       (.CI(\count_val_reg[12]_i_1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(\count_val_reg[16]_i_1_n_7 ),
        .S({\<const0> ,\<const0> ,\<const0> ,anode_select[1]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[1] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_6 ),
        .Q(\count_val_reg_n_0_[1] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[2] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_5 ),
        .Q(\count_val_reg_n_0_[2] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[3] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[0]_i_1_n_4 ),
        .Q(\count_val_reg_n_0_[3] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[4] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_7 ),
        .Q(\count_val_reg_n_0_[4] ),
        .R(btnc_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \count_val_reg[4]_i_1 
       (.CI(\count_val_reg[0]_i_1_n_0 ),
        .CO({\count_val_reg[4]_i_1_n_0 ,\count_val_reg[4]_i_1_n_1 ,\count_val_reg[4]_i_1_n_2 ,\count_val_reg[4]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_val_reg[4]_i_1_n_4 ,\count_val_reg[4]_i_1_n_5 ,\count_val_reg[4]_i_1_n_6 ,\count_val_reg[4]_i_1_n_7 }),
        .S({\count_val_reg_n_0_[7] ,\count_val_reg_n_0_[6] ,\count_val_reg_n_0_[5] ,\count_val_reg_n_0_[4] }));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[5] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_6 ),
        .Q(\count_val_reg_n_0_[5] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[6] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_5 ),
        .Q(\count_val_reg_n_0_[6] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[7] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[4]_i_1_n_4 ),
        .Q(\count_val_reg_n_0_[7] ),
        .R(btnc_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[8] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_7 ),
        .Q(\count_val_reg_n_0_[8] ),
        .R(btnc_IBUF));
  (* ADDER_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \count_val_reg[8]_i_1 
       (.CI(\count_val_reg[4]_i_1_n_0 ),
        .CO({\count_val_reg[8]_i_1_n_0 ,\count_val_reg[8]_i_1_n_1 ,\count_val_reg[8]_i_1_n_2 ,\count_val_reg[8]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_val_reg[8]_i_1_n_4 ,\count_val_reg[8]_i_1_n_5 ,\count_val_reg[8]_i_1_n_6 ,\count_val_reg[8]_i_1_n_7 }),
        .S({\count_val_reg_n_0_[11] ,\count_val_reg_n_0_[10] ,\count_val_reg_n_0_[9] ,\count_val_reg_n_0_[8] }));
  FDRE #(
    .INIT(1'b0)) 
    \count_val_reg[9] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(\count_val_reg[8]_i_1_n_6 ),
        .Q(\count_val_reg_n_0_[9] ),
        .R(btnc_IBUF));
endmodule

module VLineDrawer
   (\count_reg[6]_0 ,
    \ballY_reg[6] ,
    \FSM_sequential_cs_reg[2] ,
    \ballY_reg[6]_0 ,
    D,
    timerRst,
    \FSM_sequential_cs_reg[2]_0 ,
    \FSM_sequential_cs_reg[1]_0 ,
    WEA,
    ram_reg_0_0,
    ram_reg_0_0_0,
    Q,
    \FSM_sequential_cs_reg[0]_0 ,
    \FSM_sequential_cs_reg[1]_1 ,
    erasing,
    \FSM_sequential_cs_reg[0]_1 ,
    \FSM_sequential_cs_reg[2]_1 ,
    \FSM_sequential_cs_reg[2]_2 ,
    btnc_IBUF,
    clearX,
    ram_reg_1_2,
    ram_reg_1_2_0,
    ram_reg_0_0_1,
    y_out_carry__0_0,
    y_out_carry__0_1,
    clk_100);
  output [5:0]\count_reg[6]_0 ;
  output \ballY_reg[6] ;
  output \FSM_sequential_cs_reg[2] ;
  output [0:0]\ballY_reg[6]_0 ;
  output [2:0]D;
  output timerRst;
  output \FSM_sequential_cs_reg[2]_0 ;
  output \FSM_sequential_cs_reg[1]_0 ;
  output [0:0]WEA;
  input ram_reg_0_0;
  input ram_reg_0_0_0;
  input [1:0]Q;
  input \FSM_sequential_cs_reg[0]_0 ;
  input [2:0]\FSM_sequential_cs_reg[1]_1 ;
  input erasing;
  input \FSM_sequential_cs_reg[0]_1 ;
  input \FSM_sequential_cs_reg[2]_1 ;
  input \FSM_sequential_cs_reg[2]_2 ;
  input btnc_IBUF;
  input clearX;
  input ram_reg_1_2;
  input ram_reg_1_2_0;
  input [1:0]ram_reg_0_0_1;
  input [7:0]y_out_carry__0_0;
  input [7:0]y_out_carry__0_1;
  input clk_100;

  wire \<const0> ;
  wire \<const1> ;
  wire [2:0]D;
  wire \FSM_sequential_cs[2]_i_2_n_0 ;
  wire \FSM_sequential_cs_reg[0]_0 ;
  wire \FSM_sequential_cs_reg[0]_1 ;
  wire \FSM_sequential_cs_reg[1]_0 ;
  wire [2:0]\FSM_sequential_cs_reg[1]_1 ;
  wire \FSM_sequential_cs_reg[2] ;
  wire \FSM_sequential_cs_reg[2]_0 ;
  wire \FSM_sequential_cs_reg[2]_1 ;
  wire \FSM_sequential_cs_reg[2]_2 ;
  wire [1:0]Q;
  wire [0:0]WEA;
  wire \ballY_reg[6] ;
  wire [0:0]\ballY_reg[6]_0 ;
  wire btnc_IBUF;
  wire clearX;
  wire clk_100;
  wire \count[7]_i_2_n_0 ;
  wire \count[7]_i_4_n_0 ;
  wire [7:0]count_reg;
  wire [5:0]\count_reg[6]_0 ;
  wire [1:0]cs;
  wire erasing;
  wire [7:2]in16;
  wire lineDone;
  wire lineDone_carry_i_1_n_0;
  wire lineDone_carry_i_2_n_0;
  wire lineDone_carry_i_3_n_0;
  wire lineDone_carry_n_2;
  wire lineDone_carry_n_3;
  wire [1:0]ns;
  wire [7:0]p_0_in__0;
  wire ram_reg_0_0;
  wire ram_reg_0_0_0;
  wire [1:0]ram_reg_0_0_1;
  wire ram_reg_0_0_i_43_n_0;
  wire ram_reg_1_2;
  wire ram_reg_1_2_0;
  wire resetCount4_out;
  wire timerRst;
  wire vga_wr_en;
  wire [7:0]y_out_carry__0_0;
  wire [7:0]y_out_carry__0_1;
  wire y_out_carry__0_i_1_n_0;
  wire y_out_carry__0_i_2_n_0;
  wire y_out_carry__0_i_3_n_0;
  wire y_out_carry__0_i_4_n_0;
  wire y_out_carry__0_n_1;
  wire y_out_carry__0_n_2;
  wire y_out_carry__0_n_3;
  wire y_out_carry_i_1_n_0;
  wire y_out_carry_i_2_n_0;
  wire y_out_carry_i_3_n_0;
  wire y_out_carry_i_4_n_0;
  wire y_out_carry_n_0;
  wire y_out_carry_n_1;
  wire y_out_carry_n_2;
  wire y_out_carry_n_3;

  LUT6 #(
    .INIT(64'hFFFFFFFF01010FFF)) 
    \FSM_sequential_cs[0]_i_1 
       (.I0(\FSM_sequential_cs_reg[0]_0 ),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(\FSM_sequential_cs[2]_i_2_n_0 ),
        .I3(erasing),
        .I4(\FSM_sequential_cs_reg[0]_1 ),
        .I5(\FSM_sequential_cs_reg[1]_1 [2]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'h00040F04)) 
    \FSM_sequential_cs[0]_i_1__0 
       (.I0(\FSM_sequential_cs_reg[1]_1 [2]),
        .I1(\FSM_sequential_cs_reg[1]_1 [0]),
        .I2(cs[1]),
        .I3(cs[0]),
        .I4(lineDone),
        .O(ns[0]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'h0F004040)) 
    \FSM_sequential_cs[1]_i_1 
       (.I0(\FSM_sequential_cs_reg[1]_1 [2]),
        .I1(\FSM_sequential_cs_reg[1]_1 [0]),
        .I2(cs[1]),
        .I3(lineDone),
        .I4(cs[0]),
        .O(ns[1]));
  LUT5 #(
    .INIT(32'h15554000)) 
    \FSM_sequential_cs[1]_i_1__0 
       (.I0(\FSM_sequential_cs_reg[1]_1 [2]),
        .I1(\count[7]_i_2_n_0 ),
        .I2(\FSM_sequential_cs_reg[1]_1 [0]),
        .I3(lineDone),
        .I4(\FSM_sequential_cs_reg[1]_1 [1]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hFF0F000088888888)) 
    \FSM_sequential_cs[2]_i_1 
       (.I0(\FSM_sequential_cs_reg[1]_1 [1]),
        .I1(\FSM_sequential_cs[2]_i_2_n_0 ),
        .I2(\FSM_sequential_cs_reg[2]_1 ),
        .I3(\FSM_sequential_cs_reg[2]_2 ),
        .I4(\FSM_sequential_cs_reg[1]_1 [0]),
        .I5(\FSM_sequential_cs_reg[1]_1 [2]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h04000000)) 
    \FSM_sequential_cs[2]_i_2 
       (.I0(cs[1]),
        .I1(cs[0]),
        .I2(btnc_IBUF),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(lineDone),
        .O(\FSM_sequential_cs[2]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "DrawLine:01,Idle:00,Finished:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_cs_reg[0] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(ns[0]),
        .Q(cs[0]),
        .R(btnc_IBUF));
  (* FSM_ENCODED_STATES = "DrawLine:01,Idle:00,Finished:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_cs_reg[1] 
       (.C(clk_100),
        .CE(\<const1> ),
        .D(ns[1]),
        .Q(cs[1]),
        .R(btnc_IBUF));
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1 
       (.I0(count_reg[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(count_reg[0]),
        .I1(count_reg[1]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \count[2]_i_1 
       (.I0(count_reg[2]),
        .I1(count_reg[1]),
        .I2(count_reg[0]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \count[3]_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[0]),
        .I2(count_reg[1]),
        .I3(count_reg[2]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \count[4]_i_1 
       (.I0(count_reg[4]),
        .I1(count_reg[3]),
        .I2(count_reg[2]),
        .I3(count_reg[1]),
        .I4(count_reg[0]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \count[5]_i_1 
       (.I0(count_reg[5]),
        .I1(count_reg[0]),
        .I2(count_reg[1]),
        .I3(count_reg[2]),
        .I4(count_reg[3]),
        .I5(count_reg[4]),
        .O(p_0_in__0[5]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \count[6]_i_1 
       (.I0(count_reg[6]),
        .I1(count_reg[4]),
        .I2(count_reg[3]),
        .I3(\count[7]_i_4_n_0 ),
        .I4(count_reg[5]),
        .O(p_0_in__0[6]));
  LUT5 #(
    .INIT(32'h00000010)) 
    \count[7]_i_1 
       (.I0(cs[1]),
        .I1(\FSM_sequential_cs_reg[1]_1 [2]),
        .I2(\FSM_sequential_cs_reg[1]_1 [0]),
        .I3(cs[0]),
        .I4(btnc_IBUF),
        .O(resetCount4_out));
  LUT3 #(
    .INIT(8'h04)) 
    \count[7]_i_2 
       (.I0(btnc_IBUF),
        .I1(cs[0]),
        .I2(cs[1]),
        .O(\count[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \count[7]_i_3 
       (.I0(count_reg[7]),
        .I1(count_reg[5]),
        .I2(\count[7]_i_4_n_0 ),
        .I3(count_reg[3]),
        .I4(count_reg[4]),
        .I5(count_reg[6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \count[7]_i_4 
       (.I0(count_reg[2]),
        .I1(count_reg[1]),
        .I2(count_reg[0]),
        .O(\count[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[0]),
        .Q(count_reg[0]),
        .R(resetCount4_out));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[1]),
        .Q(count_reg[1]),
        .R(resetCount4_out));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[2]),
        .Q(count_reg[2]),
        .R(resetCount4_out));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[3]),
        .Q(count_reg[3]),
        .R(resetCount4_out));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[4] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[4]),
        .Q(count_reg[4]),
        .R(resetCount4_out));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[5] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[5]),
        .Q(count_reg[5]),
        .R(resetCount4_out));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[6] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[6]),
        .Q(count_reg[6]),
        .R(resetCount4_out));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[7] 
       (.C(clk_100),
        .CE(\count[7]_i_2_n_0 ),
        .D(p_0_in__0[7]),
        .Q(count_reg[7]),
        .R(resetCount4_out));
  LUT6 #(
    .INIT(64'hFFFF7FFF00008000)) 
    erasing_i_1
       (.I0(\FSM_sequential_cs_reg[1]_1 [1]),
        .I1(lineDone),
        .I2(\FSM_sequential_cs_reg[1]_1 [0]),
        .I3(\count[7]_i_2_n_0 ),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(erasing),
        .O(\FSM_sequential_cs_reg[1]_0 ));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 lineDone_carry
       (.CI(\<const0> ),
        .CO({lineDone,lineDone_carry_n_2,lineDone_carry_n_3}),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\<const0> ,lineDone_carry_i_1_n_0,lineDone_carry_i_2_n_0,lineDone_carry_i_3_n_0}));
  LUT2 #(
    .INIT(4'h1)) 
    lineDone_carry_i_1
       (.I0(count_reg[6]),
        .I1(count_reg[7]),
        .O(lineDone_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h04)) 
    lineDone_carry_i_2
       (.I0(count_reg[3]),
        .I1(count_reg[5]),
        .I2(count_reg[4]),
        .O(lineDone_carry_i_2_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    lineDone_carry_i_3
       (.I0(count_reg[2]),
        .I1(count_reg[1]),
        .I2(count_reg[0]),
        .O(lineDone_carry_i_3_n_0));
  LUT5 #(
    .INIT(32'h51111555)) 
    ram_reg_0_0_i_1
       (.I0(\FSM_sequential_cs_reg[2] ),
        .I1(ram_reg_0_0),
        .I2(ram_reg_0_0_0),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(\ballY_reg[6] ));
  LUT6 #(
    .INIT(64'h2202020202222222)) 
    ram_reg_0_0_i_20
       (.I0(vga_wr_en),
        .I1(\FSM_sequential_cs_reg[2] ),
        .I2(ram_reg_0_0),
        .I3(ram_reg_0_0_0),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(WEA));
  LUT5 #(
    .INIT(32'h20232020)) 
    ram_reg_0_0_i_21
       (.I0(in16[7]),
        .I1(\FSM_sequential_cs_reg[1]_1 [2]),
        .I2(\FSM_sequential_cs_reg[1]_1 [0]),
        .I3(\FSM_sequential_cs_reg[1]_1 [1]),
        .I4(ram_reg_0_0_1[1]),
        .O(\FSM_sequential_cs_reg[2] ));
  LUT5 #(
    .INIT(32'h20232020)) 
    ram_reg_0_0_i_28
       (.I0(in16[2]),
        .I1(\FSM_sequential_cs_reg[1]_1 [2]),
        .I2(\FSM_sequential_cs_reg[1]_1 [0]),
        .I3(\FSM_sequential_cs_reg[1]_1 [1]),
        .I4(ram_reg_0_0_1[0]),
        .O(\FSM_sequential_cs_reg[2]_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAFFFFABAA)) 
    ram_reg_0_0_i_41
       (.I0(clearX),
        .I1(lineDone),
        .I2(ram_reg_0_0_i_43_n_0),
        .I3(ram_reg_1_2),
        .I4(ram_reg_1_2_0),
        .I5(btnc_IBUF),
        .O(vga_wr_en));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'hB)) 
    ram_reg_0_0_i_43
       (.I0(cs[1]),
        .I1(cs[0]),
        .O(ram_reg_0_0_i_43_n_0));
  LUT6 #(
    .INIT(64'h88A8A8A8A8888888)) 
    ram_reg_2_0_i_2
       (.I0(vga_wr_en),
        .I1(\FSM_sequential_cs_reg[2] ),
        .I2(ram_reg_0_0),
        .I3(ram_reg_0_0_0),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(\ballY_reg[6]_0 ));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    \timerCount[0]_i_1 
       (.I0(\FSM_sequential_cs_reg[1]_1 [1]),
        .I1(lineDone),
        .I2(\FSM_sequential_cs_reg[1]_1 [0]),
        .I3(\count[7]_i_2_n_0 ),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(erasing),
        .O(timerRst));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 y_out_carry
       (.CI(\<const0> ),
        .CO({y_out_carry_n_0,y_out_carry_n_1,y_out_carry_n_2,y_out_carry_n_3}),
        .CYINIT(\<const0> ),
        .DI(count_reg[3:0]),
        .O({\count_reg[6]_0 [2],in16[2],\count_reg[6]_0 [1:0]}),
        .S({y_out_carry_i_1_n_0,y_out_carry_i_2_n_0,y_out_carry_i_3_n_0,y_out_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 y_out_carry__0
       (.CI(y_out_carry_n_0),
        .CO({y_out_carry__0_n_1,y_out_carry__0_n_2,y_out_carry__0_n_3}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,count_reg[6:4]}),
        .O({in16[7],\count_reg[6]_0 [5:3]}),
        .S({y_out_carry__0_i_1_n_0,y_out_carry__0_i_2_n_0,y_out_carry__0_i_3_n_0,y_out_carry__0_i_4_n_0}));
  LUT6 #(
    .INIT(64'hAAAAAAAA656AAAAA)) 
    y_out_carry__0_i_1
       (.I0(count_reg[7]),
        .I1(y_out_carry__0_0[7]),
        .I2(\FSM_sequential_cs_reg[1]_1 [1]),
        .I3(y_out_carry__0_1[7]),
        .I4(\FSM_sequential_cs_reg[1]_1 [0]),
        .I5(\FSM_sequential_cs_reg[1]_1 [2]),
        .O(y_out_carry__0_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFF47FF0000B800)) 
    y_out_carry__0_i_2
       (.I0(y_out_carry__0_0[6]),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(y_out_carry__0_1[6]),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(count_reg[6]),
        .O(y_out_carry__0_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFF47FF0000B800)) 
    y_out_carry__0_i_3
       (.I0(y_out_carry__0_0[5]),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(y_out_carry__0_1[5]),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(count_reg[5]),
        .O(y_out_carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFF47FF0000B800)) 
    y_out_carry__0_i_4
       (.I0(y_out_carry__0_0[4]),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(y_out_carry__0_1[4]),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(count_reg[4]),
        .O(y_out_carry__0_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFF47FF0000B800)) 
    y_out_carry_i_1
       (.I0(y_out_carry__0_0[3]),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(y_out_carry__0_1[3]),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(count_reg[3]),
        .O(y_out_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFF47FF0000B800)) 
    y_out_carry_i_2
       (.I0(y_out_carry__0_0[2]),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(y_out_carry__0_1[2]),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(count_reg[2]),
        .O(y_out_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFF47FF0000B800)) 
    y_out_carry_i_3
       (.I0(y_out_carry__0_0[1]),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(y_out_carry__0_1[1]),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(count_reg[1]),
        .O(y_out_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFF47FF0000B800)) 
    y_out_carry_i_4
       (.I0(y_out_carry__0_0[0]),
        .I1(\FSM_sequential_cs_reg[1]_1 [1]),
        .I2(y_out_carry__0_1[0]),
        .I3(\FSM_sequential_cs_reg[1]_1 [0]),
        .I4(\FSM_sequential_cs_reg[1]_1 [2]),
        .I5(count_reg[0]),
        .O(y_out_carry_i_4_n_0));
endmodule

module VgaRam
   (VGA_B_OBUF,
    VGA_G_OBUF,
    VGA_R_OBUF,
    Q,
    clk_25,
    clk_100,
    ram_reg_0_0_0,
    ADDRARDADDR,
    ram_reg_3_2_0,
    vga_color,
    WEA,
    vga_y,
    ram_reg_2_0_0,
    \VGA_B[0] );
  output [0:0]VGA_B_OBUF;
  output [0:0]VGA_G_OBUF;
  output [0:0]VGA_R_OBUF;
  input [7:0]Q;
  input clk_25;
  input clk_100;
  input ram_reg_0_0_0;
  input [15:0]ADDRARDADDR;
  input [8:0]ram_reg_3_2_0;
  input [2:0]vga_color;
  input [0:0]WEA;
  input [0:0]vga_y;
  input [0:0]ram_reg_2_0_0;
  input \VGA_B[0] ;

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]ADDRARDADDR;
  wire [7:0]Q;
  wire \VGA_B[0] ;
  wire [0:0]VGA_B_OBUF;
  wire [0:0]VGA_G_OBUF;
  wire [0:0]VGA_R_OBUF;
  wire [0:0]WEA;
  wire clk_100;
  wire clk_25;
  wire ram_reg_0_0_0;
  wire ram_reg_0_0_i_2_n_0;
  wire ram_reg_0_0_n_0;
  wire ram_reg_0_0_n_1;
  wire ram_reg_0_1_n_0;
  wire ram_reg_0_1_n_1;
  wire ram_reg_0_2_n_0;
  wire ram_reg_0_2_n_1;
  wire ram_reg_1_0_n_67;
  wire ram_reg_1_1_n_67;
  wire ram_reg_1_2_n_67;
  wire [0:0]ram_reg_2_0_0;
  wire ram_reg_2_0_n_0;
  wire ram_reg_2_0_n_1;
  wire ram_reg_2_1_n_0;
  wire ram_reg_2_1_n_1;
  wire ram_reg_2_2_n_0;
  wire ram_reg_2_2_n_1;
  wire ram_reg_3_0_n_67;
  wire ram_reg_3_1_n_67;
  wire [8:0]ram_reg_3_2_0;
  wire ram_reg_3_2_n_67;
  wire ram_reg_mux_sel_b_pos_0__1_n_0;
  wire [2:0]vga_color;
  wire [0:0]vga_y;
  wire [3:0]NLW_ram_reg_0_0_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_0_0_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_0_1_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_0_1_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_0_2_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_0_2_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_1_0_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_1_0_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_1_1_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_1_1_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_1_2_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_1_2_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_2_0_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_2_0_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_2_1_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_2_1_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_2_2_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_2_2_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_3_0_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_3_0_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_3_1_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_3_1_DIPBDIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_3_2_DIPADIP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_3_2_DIPBDIP_UNCONNECTED;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \VGA_B_OBUF[3]_inst_i_1 
       (.I0(ram_reg_1_0_n_67),
        .I1(ram_reg_mux_sel_b_pos_0__1_n_0),
        .I2(ram_reg_3_0_n_67),
        .I3(\VGA_B[0] ),
        .O(VGA_B_OBUF));
  LUT4 #(
    .INIT(16'h00E2)) 
    \VGA_G_OBUF[3]_inst_i_1 
       (.I0(ram_reg_1_1_n_67),
        .I1(ram_reg_mux_sel_b_pos_0__1_n_0),
        .I2(ram_reg_3_1_n_67),
        .I3(\VGA_B[0] ),
        .O(VGA_G_OBUF));
  LUT4 #(
    .INIT(16'h00E2)) 
    \VGA_R_OBUF[3]_inst_i_1 
       (.I0(ram_reg_1_2_n_67),
        .I1(ram_reg_mux_sel_b_pos_0__1_n_0),
        .I2(ram_reg_3_2_n_67),
        .I3(\VGA_B[0] ),
        .O(VGA_R_OBUF));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_0_0" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "32767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("LOWER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_0_0
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const1> ),
        .CASCADEOUTA(ram_reg_0_0_n_0),
        .CASCADEOUTB(ram_reg_0_0_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[0]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_0_0_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_0_0_DIPBDIP_UNCONNECTED[0]}),
        .ENARDEN(ram_reg_0_0_0),
        .ENBWREN(ram_reg_0_0_i_2_n_0),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({WEA,WEA,WEA,WEA}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  LUT1 #(
    .INIT(2'h1)) 
    ram_reg_0_0_i_2
       (.I0(Q[7]),
        .O(ram_reg_0_0_i_2_n_0));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_0_1" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "32767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("LOWER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_0_1
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const1> ),
        .CASCADEOUTA(ram_reg_0_1_n_0),
        .CASCADEOUTB(ram_reg_0_1_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[1]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_0_1_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_0_1_DIPBDIP_UNCONNECTED[0]}),
        .ENARDEN(ram_reg_0_0_0),
        .ENBWREN(ram_reg_0_0_i_2_n_0),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({WEA,WEA,WEA,WEA}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_0_2" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "32767" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("LOWER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_0_2
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const1> ),
        .CASCADEOUTA(ram_reg_0_2_n_0),
        .CASCADEOUTB(ram_reg_0_2_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[2]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_0_2_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_0_2_DIPBDIP_UNCONNECTED[0]}),
        .ENARDEN(ram_reg_0_0_0),
        .ENBWREN(ram_reg_0_0_i_2_n_0),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({WEA,WEA,WEA,WEA}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_1_0" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "32768" *) 
  (* ram_addr_end = "65535" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("UPPER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_1_0
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(ram_reg_0_0_n_0),
        .CASCADEINB(ram_reg_0_0_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[0]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_1_0_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_1_0_DIPBDIP_UNCONNECTED[0]}),
        .DOBDO(ram_reg_1_0_n_67),
        .ENARDEN(ram_reg_0_0_0),
        .ENBWREN(ram_reg_0_0_i_2_n_0),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({WEA,WEA,WEA,WEA}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_1_1" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "32768" *) 
  (* ram_addr_end = "65535" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("UPPER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_1_1
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(ram_reg_0_1_n_0),
        .CASCADEINB(ram_reg_0_1_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[1]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_1_1_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_1_1_DIPBDIP_UNCONNECTED[0]}),
        .DOBDO(ram_reg_1_1_n_67),
        .ENARDEN(ram_reg_0_0_0),
        .ENBWREN(ram_reg_0_0_i_2_n_0),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({WEA,WEA,WEA,WEA}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_1_2" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "32768" *) 
  (* ram_addr_end = "65535" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("UPPER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_1_2
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(ram_reg_0_2_n_0),
        .CASCADEINB(ram_reg_0_2_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[2]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_1_2_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_1_2_DIPBDIP_UNCONNECTED[0]}),
        .DOBDO(ram_reg_1_2_n_67),
        .ENARDEN(ram_reg_0_0_0),
        .ENBWREN(ram_reg_0_0_i_2_n_0),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({WEA,WEA,WEA,WEA}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_2_0" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "65536" *) 
  (* ram_addr_end = "98303" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("LOWER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_2_0
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const1> ),
        .CASCADEOUTA(ram_reg_2_0_n_0),
        .CASCADEOUTB(ram_reg_2_0_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[0]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_2_0_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_2_0_DIPBDIP_UNCONNECTED[0]}),
        .ENARDEN(vga_y),
        .ENBWREN(Q[7]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_2_1" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "65536" *) 
  (* ram_addr_end = "98303" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("LOWER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_2_1
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const1> ),
        .CASCADEOUTA(ram_reg_2_1_n_0),
        .CASCADEOUTB(ram_reg_2_1_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[1]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_2_1_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_2_1_DIPBDIP_UNCONNECTED[0]}),
        .ENARDEN(vga_y),
        .ENBWREN(Q[7]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_2_2" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "65536" *) 
  (* ram_addr_end = "98303" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("LOWER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_2_2
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const1> ),
        .CASCADEOUTA(ram_reg_2_2_n_0),
        .CASCADEOUTB(ram_reg_2_2_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[2]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_2_2_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_2_2_DIPBDIP_UNCONNECTED[0]}),
        .ENARDEN(vga_y),
        .ENBWREN(Q[7]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_3_0" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "98304" *) 
  (* ram_addr_end = "131071" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "0" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("UPPER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_3_0
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(ram_reg_2_0_n_0),
        .CASCADEINB(ram_reg_2_0_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[0]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_3_0_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_3_0_DIPBDIP_UNCONNECTED[0]}),
        .DOBDO(ram_reg_3_0_n_67),
        .ENARDEN(vga_y),
        .ENBWREN(Q[7]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_3_1" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "98304" *) 
  (* ram_addr_end = "131071" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "1" *) 
  (* ram_slice_end = "1" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("UPPER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_3_1
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(ram_reg_2_1_n_0),
        .CASCADEINB(ram_reg_2_1_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[1]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_3_1_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_3_1_DIPBDIP_UNCONNECTED[0]}),
        .DOBDO(ram_reg_3_1_n_67),
        .ENARDEN(vga_y),
        .ENBWREN(Q[7]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d1" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "368640" *) 
  (* RTL_RAM_NAME = "BitmapToVga_inst/VgaRam_inst/ram_reg_3_2" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "98304" *) 
  (* ram_addr_end = "131071" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "2" *) 
  (* ram_slice_end = "2" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("UPPER"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    ram_reg_3_2
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR({Q[6:0],ram_reg_3_2_0}),
        .CASCADEINA(ram_reg_2_2_n_0),
        .CASCADEINB(ram_reg_2_2_n_1),
        .CLKARDCLK(clk_100),
        .CLKBWRCLK(clk_25),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,vga_color[2]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_3_2_DIPADIP_UNCONNECTED[0]}),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,NLW_ram_reg_3_2_DIPBDIP_UNCONNECTED[0]}),
        .DOBDO(ram_reg_3_2_n_67),
        .ENARDEN(vga_y),
        .ENBWREN(Q[7]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0,ram_reg_2_0_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  FDRE #(
    .INIT(1'b0)) 
    ram_reg_mux_sel_b_pos_0__1
       (.C(clk_25),
        .CE(\<const1> ),
        .D(Q[7]),
        .Q(ram_reg_mux_sel_b_pos_0__1_n_0),
        .R(\<const0> ));
endmodule

module clk_generator
   (clk_100,
    clk_25,
    clk);
  output clk_100;
  output clk_25;
  input clk;

  wire \<const0> ;
  wire \<const1> ;
  wire clk;
  wire clk_100;
  wire clk_100_clk_generator;
  wire clk_25;
  wire clk_25_clk_generator;
  wire clk_in1_clk_generator;
  wire clkfbout_buf_clk_generator;
  wire clkfbout_clk_generator;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkf_buf
       (.I(clkfbout_clk_generator),
        .O(clkfbout_buf_clk_generator));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUF #(
    .IOSTANDARD("DEFAULT")) 
    clkin1_ibufg
       (.I(clk),
        .O(clk_in1_clk_generator));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout1_buf
       (.I(clk_100_clk_generator),
        .O(clk_100));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout2_buf
       (.I(clk_25_clk_generator),
        .O(clk_25));
  (* BOX_TYPE = "PRIMITIVE" *) 
  PLLE2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(9),
    .CLKFBOUT_PHASE(0.000000),
    .CLKIN1_PERIOD(10.000000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE(9),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT1_DIVIDE(36),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.010000),
    .REF_JITTER2(0.010000),
    .STARTUP_WAIT("FALSE")) 
    plle2_adv_inst
       (.CLKFBIN(clkfbout_buf_clk_generator),
        .CLKFBOUT(clkfbout_clk_generator),
        .CLKIN1(clk_in1_clk_generator),
        .CLKIN2(\<const0> ),
        .CLKINSEL(\<const1> ),
        .CLKOUT0(clk_100_clk_generator),
        .CLKOUT1(clk_25_clk_generator),
        .DADDR({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .DCLK(\<const0> ),
        .DEN(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .DWE(\<const0> ),
        .PWRDWN(\<const0> ),
        .RST(\<const0> ));
endmodule

(* STRUCTURAL_NETLIST = "yes" *)
module top_pong
   (clk,
    btnc,
    VGA_R,
    VGA_G,
    VGA_B,
    VGA_HS,
    VGA_VS,
    anode,
    segment,
    btnu,
    btnd,
    btnl,
    btnr);
  input clk;
  input btnc;
  output [3:0]VGA_R;
  output [3:0]VGA_G;
  output [3:0]VGA_B;
  output VGA_HS;
  output VGA_VS;
  output [3:0]anode;
  output [7:0]segment;
  input btnu;
  input btnd;
  input btnl;
  input btnr;

  wire Pong_inst_n_0;
  wire Pong_inst_n_1;
  wire Pong_inst_n_29;
  wire [3:0]VGA_B;
  wire [0:0]VGA_B_OBUF;
  wire [3:0]VGA_G;
  wire [0:0]VGA_G_OBUF;
  wire VGA_HS;
  wire VGA_HS_OBUF;
  wire [3:0]VGA_R;
  wire [0:0]VGA_R_OBUF;
  wire VGA_VS;
  wire VGA_VS_OBUF;
  wire [3:0]anode;
  wire [3:0]anode_OBUF;
  wire [1:0]anode_select;
  wire btnc;
  wire btnc_IBUF;
  wire btnd;
  wire btnd_IBUF;
  wire btnl;
  wire btnl_IBUF;
  wire btnr;
  wire btnr_IBUF;
  wire btnu;
  wire btnu_IBUF;
  (* IBUF_LOW_PWR *) wire clk;
  wire clk_100;
  wire clk_25;
  wire [7:0]segment;
  wire [7:0]segment_OBUF;
  wire [2:0]vga_color;
  wire [8:0]vga_x;
  wire [7:0]vga_y;

  BitmapToVga BitmapToVga_inst
       (.ADDRARDADDR({vga_y[6:0],vga_x}),
        .VGA_B_OBUF(VGA_B_OBUF),
        .VGA_G_OBUF(VGA_G_OBUF),
        .VGA_HS_OBUF(VGA_HS_OBUF),
        .VGA_R_OBUF(VGA_R_OBUF),
        .VGA_VS_OBUF(VGA_VS_OBUF),
        .WEA(Pong_inst_n_29),
        .btnc_IBUF(btnc_IBUF),
        .clk_100(clk_100),
        .clk_25(clk_25),
        .ram_reg_0_0(Pong_inst_n_0),
        .ram_reg_2_0(Pong_inst_n_1),
        .vga_color(vga_color),
        .vga_y(vga_y[7]));
  Pong Pong_inst
       (.ADDRARDADDR({vga_y[6:0],vga_x}),
        .WEA(Pong_inst_n_29),
        .anode_select(anode_select),
        .\ballY_reg[6]_0 (Pong_inst_n_0),
        .\ballY_reg[6]_1 (Pong_inst_n_1),
        .btnc_IBUF(btnc_IBUF),
        .btnd_IBUF(btnd_IBUF),
        .btnl_IBUF(btnl_IBUF),
        .btnr_IBUF(btnr_IBUF),
        .btnu_IBUF(btnu_IBUF),
        .clk_100(clk_100),
        .segment_OBUF(segment_OBUF[6:0]),
        .vga_color(vga_color),
        .vga_y(vga_y[7]));
  SevenSegmentControl SSC
       (.anode_OBUF({anode_OBUF[3],anode_OBUF[1:0]}),
        .anode_select(anode_select),
        .btnc_IBUF(btnc_IBUF),
        .clk_100(clk_100),
        .segment_OBUF(segment_OBUF[7]));
  OBUF \VGA_B_OBUF[0]_inst 
       (.I(VGA_B_OBUF),
        .O(VGA_B[0]));
  OBUF \VGA_B_OBUF[1]_inst 
       (.I(VGA_B_OBUF),
        .O(VGA_B[1]));
  OBUF \VGA_B_OBUF[2]_inst 
       (.I(VGA_B_OBUF),
        .O(VGA_B[2]));
  OBUF \VGA_B_OBUF[3]_inst 
       (.I(VGA_B_OBUF),
        .O(VGA_B[3]));
  OBUF \VGA_G_OBUF[0]_inst 
       (.I(VGA_G_OBUF),
        .O(VGA_G[0]));
  OBUF \VGA_G_OBUF[1]_inst 
       (.I(VGA_G_OBUF),
        .O(VGA_G[1]));
  OBUF \VGA_G_OBUF[2]_inst 
       (.I(VGA_G_OBUF),
        .O(VGA_G[2]));
  OBUF \VGA_G_OBUF[3]_inst 
       (.I(VGA_G_OBUF),
        .O(VGA_G[3]));
  OBUF VGA_HS_OBUF_inst
       (.I(VGA_HS_OBUF),
        .O(VGA_HS));
  OBUF \VGA_R_OBUF[0]_inst 
       (.I(VGA_R_OBUF),
        .O(VGA_R[0]));
  OBUF \VGA_R_OBUF[1]_inst 
       (.I(VGA_R_OBUF),
        .O(VGA_R[1]));
  OBUF \VGA_R_OBUF[2]_inst 
       (.I(VGA_R_OBUF),
        .O(VGA_R[2]));
  OBUF \VGA_R_OBUF[3]_inst 
       (.I(VGA_R_OBUF),
        .O(VGA_R[3]));
  OBUF VGA_VS_OBUF_inst
       (.I(VGA_VS_OBUF),
        .O(VGA_VS));
  OBUF \anode_OBUF[0]_inst 
       (.I(anode_OBUF[0]),
        .O(anode[0]));
  OBUF \anode_OBUF[1]_inst 
       (.I(anode_OBUF[1]),
        .O(anode[1]));
  OBUF \anode_OBUF[2]_inst 
       (.I(segment_OBUF[7]),
        .O(anode[2]));
  OBUF \anode_OBUF[3]_inst 
       (.I(anode_OBUF[3]),
        .O(anode[3]));
  IBUF btnc_IBUF_inst
       (.I(btnc),
        .O(btnc_IBUF));
  IBUF btnd_IBUF_inst
       (.I(btnd),
        .O(btnd_IBUF));
  IBUF btnl_IBUF_inst
       (.I(btnl),
        .O(btnl_IBUF));
  IBUF btnr_IBUF_inst
       (.I(btnr),
        .O(btnr_IBUF));
  IBUF btnu_IBUF_inst
       (.I(btnu),
        .O(btnu_IBUF));
  clk_generator clk_generator_inst
       (.clk(clk),
        .clk_100(clk_100),
        .clk_25(clk_25));
  OBUF \segment_OBUF[0]_inst 
       (.I(segment_OBUF[0]),
        .O(segment[0]));
  OBUF \segment_OBUF[1]_inst 
       (.I(segment_OBUF[1]),
        .O(segment[1]));
  OBUF \segment_OBUF[2]_inst 
       (.I(segment_OBUF[2]),
        .O(segment[2]));
  OBUF \segment_OBUF[3]_inst 
       (.I(segment_OBUF[3]),
        .O(segment[3]));
  OBUF \segment_OBUF[4]_inst 
       (.I(segment_OBUF[4]),
        .O(segment[4]));
  OBUF \segment_OBUF[5]_inst 
       (.I(segment_OBUF[5]),
        .O(segment[5]));
  OBUF \segment_OBUF[6]_inst 
       (.I(segment_OBUF[6]),
        .O(segment[6]));
  OBUF \segment_OBUF[7]_inst 
       (.I(segment_OBUF[7]),
        .O(segment[7]));
endmodule
