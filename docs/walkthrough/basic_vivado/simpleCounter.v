// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Fri Jul 22 14:59:44 2022
// Host        : CB459-EE11769 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog /home/emonlux/Downloads/project_1.v
// Design      : simpleCounter
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module debounceCounter
   (\FSM_sequential_cs_reg[1]_0 ,
    clk_IBUF_BUFG,
    btnu_IBUF,
    f2);
  output \FSM_sequential_cs_reg[1]_0 ;
  input clk_IBUF_BUFG;
  input btnu_IBUF;
  input f2;

  wire \<const0> ;
  wire \<const1> ;
  wire \FSM_sequential_cs[0]_i_1_n_0 ;
  wire \FSM_sequential_cs[1]_i_1_n_0 ;
  wire \FSM_sequential_cs[1]_i_3_n_0 ;
  wire \FSM_sequential_cs[1]_i_4_n_0 ;
  wire \FSM_sequential_cs[1]_i_5_n_0 ;
  wire \FSM_sequential_cs[1]_i_6_n_0 ;
  wire \FSM_sequential_cs_reg[1]_0 ;
  wire \FSM_sequential_cs_reg_n_0_[1] ;
  wire btnu_IBUF;
  wire clk_IBUF_BUFG;
  wire \count[0]_i_1_n_0 ;
  wire \count[0]_i_3_n_0 ;
  wire [18:0]count_reg;
  wire \count_reg[0]_i_2_n_0 ;
  wire \count_reg[0]_i_2_n_1 ;
  wire \count_reg[0]_i_2_n_2 ;
  wire \count_reg[0]_i_2_n_3 ;
  wire \count_reg[0]_i_2_n_4 ;
  wire \count_reg[0]_i_2_n_5 ;
  wire \count_reg[0]_i_2_n_6 ;
  wire \count_reg[0]_i_2_n_7 ;
  wire \count_reg[12]_i_1_n_0 ;
  wire \count_reg[12]_i_1_n_1 ;
  wire \count_reg[12]_i_1_n_2 ;
  wire \count_reg[12]_i_1_n_3 ;
  wire \count_reg[12]_i_1_n_4 ;
  wire \count_reg[12]_i_1_n_5 ;
  wire \count_reg[12]_i_1_n_6 ;
  wire \count_reg[12]_i_1_n_7 ;
  wire \count_reg[16]_i_1_n_2 ;
  wire \count_reg[16]_i_1_n_3 ;
  wire \count_reg[16]_i_1_n_5 ;
  wire \count_reg[16]_i_1_n_6 ;
  wire \count_reg[16]_i_1_n_7 ;
  wire \count_reg[4]_i_1_n_0 ;
  wire \count_reg[4]_i_1_n_1 ;
  wire \count_reg[4]_i_1_n_2 ;
  wire \count_reg[4]_i_1_n_3 ;
  wire \count_reg[4]_i_1_n_4 ;
  wire \count_reg[4]_i_1_n_5 ;
  wire \count_reg[4]_i_1_n_6 ;
  wire \count_reg[4]_i_1_n_7 ;
  wire \count_reg[8]_i_1_n_0 ;
  wire \count_reg[8]_i_1_n_1 ;
  wire \count_reg[8]_i_1_n_2 ;
  wire \count_reg[8]_i_1_n_3 ;
  wire \count_reg[8]_i_1_n_4 ;
  wire \count_reg[8]_i_1_n_5 ;
  wire \count_reg[8]_i_1_n_6 ;
  wire \count_reg[8]_i_1_n_7 ;
  wire [0:0]cs;
  wire f2;
  wire timerDone__17;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00000666)) 
    \FSM_sequential_cs[0]_i_1 
       (.I0(f2),
        .I1(\FSM_sequential_cs_reg_n_0_[1] ),
        .I2(cs),
        .I3(timerDone__17),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0000BF80)) 
    \FSM_sequential_cs[1]_i_1 
       (.I0(f2),
        .I1(timerDone__17),
        .I2(cs),
        .I3(\FSM_sequential_cs_reg_n_0_[1] ),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \FSM_sequential_cs[1]_i_2 
       (.I0(\FSM_sequential_cs[1]_i_3_n_0 ),
        .I1(\FSM_sequential_cs[1]_i_4_n_0 ),
        .I2(\FSM_sequential_cs[1]_i_5_n_0 ),
        .I3(\FSM_sequential_cs[1]_i_6_n_0 ),
        .O(timerDone__17));
  LUT5 #(
    .INIT(32'hFFFFFFFB)) 
    \FSM_sequential_cs[1]_i_3 
       (.I0(count_reg[6]),
        .I1(count_reg[17]),
        .I2(count_reg[5]),
        .I3(count_reg[9]),
        .I4(count_reg[7]),
        .O(\FSM_sequential_cs[1]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_cs[1]_i_4 
       (.I0(count_reg[14]),
        .I1(count_reg[12]),
        .I2(count_reg[11]),
        .I3(count_reg[10]),
        .O(\FSM_sequential_cs[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_sequential_cs[1]_i_5 
       (.I0(count_reg[8]),
        .I1(count_reg[13]),
        .I2(count_reg[15]),
        .I3(count_reg[18]),
        .I4(count_reg[16]),
        .O(\FSM_sequential_cs[1]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_sequential_cs[1]_i_6 
       (.I0(count_reg[0]),
        .I1(count_reg[1]),
        .I2(count_reg[2]),
        .I3(count_reg[4]),
        .I4(count_reg[3]),
        .O(\FSM_sequential_cs[1]_i_6_n_0 ));
  (* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_cs_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[0]_i_1_n_0 ),
        .Q(cs),
        .R(\<const0> ));
  (* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_cs_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[1]_i_1_n_0 ),
        .Q(\FSM_sequential_cs_reg_n_0_[1] ),
        .R(\<const0> ));
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT2 #(
    .INIT(4'h1)) 
    \count[0]_i_1 
       (.I0(btnu_IBUF),
        .I1(cs),
        .O(\count[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_3 
       (.I0(count_reg[0]),
        .O(\count[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_7 ),
        .Q(count_reg[0]),
        .R(\count[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_reg[0]_i_2 
       (.CI(\<const0> ),
        .CO({\count_reg[0]_i_2_n_0 ,\count_reg[0]_i_2_n_1 ,\count_reg[0]_i_2_n_2 ,\count_reg[0]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\count_reg[0]_i_2_n_4 ,\count_reg[0]_i_2_n_5 ,\count_reg[0]_i_2_n_6 ,\count_reg[0]_i_2_n_7 }),
        .S({count_reg[3:1],\count[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_5 ),
        .Q(count_reg[10]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_4 ),
        .Q(count_reg[11]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_7 ),
        .Q(count_reg[12]),
        .R(\count[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_reg[12]_i_1 
       (.CI(\count_reg[8]_i_1_n_0 ),
        .CO({\count_reg[12]_i_1_n_0 ,\count_reg[12]_i_1_n_1 ,\count_reg[12]_i_1_n_2 ,\count_reg[12]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_reg[12]_i_1_n_4 ,\count_reg[12]_i_1_n_5 ,\count_reg[12]_i_1_n_6 ,\count_reg[12]_i_1_n_7 }),
        .S(count_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_6 ),
        .Q(count_reg[13]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_5 ),
        .Q(count_reg[14]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_4 ),
        .Q(count_reg[15]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_7 ),
        .Q(count_reg[16]),
        .R(\count[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_reg[16]_i_1 
       (.CI(\count_reg[12]_i_1_n_0 ),
        .CO({\count_reg[16]_i_1_n_2 ,\count_reg[16]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_reg[16]_i_1_n_5 ,\count_reg[16]_i_1_n_6 ,\count_reg[16]_i_1_n_7 }),
        .S({\<const0> ,count_reg[18:16]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_6 ),
        .Q(count_reg[17]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_5 ),
        .Q(count_reg[18]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_6 ),
        .Q(count_reg[1]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_5 ),
        .Q(count_reg[2]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_4 ),
        .Q(count_reg[3]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_7 ),
        .Q(count_reg[4]),
        .R(\count[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_reg[4]_i_1 
       (.CI(\count_reg[0]_i_2_n_0 ),
        .CO({\count_reg[4]_i_1_n_0 ,\count_reg[4]_i_1_n_1 ,\count_reg[4]_i_1_n_2 ,\count_reg[4]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_reg[4]_i_1_n_4 ,\count_reg[4]_i_1_n_5 ,\count_reg[4]_i_1_n_6 ,\count_reg[4]_i_1_n_7 }),
        .S(count_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_6 ),
        .Q(count_reg[5]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_5 ),
        .Q(count_reg[6]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_4 ),
        .Q(count_reg[7]),
        .R(\count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_7 ),
        .Q(count_reg[8]),
        .R(\count[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \count_reg[8]_i_1 
       (.CI(\count_reg[4]_i_1_n_0 ),
        .CO({\count_reg[8]_i_1_n_0 ,\count_reg[8]_i_1_n_1 ,\count_reg[8]_i_1_n_2 ,\count_reg[8]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\count_reg[8]_i_1_n_4 ,\count_reg[8]_i_1_n_5 ,\count_reg[8]_i_1_n_6 ,\count_reg[8]_i_1_n_7 }),
        .S(count_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_6 ),
        .Q(count_reg[9]),
        .R(\count[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    one_shot_1_i_1
       (.I0(\FSM_sequential_cs_reg_n_0_[1] ),
        .I1(btnu_IBUF),
        .O(\FSM_sequential_cs_reg[1]_0 ));
endmodule

(* STRUCTURAL_NETLIST = "yes" *)
module simpleCounter
   (clk,
    btnu,
    btnc,
    led);
  input clk;
  input btnu;
  input btnc;
  output [3:0]led;

  wire \<const0> ;
  wire \<const1> ;
  wire btnc;
  wire btnc_IBUF;
  wire btnu;
  wire btnu_IBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire enable;
  wire f1;
  wire f2;
  wire [3:0]led;
  wire [3:0]led_OBUF;
  wire my_debounceCounter_n_0;
  wire one_shot_1;
  wire one_shot_2;
  wire [3:0]p_0_in;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  IBUF btnc_IBUF_inst
       (.I(btnc),
        .O(btnc_IBUF));
  IBUF btnu_IBUF_inst
       (.I(btnu),
        .O(btnu_IBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    f1_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(btnc_IBUF),
        .Q(f1),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    f2_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(f1),
        .Q(f2),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \led[0]_i_1 
       (.I0(led_OBUF[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \led[1]_i_1 
       (.I0(led_OBUF[0]),
        .I1(led_OBUF[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \led[2]_i_1 
       (.I0(led_OBUF[0]),
        .I1(led_OBUF[1]),
        .I2(led_OBUF[2]),
        .O(p_0_in[2]));
  LUT2 #(
    .INIT(4'h2)) 
    \led[3]_i_1 
       (.I0(one_shot_1),
        .I1(one_shot_2),
        .O(enable));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \led[3]_i_2 
       (.I0(led_OBUF[1]),
        .I1(led_OBUF[0]),
        .I2(led_OBUF[2]),
        .I3(led_OBUF[3]),
        .O(p_0_in[3]));
  OBUF \led_OBUF[0]_inst 
       (.I(led_OBUF[0]),
        .O(led[0]));
  OBUF \led_OBUF[1]_inst 
       (.I(led_OBUF[1]),
        .O(led[1]));
  OBUF \led_OBUF[2]_inst 
       (.I(led_OBUF[2]),
        .O(led[2]));
  OBUF \led_OBUF[3]_inst 
       (.I(led_OBUF[3]),
        .O(led[3]));
  FDRE #(
    .INIT(1'b0)) 
    \led_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(enable),
        .D(p_0_in[0]),
        .Q(led_OBUF[0]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \led_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(enable),
        .D(p_0_in[1]),
        .Q(led_OBUF[1]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \led_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(enable),
        .D(p_0_in[2]),
        .Q(led_OBUF[2]),
        .R(btnu_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \led_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(enable),
        .D(p_0_in[3]),
        .Q(led_OBUF[3]),
        .R(btnu_IBUF));
  debounceCounter my_debounceCounter
       (.\FSM_sequential_cs_reg[1]_0 (my_debounceCounter_n_0),
        .btnu_IBUF(btnu_IBUF),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .f2(f2));
  FDRE #(
    .INIT(1'b0)) 
    one_shot_1_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(my_debounceCounter_n_0),
        .Q(one_shot_1),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    one_shot_2_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(one_shot_1),
        .Q(one_shot_2),
        .R(\<const0> ));
endmodule
