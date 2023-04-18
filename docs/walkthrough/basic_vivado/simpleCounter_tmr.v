//Generated from netlist by SpyDrNet
//netlist name: SDN_VERILOG_NETLIST_simpleCounter
(* STRUCTURAL_NETLIST = "yes" *)
module simpleCounter
(
    clk,
    btnu,
    btnc,
    led_TMR_0,
    led_TMR_1,
    led_TMR_2
);

    input clk;
    input btnu;
    input btnc;
    output [3:0]led_TMR_0;
    output [3:0]led_TMR_1;
    output [3:0]led_TMR_2;

    wire one_shot_2_reg_TMR_2_Q_VOTER;
    wire one_shot_2_reg_TMR_1_Q_VOTER;
    wire one_shot_2_reg_TMR_0_Q_VOTER;
    wire one_shot_1_reg_TMR_2_Q_VOTER;
    wire one_shot_1_reg_TMR_1_Q_VOTER;
    wire one_shot_1_reg_TMR_0_Q_VOTER;
    wire \led_reg_TMR_2[2]_Q_VOTER ;
    wire \led_reg_TMR_1[2]_Q_VOTER ;
    wire \led_reg_TMR_0[2]_Q_VOTER ;
    wire f1_reg_TMR_2_Q_VOTER;
    wire f1_reg_TMR_1_Q_VOTER;
    wire f1_reg_TMR_0_Q_VOTER;
    wire \led_reg_TMR_2[1]_Q_VOTER ;
    wire \led_reg_TMR_1[1]_Q_VOTER ;
    wire \led_reg_TMR_0[1]_Q_VOTER ;
    wire \led_reg_TMR_2[0]_Q_VOTER ;
    wire \led_reg_TMR_1[0]_Q_VOTER ;
    wire \led_reg_TMR_0[0]_Q_VOTER ;
    wire \led_reg_TMR_2[3]_Q_VOTER ;
    wire \led_reg_TMR_1[3]_Q_VOTER ;
    wire \led_reg_TMR_0[3]_Q_VOTER ;
    wire f2_reg_TMR_2_Q_VOTER;
    wire f2_reg_TMR_1_Q_VOTER;
    wire f2_reg_TMR_0_Q_VOTER;
    wire [3:0]p_0_in_TMR_2;
    wire [3:0]p_0_in_TMR_1;
    wire [3:0]p_0_in_TMR_0;
    wire one_shot_2_TMR_2;
    wire one_shot_2_TMR_1;
    wire one_shot_2_TMR_0;
    wire one_shot_1_TMR_2;
    wire one_shot_1_TMR_1;
    wire one_shot_1_TMR_0;
    wire my_debounceCounter_n_0_TMR_2;
    wire my_debounceCounter_n_0_TMR_1;
    wire my_debounceCounter_n_0_TMR_0;
    wire [3:0]led_OBUF_TMR_2;
    wire [3:0]led_OBUF_TMR_1;
    wire [3:0]led_OBUF_TMR_0;
    wire f2_TMR_2;
    wire f2_TMR_1;
    wire f2_TMR_0;
    wire f1_TMR_2;
    wire f1_TMR_1;
    wire f1_TMR_0;
    wire enable_TMR_2;
    wire enable_TMR_1;
    wire enable_TMR_0;
    wire clk_IBUF_BUFG;
    wire clk_IBUF;
    wire btnu_IBUF;
    wire btnc_IBUF;
    wire \<const1> ;
    wire \<const0> ;
    wire [3:0]led_TMR_2;
    wire [3:0]led_TMR_1;
    wire [3:0]led_TMR_0;
    wire btnc;
    wire btnu;
    wire clk;

    GND GND
    (
        .G(\<const0> )
    );
    VCC VCC
    (
        .P(\<const1> )
    );
    IBUF btnc_IBUF_inst
    (
        .I(btnc),
        .O(btnc_IBUF)
    );
    IBUF btnu_IBUF_inst
    (
        .I(btnu),
        .O(btnu_IBUF)
    );
    BUFG clk_IBUF_BUFG_inst
    (
        .I(clk_IBUF),
        .O(clk_IBUF_BUFG)
    );
    IBUF clk_IBUF_inst
    (
        .I(clk),
        .O(clk_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    f1_reg_TMR_0
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(btnc_IBUF),
        .Q(f1_reg_TMR_0_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    f1_reg_TMR_1
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(btnc_IBUF),
        .Q(f1_reg_TMR_1_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    f1_reg_TMR_2
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(btnc_IBUF),
        .Q(f1_reg_TMR_2_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    f2_reg_TMR_0
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(f1_TMR_0),
        .Q(f2_reg_TMR_0_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    f2_reg_TMR_1
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(f1_TMR_1),
        .Q(f2_reg_TMR_1_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    f2_reg_TMR_2
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(f1_TMR_2),
        .Q(f2_reg_TMR_2_Q_VOTER),
        .R(\<const0> )
    );
(* SOFT_HLUTNM = "soft_lutpair2" *)
    LUT1 #(
        .INIT(2'h1)
    )
    \led[0]_i_1_TMR_0 
    (
        .I0(led_OBUF_TMR_0[0]),
        .O(p_0_in_TMR_0[0])
    );
(* SOFT_HLUTNM = "soft_lutpair2" *)
    LUT1 #(
        .INIT(2'h1)
    )
    \led[0]_i_1_TMR_1 
    (
        .I0(led_OBUF_TMR_1[0]),
        .O(p_0_in_TMR_1[0])
    );
(* SOFT_HLUTNM = "soft_lutpair2" *)
    LUT1 #(
        .INIT(2'h1)
    )
    \led[0]_i_1_TMR_2 
    (
        .I0(led_OBUF_TMR_2[0]),
        .O(p_0_in_TMR_2[0])
    );
(* SOFT_HLUTNM = "soft_lutpair2" *)
    LUT2 #(
        .INIT(4'h6)
    )
    \led[1]_i_1_TMR_0 
    (
        .I0(led_OBUF_TMR_0[0]),
        .I1(led_OBUF_TMR_0[1]),
        .O(p_0_in_TMR_0[1])
    );
(* SOFT_HLUTNM = "soft_lutpair2" *)
    LUT2 #(
        .INIT(4'h6)
    )
    \led[1]_i_1_TMR_1 
    (
        .I0(led_OBUF_TMR_1[0]),
        .I1(led_OBUF_TMR_1[1]),
        .O(p_0_in_TMR_1[1])
    );
(* SOFT_HLUTNM = "soft_lutpair2" *)
    LUT2 #(
        .INIT(4'h6)
    )
    \led[1]_i_1_TMR_2 
    (
        .I0(led_OBUF_TMR_2[0]),
        .I1(led_OBUF_TMR_2[1]),
        .O(p_0_in_TMR_2[1])
    );
(* SOFT_HLUTNM = "soft_lutpair1" *)
    LUT3 #(
        .INIT(8'h78)
    )
    \led[2]_i_1_TMR_0 
    (
        .I0(led_OBUF_TMR_0[0]),
        .I1(led_OBUF_TMR_0[1]),
        .I2(led_OBUF_TMR_0[2]),
        .O(p_0_in_TMR_0[2])
    );
(* SOFT_HLUTNM = "soft_lutpair1" *)
    LUT3 #(
        .INIT(8'h78)
    )
    \led[2]_i_1_TMR_1 
    (
        .I0(led_OBUF_TMR_1[0]),
        .I1(led_OBUF_TMR_1[1]),
        .I2(led_OBUF_TMR_1[2]),
        .O(p_0_in_TMR_1[2])
    );
(* SOFT_HLUTNM = "soft_lutpair1" *)
    LUT3 #(
        .INIT(8'h78)
    )
    \led[2]_i_1_TMR_2 
    (
        .I0(led_OBUF_TMR_2[0]),
        .I1(led_OBUF_TMR_2[1]),
        .I2(led_OBUF_TMR_2[2]),
        .O(p_0_in_TMR_2[2])
    );
    LUT2 #(
        .INIT(4'h2)
    )
    \led[3]_i_1_TMR_0 
    (
        .I0(one_shot_1_TMR_0),
        .I1(one_shot_2_TMR_0),
        .O(enable_TMR_0)
    );
    LUT2 #(
        .INIT(4'h2)
    )
    \led[3]_i_1_TMR_1 
    (
        .I0(one_shot_1_TMR_1),
        .I1(one_shot_2_TMR_1),
        .O(enable_TMR_1)
    );
    LUT2 #(
        .INIT(4'h2)
    )
    \led[3]_i_1_TMR_2 
    (
        .I0(one_shot_1_TMR_2),
        .I1(one_shot_2_TMR_2),
        .O(enable_TMR_2)
    );
(* SOFT_HLUTNM = "soft_lutpair1" *)
    LUT4 #(
        .INIT(16'h7F80)
    )
    \led[3]_i_2_TMR_0 
    (
        .I0(led_OBUF_TMR_0[1]),
        .I1(led_OBUF_TMR_0[0]),
        .I2(led_OBUF_TMR_0[2]),
        .I3(led_OBUF_TMR_0[3]),
        .O(p_0_in_TMR_0[3])
    );
(* SOFT_HLUTNM = "soft_lutpair1" *)
    LUT4 #(
        .INIT(16'h7F80)
    )
    \led[3]_i_2_TMR_1 
    (
        .I0(led_OBUF_TMR_1[1]),
        .I1(led_OBUF_TMR_1[0]),
        .I2(led_OBUF_TMR_1[2]),
        .I3(led_OBUF_TMR_1[3]),
        .O(p_0_in_TMR_1[3])
    );
(* SOFT_HLUTNM = "soft_lutpair1" *)
    LUT4 #(
        .INIT(16'h7F80)
    )
    \led[3]_i_2_TMR_2 
    (
        .I0(led_OBUF_TMR_2[1]),
        .I1(led_OBUF_TMR_2[0]),
        .I2(led_OBUF_TMR_2[2]),
        .I3(led_OBUF_TMR_2[3]),
        .O(p_0_in_TMR_2[3])
    );
    OBUF \led_OBUF[0]_inst_TMR_0 
    (
        .I(led_OBUF_TMR_0[0]),
        .O(led_TMR_0[0])
    );
    OBUF \led_OBUF[0]_inst_TMR_1 
    (
        .I(led_OBUF_TMR_1[0]),
        .O(led_TMR_1[0])
    );
    OBUF \led_OBUF[0]_inst_TMR_2 
    (
        .I(led_OBUF_TMR_2[0]),
        .O(led_TMR_2[0])
    );
    OBUF \led_OBUF[1]_inst_TMR_0 
    (
        .I(led_OBUF_TMR_0[1]),
        .O(led_TMR_0[1])
    );
    OBUF \led_OBUF[1]_inst_TMR_1 
    (
        .I(led_OBUF_TMR_1[1]),
        .O(led_TMR_1[1])
    );
    OBUF \led_OBUF[1]_inst_TMR_2 
    (
        .I(led_OBUF_TMR_2[1]),
        .O(led_TMR_2[1])
    );
    OBUF \led_OBUF[2]_inst_TMR_0 
    (
        .I(led_OBUF_TMR_0[2]),
        .O(led_TMR_0[2])
    );
    OBUF \led_OBUF[2]_inst_TMR_1 
    (
        .I(led_OBUF_TMR_1[2]),
        .O(led_TMR_1[2])
    );
    OBUF \led_OBUF[2]_inst_TMR_2 
    (
        .I(led_OBUF_TMR_2[2]),
        .O(led_TMR_2[2])
    );
    OBUF \led_OBUF[3]_inst_TMR_0 
    (
        .I(led_OBUF_TMR_0[3]),
        .O(led_TMR_0[3])
    );
    OBUF \led_OBUF[3]_inst_TMR_1 
    (
        .I(led_OBUF_TMR_1[3]),
        .O(led_TMR_1[3])
    );
    OBUF \led_OBUF[3]_inst_TMR_2 
    (
        .I(led_OBUF_TMR_2[3]),
        .O(led_TMR_2[3])
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_0[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_0),
        .D(p_0_in_TMR_0[0]),
        .Q(\led_reg_TMR_0[0]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_1[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_1),
        .D(p_0_in_TMR_1[0]),
        .Q(\led_reg_TMR_1[0]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_2[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_2),
        .D(p_0_in_TMR_2[0]),
        .Q(\led_reg_TMR_2[0]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_0[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_0),
        .D(p_0_in_TMR_0[1]),
        .Q(\led_reg_TMR_0[1]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_1[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_1),
        .D(p_0_in_TMR_1[1]),
        .Q(\led_reg_TMR_1[1]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_2[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_2),
        .D(p_0_in_TMR_2[1]),
        .Q(\led_reg_TMR_2[1]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_0[2] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_0),
        .D(p_0_in_TMR_0[2]),
        .Q(\led_reg_TMR_0[2]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_1[2] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_1),
        .D(p_0_in_TMR_1[2]),
        .Q(\led_reg_TMR_1[2]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_2[2] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_2),
        .D(p_0_in_TMR_2[2]),
        .Q(\led_reg_TMR_2[2]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_0[3] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_0),
        .D(p_0_in_TMR_0[3]),
        .Q(\led_reg_TMR_0[3]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_1[3] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_1),
        .D(p_0_in_TMR_1[3]),
        .Q(\led_reg_TMR_1[3]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    FDRE #(
        .INIT(1'b0)
    )
    \led_reg_TMR_2[3] 
    (
        .C(clk_IBUF_BUFG),
        .CE(enable_TMR_2),
        .D(p_0_in_TMR_2[3]),
        .Q(\led_reg_TMR_2[3]_Q_VOTER ),
        .R(btnu_IBUF)
    );
    debounceCounter my_debounceCounter
    (
        .\FSM_sequential_cs_reg[1]_0_TMR_0 (my_debounceCounter_n_0_TMR_0),
        .\FSM_sequential_cs_reg[1]_0_TMR_1 (my_debounceCounter_n_0_TMR_1),
        .\FSM_sequential_cs_reg[1]_0_TMR_2 (my_debounceCounter_n_0_TMR_2),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .btnu_IBUF(btnu_IBUF),
        .f2_TMR_0(f2_TMR_0),
        .f2_TMR_1(f2_TMR_1),
        .f2_TMR_2(f2_TMR_2)
    );
    FDRE #(
        .INIT(1'b0)
    )
    one_shot_1_reg_TMR_0
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(my_debounceCounter_n_0_TMR_0),
        .Q(one_shot_1_reg_TMR_0_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    one_shot_1_reg_TMR_1
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(my_debounceCounter_n_0_TMR_1),
        .Q(one_shot_1_reg_TMR_1_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    one_shot_1_reg_TMR_2
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(my_debounceCounter_n_0_TMR_2),
        .Q(one_shot_1_reg_TMR_2_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    one_shot_2_reg_TMR_0
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(one_shot_1_TMR_0),
        .Q(one_shot_2_reg_TMR_0_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    one_shot_2_reg_TMR_1
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(one_shot_1_TMR_1),
        .Q(one_shot_2_reg_TMR_1_Q_VOTER),
        .R(\<const0> )
    );
    FDRE #(
        .INIT(1'b0)
    )
    one_shot_2_reg_TMR_2
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(one_shot_1_TMR_2),
        .Q(one_shot_2_reg_TMR_2_Q_VOTER),
        .R(\<const0> )
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    f2_reg_TMR_0_Q_VOTER
    (
        .I0(f2_reg_TMR_0_Q_VOTER),
        .I1(f2_reg_TMR_1_Q_VOTER),
        .I2(f2_reg_TMR_2_Q_VOTER),
        .O(f2_TMR_0)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    f2_reg_TMR_1_Q_VOTER
    (
        .I0(f2_reg_TMR_0_Q_VOTER),
        .I1(f2_reg_TMR_1_Q_VOTER),
        .I2(f2_reg_TMR_2_Q_VOTER),
        .O(f2_TMR_1)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    f2_reg_TMR_2_Q_VOTER
    (
        .I0(f2_reg_TMR_0_Q_VOTER),
        .I1(f2_reg_TMR_1_Q_VOTER),
        .I2(f2_reg_TMR_2_Q_VOTER),
        .O(f2_TMR_2)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_0[3]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[3]_Q_VOTER ),
        .I1(\led_reg_TMR_1[3]_Q_VOTER ),
        .I2(\led_reg_TMR_2[3]_Q_VOTER ),
        .O(led_OBUF_TMR_0[3])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_1[3]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[3]_Q_VOTER ),
        .I1(\led_reg_TMR_1[3]_Q_VOTER ),
        .I2(\led_reg_TMR_2[3]_Q_VOTER ),
        .O(led_OBUF_TMR_1[3])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_2[3]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[3]_Q_VOTER ),
        .I1(\led_reg_TMR_1[3]_Q_VOTER ),
        .I2(\led_reg_TMR_2[3]_Q_VOTER ),
        .O(led_OBUF_TMR_2[3])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_0[0]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[0]_Q_VOTER ),
        .I1(\led_reg_TMR_1[0]_Q_VOTER ),
        .I2(\led_reg_TMR_2[0]_Q_VOTER ),
        .O(led_OBUF_TMR_0[0])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_1[0]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[0]_Q_VOTER ),
        .I1(\led_reg_TMR_1[0]_Q_VOTER ),
        .I2(\led_reg_TMR_2[0]_Q_VOTER ),
        .O(led_OBUF_TMR_1[0])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_2[0]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[0]_Q_VOTER ),
        .I1(\led_reg_TMR_1[0]_Q_VOTER ),
        .I2(\led_reg_TMR_2[0]_Q_VOTER ),
        .O(led_OBUF_TMR_2[0])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_0[1]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[1]_Q_VOTER ),
        .I1(\led_reg_TMR_1[1]_Q_VOTER ),
        .I2(\led_reg_TMR_2[1]_Q_VOTER ),
        .O(led_OBUF_TMR_0[1])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_1[1]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[1]_Q_VOTER ),
        .I1(\led_reg_TMR_1[1]_Q_VOTER ),
        .I2(\led_reg_TMR_2[1]_Q_VOTER ),
        .O(led_OBUF_TMR_1[1])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_2[1]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[1]_Q_VOTER ),
        .I1(\led_reg_TMR_1[1]_Q_VOTER ),
        .I2(\led_reg_TMR_2[1]_Q_VOTER ),
        .O(led_OBUF_TMR_2[1])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    f1_reg_TMR_0_Q_VOTER
    (
        .I0(f1_reg_TMR_0_Q_VOTER),
        .I1(f1_reg_TMR_1_Q_VOTER),
        .I2(f1_reg_TMR_2_Q_VOTER),
        .O(f1_TMR_0)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    f1_reg_TMR_1_Q_VOTER
    (
        .I0(f1_reg_TMR_0_Q_VOTER),
        .I1(f1_reg_TMR_1_Q_VOTER),
        .I2(f1_reg_TMR_2_Q_VOTER),
        .O(f1_TMR_1)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    f1_reg_TMR_2_Q_VOTER
    (
        .I0(f1_reg_TMR_0_Q_VOTER),
        .I1(f1_reg_TMR_1_Q_VOTER),
        .I2(f1_reg_TMR_2_Q_VOTER),
        .O(f1_TMR_2)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_0[2]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[2]_Q_VOTER ),
        .I1(\led_reg_TMR_1[2]_Q_VOTER ),
        .I2(\led_reg_TMR_2[2]_Q_VOTER ),
        .O(led_OBUF_TMR_0[2])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_1[2]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[2]_Q_VOTER ),
        .I1(\led_reg_TMR_1[2]_Q_VOTER ),
        .I2(\led_reg_TMR_2[2]_Q_VOTER ),
        .O(led_OBUF_TMR_1[2])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \led_reg_TMR_2[2]_Q_VOTER 
    (
        .I0(\led_reg_TMR_0[2]_Q_VOTER ),
        .I1(\led_reg_TMR_1[2]_Q_VOTER ),
        .I2(\led_reg_TMR_2[2]_Q_VOTER ),
        .O(led_OBUF_TMR_2[2])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    one_shot_1_reg_TMR_0_Q_VOTER
    (
        .I0(one_shot_1_reg_TMR_0_Q_VOTER),
        .I1(one_shot_1_reg_TMR_1_Q_VOTER),
        .I2(one_shot_1_reg_TMR_2_Q_VOTER),
        .O(one_shot_1_TMR_0)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    one_shot_1_reg_TMR_1_Q_VOTER
    (
        .I0(one_shot_1_reg_TMR_0_Q_VOTER),
        .I1(one_shot_1_reg_TMR_1_Q_VOTER),
        .I2(one_shot_1_reg_TMR_2_Q_VOTER),
        .O(one_shot_1_TMR_1)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    one_shot_1_reg_TMR_2_Q_VOTER
    (
        .I0(one_shot_1_reg_TMR_0_Q_VOTER),
        .I1(one_shot_1_reg_TMR_1_Q_VOTER),
        .I2(one_shot_1_reg_TMR_2_Q_VOTER),
        .O(one_shot_1_TMR_2)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    one_shot_2_reg_TMR_0_Q_VOTER
    (
        .I0(one_shot_2_reg_TMR_0_Q_VOTER),
        .I1(one_shot_2_reg_TMR_1_Q_VOTER),
        .I2(one_shot_2_reg_TMR_2_Q_VOTER),
        .O(one_shot_2_TMR_0)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    one_shot_2_reg_TMR_1_Q_VOTER
    (
        .I0(one_shot_2_reg_TMR_0_Q_VOTER),
        .I1(one_shot_2_reg_TMR_1_Q_VOTER),
        .I2(one_shot_2_reg_TMR_2_Q_VOTER),
        .O(one_shot_2_TMR_1)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    one_shot_2_reg_TMR_2_Q_VOTER
    (
        .I0(one_shot_2_reg_TMR_0_Q_VOTER),
        .I1(one_shot_2_reg_TMR_1_Q_VOTER),
        .I2(one_shot_2_reg_TMR_2_Q_VOTER),
        .O(one_shot_2_TMR_2)
    );
endmodule

`celldefine
module GND
(
    G
);

    output G;

endmodule
`endcelldefine

`celldefine
module VCC
(
    P
);

    output P;

endmodule
`endcelldefine

`celldefine
module IBUF
(
    I,
    O
);

    input I;
    output O;

endmodule
`endcelldefine

`celldefine
module BUFG
(
    I,
    O
);

    input I;
    output O;

endmodule
`endcelldefine

`celldefine
module FDRE
(
    C,
    CE,
    D,
    Q,
    R
);

    input C;
    input CE;
    input D;
    output Q;
    input R;

endmodule
`endcelldefine

`celldefine
module LUT1
(
    I0,
    O
);

    input I0;
    output O;

endmodule
`endcelldefine

`celldefine
module LUT2
(
    I0,
    I1,
    O
);

    input I0;
    input I1;
    output O;

endmodule
`endcelldefine

`celldefine
module LUT3
(
    I0,
    I1,
    I2,
    O
);

    input I0;
    input I1;
    input I2;
    output O;

endmodule
`endcelldefine

`celldefine
module LUT4
(
    I0,
    I1,
    I2,
    I3,
    O
);

    input I0;
    input I1;
    input I2;
    input I3;
    output O;

endmodule
`endcelldefine

`celldefine
module OBUF
(
    I,
    O
);

    input I;
    output O;

endmodule
`endcelldefine

module debounceCounter
(
    \FSM_sequential_cs_reg[1]_0_TMR_0 ,
    \FSM_sequential_cs_reg[1]_0_TMR_1 ,
    \FSM_sequential_cs_reg[1]_0_TMR_2 ,
    clk_IBUF_BUFG,
    btnu_IBUF,
    f2_TMR_0,
    f2_TMR_1,
    f2_TMR_2
);

    output \FSM_sequential_cs_reg[1]_0_TMR_0 ;
    output \FSM_sequential_cs_reg[1]_0_TMR_1 ;
    output \FSM_sequential_cs_reg[1]_0_TMR_2 ;
    input clk_IBUF_BUFG;
    input btnu_IBUF;
    input f2_TMR_0;
    input f2_TMR_1;
    input f2_TMR_2;

    wire \count_reg_TMR_2[13]_Q_VOTER ;
    wire \count_reg_TMR_1[13]_Q_VOTER ;
    wire \count_reg_TMR_0[13]_Q_VOTER ;
    wire \count_reg_TMR_2[16]_Q_VOTER ;
    wire \count_reg_TMR_1[16]_Q_VOTER ;
    wire \count_reg_TMR_0[16]_Q_VOTER ;
    wire \count_reg_TMR_2[1]_Q_VOTER ;
    wire \count_reg_TMR_1[1]_Q_VOTER ;
    wire \count_reg_TMR_0[1]_Q_VOTER ;
    wire \count_reg_TMR_2[7]_Q_VOTER ;
    wire \count_reg_TMR_1[7]_Q_VOTER ;
    wire \count_reg_TMR_0[7]_Q_VOTER ;
    wire \count_reg_TMR_2[4]_Q_VOTER ;
    wire \count_reg_TMR_1[4]_Q_VOTER ;
    wire \count_reg_TMR_0[4]_Q_VOTER ;
    wire \FSM_sequential_cs_reg_TMR_2[1]_Q_VOTER ;
    wire \FSM_sequential_cs_reg_TMR_1[1]_Q_VOTER ;
    wire \FSM_sequential_cs_reg_TMR_0[1]_Q_VOTER ;
    wire \count_reg_TMR_2[9]_Q_VOTER ;
    wire \count_reg_TMR_1[9]_Q_VOTER ;
    wire \count_reg_TMR_0[9]_Q_VOTER ;
    wire \count_reg_TMR_2[15]_Q_VOTER ;
    wire \count_reg_TMR_1[15]_Q_VOTER ;
    wire \count_reg_TMR_0[15]_Q_VOTER ;
    wire \count_reg_TMR_2[18]_Q_VOTER ;
    wire \count_reg_TMR_1[18]_Q_VOTER ;
    wire \count_reg_TMR_0[18]_Q_VOTER ;
    wire \count_reg_TMR_2[6]_Q_VOTER ;
    wire \count_reg_TMR_1[6]_Q_VOTER ;
    wire \count_reg_TMR_0[6]_Q_VOTER ;
    wire \count_reg_TMR_2[12]_Q_VOTER ;
    wire \count_reg_TMR_1[12]_Q_VOTER ;
    wire \count_reg_TMR_0[12]_Q_VOTER ;
    wire \count_reg_TMR_2[3]_Q_VOTER ;
    wire \count_reg_TMR_1[3]_Q_VOTER ;
    wire \count_reg_TMR_0[3]_Q_VOTER ;
    wire \count_reg_TMR_2[14]_Q_VOTER ;
    wire \count_reg_TMR_1[14]_Q_VOTER ;
    wire \count_reg_TMR_0[14]_Q_VOTER ;
    wire \count_reg_TMR_2[17]_Q_VOTER ;
    wire \count_reg_TMR_1[17]_Q_VOTER ;
    wire \count_reg_TMR_0[17]_Q_VOTER ;
    wire \count_reg_TMR_2[5]_Q_VOTER ;
    wire \count_reg_TMR_1[5]_Q_VOTER ;
    wire \count_reg_TMR_0[5]_Q_VOTER ;
    wire \count_reg_TMR_2[11]_Q_VOTER ;
    wire \count_reg_TMR_1[11]_Q_VOTER ;
    wire \count_reg_TMR_0[11]_Q_VOTER ;
    wire \count_reg_TMR_2[0]_Q_VOTER ;
    wire \count_reg_TMR_1[0]_Q_VOTER ;
    wire \count_reg_TMR_0[0]_Q_VOTER ;
    wire \count_reg_TMR_2[2]_Q_VOTER ;
    wire \count_reg_TMR_1[2]_Q_VOTER ;
    wire \count_reg_TMR_0[2]_Q_VOTER ;
    wire \FSM_sequential_cs_reg_TMR_2[0]_Q_VOTER ;
    wire \FSM_sequential_cs_reg_TMR_1[0]_Q_VOTER ;
    wire \FSM_sequential_cs_reg_TMR_0[0]_Q_VOTER ;
    wire \count_reg_TMR_2[8]_Q_VOTER ;
    wire \count_reg_TMR_1[8]_Q_VOTER ;
    wire \count_reg_TMR_0[8]_Q_VOTER ;
    wire \count_reg_TMR_2[10]_Q_VOTER ;
    wire \count_reg_TMR_1[10]_Q_VOTER ;
    wire \count_reg_TMR_0[10]_Q_VOTER ;
    wire timerDone__17_TMR_2;
    wire timerDone__17_TMR_1;
    wire timerDone__17_TMR_0;
    wire cs_TMR_2;
    wire cs_TMR_1;
    wire cs_TMR_0;
    wire \count_reg[8]_i_1_n_7 ;
    wire \count_reg[8]_i_1_n_6 ;
    wire \count_reg[8]_i_1_n_5 ;
    wire \count_reg[8]_i_1_n_4 ;
    wire \count_reg[8]_i_1_n_3 ;
    wire \count_reg[8]_i_1_n_2 ;
    wire \count_reg[8]_i_1_n_1 ;
    wire \count_reg[8]_i_1_n_0 ;
    wire \count_reg[4]_i_1_n_7 ;
    wire \count_reg[4]_i_1_n_6 ;
    wire \count_reg[4]_i_1_n_5 ;
    wire \count_reg[4]_i_1_n_4 ;
    wire \count_reg[4]_i_1_n_3 ;
    wire \count_reg[4]_i_1_n_2 ;
    wire \count_reg[4]_i_1_n_1 ;
    wire \count_reg[4]_i_1_n_0 ;
    wire \count_reg[16]_i_1_n_7 ;
    wire \count_reg[16]_i_1_n_6 ;
    wire \count_reg[16]_i_1_n_5 ;
    wire \count_reg[16]_i_1_n_3 ;
    wire \count_reg[16]_i_1_n_2 ;
    wire \count_reg[12]_i_1_n_7 ;
    wire \count_reg[12]_i_1_n_6 ;
    wire \count_reg[12]_i_1_n_5 ;
    wire \count_reg[12]_i_1_n_4 ;
    wire \count_reg[12]_i_1_n_3 ;
    wire \count_reg[12]_i_1_n_2 ;
    wire \count_reg[12]_i_1_n_1 ;
    wire \count_reg[12]_i_1_n_0 ;
    wire \count_reg[0]_i_2_n_7 ;
    wire \count_reg[0]_i_2_n_6 ;
    wire \count_reg[0]_i_2_n_5 ;
    wire \count_reg[0]_i_2_n_4 ;
    wire \count_reg[0]_i_2_n_3 ;
    wire \count_reg[0]_i_2_n_2 ;
    wire \count_reg[0]_i_2_n_1 ;
    wire \count_reg[0]_i_2_n_0 ;
    wire [18:0]count_reg_TMR_2;
    wire [18:0]count_reg_TMR_1;
    wire [18:0]count_reg_TMR_0;
    wire \count[0]_i_3_n_0 ;
    wire \count[0]_i_1_n_0_TMR_2 ;
    wire \count[0]_i_1_n_0_TMR_1 ;
    wire \count[0]_i_1_n_0_TMR_0 ;
    wire \FSM_sequential_cs_reg_n_0__TMR_2[1] ;
    wire \FSM_sequential_cs_reg_n_0__TMR_1[1] ;
    wire \FSM_sequential_cs_reg_n_0__TMR_0[1] ;
    wire \FSM_sequential_cs[1]_i_6_n_0_TMR_2 ;
    wire \FSM_sequential_cs[1]_i_6_n_0_TMR_1 ;
    wire \FSM_sequential_cs[1]_i_6_n_0_TMR_0 ;
    wire \FSM_sequential_cs[1]_i_5_n_0_TMR_2 ;
    wire \FSM_sequential_cs[1]_i_5_n_0_TMR_1 ;
    wire \FSM_sequential_cs[1]_i_5_n_0_TMR_0 ;
    wire \FSM_sequential_cs[1]_i_4_n_0_TMR_2 ;
    wire \FSM_sequential_cs[1]_i_4_n_0_TMR_1 ;
    wire \FSM_sequential_cs[1]_i_4_n_0_TMR_0 ;
    wire \FSM_sequential_cs[1]_i_3_n_0_TMR_2 ;
    wire \FSM_sequential_cs[1]_i_3_n_0_TMR_1 ;
    wire \FSM_sequential_cs[1]_i_3_n_0_TMR_0 ;
    wire \FSM_sequential_cs[1]_i_1_n_0_TMR_2 ;
    wire \FSM_sequential_cs[1]_i_1_n_0_TMR_1 ;
    wire \FSM_sequential_cs[1]_i_1_n_0_TMR_0 ;
    wire \FSM_sequential_cs[0]_i_1_n_0_TMR_2 ;
    wire \FSM_sequential_cs[0]_i_1_n_0_TMR_1 ;
    wire \FSM_sequential_cs[0]_i_1_n_0_TMR_0 ;
    wire \<const1> ;
    wire \<const0> ;
    wire f2_TMR_2;
    wire f2_TMR_1;
    wire f2_TMR_0;
    wire btnu_IBUF;
    wire clk_IBUF_BUFG;
    wire \FSM_sequential_cs_reg[1]_0_TMR_2 ;
    wire \FSM_sequential_cs_reg[1]_0_TMR_1 ;
    wire \FSM_sequential_cs_reg[1]_0_TMR_0 ;

(* SOFT_HLUTNM = "soft_lutpair0" *)
    LUT5 #(
        .INIT(32'h00000666)
    )
    \FSM_sequential_cs[0]_i_1_TMR_0 
    (
        .I0(f2_TMR_0),
        .I1(\FSM_sequential_cs_reg_n_0__TMR_0[1] ),
        .I2(cs_TMR_0),
        .I3(timerDone__17_TMR_0),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[0]_i_1_n_0_TMR_0 )
    );
(* SOFT_HLUTNM = "soft_lutpair0" *)
    LUT5 #(
        .INIT(32'h00000666)
    )
    \FSM_sequential_cs[0]_i_1_TMR_1 
    (
        .I0(f2_TMR_1),
        .I1(\FSM_sequential_cs_reg_n_0__TMR_1[1] ),
        .I2(cs_TMR_1),
        .I3(timerDone__17_TMR_1),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[0]_i_1_n_0_TMR_1 )
    );
(* SOFT_HLUTNM = "soft_lutpair0" *)
    LUT5 #(
        .INIT(32'h00000666)
    )
    \FSM_sequential_cs[0]_i_1_TMR_2 
    (
        .I0(f2_TMR_2),
        .I1(\FSM_sequential_cs_reg_n_0__TMR_2[1] ),
        .I2(cs_TMR_2),
        .I3(timerDone__17_TMR_2),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[0]_i_1_n_0_TMR_2 )
    );
(* SOFT_HLUTNM = "soft_lutpair0" *)
    LUT5 #(
        .INIT(32'h0000BF80)
    )
    \FSM_sequential_cs[1]_i_1_TMR_0 
    (
        .I0(f2_TMR_0),
        .I1(timerDone__17_TMR_0),
        .I2(cs_TMR_0),
        .I3(\FSM_sequential_cs_reg_n_0__TMR_0[1] ),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[1]_i_1_n_0_TMR_0 )
    );
(* SOFT_HLUTNM = "soft_lutpair0" *)
    LUT5 #(
        .INIT(32'h0000BF80)
    )
    \FSM_sequential_cs[1]_i_1_TMR_1 
    (
        .I0(f2_TMR_1),
        .I1(timerDone__17_TMR_1),
        .I2(cs_TMR_1),
        .I3(\FSM_sequential_cs_reg_n_0__TMR_1[1] ),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[1]_i_1_n_0_TMR_1 )
    );
(* SOFT_HLUTNM = "soft_lutpair0" *)
    LUT5 #(
        .INIT(32'h0000BF80)
    )
    \FSM_sequential_cs[1]_i_1_TMR_2 
    (
        .I0(f2_TMR_2),
        .I1(timerDone__17_TMR_2),
        .I2(cs_TMR_2),
        .I3(\FSM_sequential_cs_reg_n_0__TMR_2[1] ),
        .I4(btnu_IBUF),
        .O(\FSM_sequential_cs[1]_i_1_n_0_TMR_2 )
    );
    LUT4 #(
        .INIT(16'h4000)
    )
    \FSM_sequential_cs[1]_i_2_TMR_0 
    (
        .I0(\FSM_sequential_cs[1]_i_3_n_0_TMR_0 ),
        .I1(\FSM_sequential_cs[1]_i_4_n_0_TMR_0 ),
        .I2(\FSM_sequential_cs[1]_i_5_n_0_TMR_0 ),
        .I3(\FSM_sequential_cs[1]_i_6_n_0_TMR_0 ),
        .O(timerDone__17_TMR_0)
    );
    LUT4 #(
        .INIT(16'h4000)
    )
    \FSM_sequential_cs[1]_i_2_TMR_1 
    (
        .I0(\FSM_sequential_cs[1]_i_3_n_0_TMR_1 ),
        .I1(\FSM_sequential_cs[1]_i_4_n_0_TMR_1 ),
        .I2(\FSM_sequential_cs[1]_i_5_n_0_TMR_1 ),
        .I3(\FSM_sequential_cs[1]_i_6_n_0_TMR_1 ),
        .O(timerDone__17_TMR_1)
    );
    LUT4 #(
        .INIT(16'h4000)
    )
    \FSM_sequential_cs[1]_i_2_TMR_2 
    (
        .I0(\FSM_sequential_cs[1]_i_3_n_0_TMR_2 ),
        .I1(\FSM_sequential_cs[1]_i_4_n_0_TMR_2 ),
        .I2(\FSM_sequential_cs[1]_i_5_n_0_TMR_2 ),
        .I3(\FSM_sequential_cs[1]_i_6_n_0_TMR_2 ),
        .O(timerDone__17_TMR_2)
    );
    LUT5 #(
        .INIT(32'hFFFFFFFB)
    )
    \FSM_sequential_cs[1]_i_3_TMR_0 
    (
        .I0(count_reg_TMR_0[6]),
        .I1(count_reg_TMR_0[17]),
        .I2(count_reg_TMR_0[5]),
        .I3(count_reg_TMR_0[9]),
        .I4(count_reg_TMR_0[7]),
        .O(\FSM_sequential_cs[1]_i_3_n_0_TMR_0 )
    );
    LUT5 #(
        .INIT(32'hFFFFFFFB)
    )
    \FSM_sequential_cs[1]_i_3_TMR_1 
    (
        .I0(count_reg_TMR_1[6]),
        .I1(count_reg_TMR_1[17]),
        .I2(count_reg_TMR_1[5]),
        .I3(count_reg_TMR_1[9]),
        .I4(count_reg_TMR_1[7]),
        .O(\FSM_sequential_cs[1]_i_3_n_0_TMR_1 )
    );
    LUT5 #(
        .INIT(32'hFFFFFFFB)
    )
    \FSM_sequential_cs[1]_i_3_TMR_2 
    (
        .I0(count_reg_TMR_2[6]),
        .I1(count_reg_TMR_2[17]),
        .I2(count_reg_TMR_2[5]),
        .I3(count_reg_TMR_2[9]),
        .I4(count_reg_TMR_2[7]),
        .O(\FSM_sequential_cs[1]_i_3_n_0_TMR_2 )
    );
    LUT4 #(
        .INIT(16'h0001)
    )
    \FSM_sequential_cs[1]_i_4_TMR_0 
    (
        .I0(count_reg_TMR_0[14]),
        .I1(count_reg_TMR_0[12]),
        .I2(count_reg_TMR_0[11]),
        .I3(count_reg_TMR_0[10]),
        .O(\FSM_sequential_cs[1]_i_4_n_0_TMR_0 )
    );
    LUT4 #(
        .INIT(16'h0001)
    )
    \FSM_sequential_cs[1]_i_4_TMR_1 
    (
        .I0(count_reg_TMR_1[14]),
        .I1(count_reg_TMR_1[12]),
        .I2(count_reg_TMR_1[11]),
        .I3(count_reg_TMR_1[10]),
        .O(\FSM_sequential_cs[1]_i_4_n_0_TMR_1 )
    );
    LUT4 #(
        .INIT(16'h0001)
    )
    \FSM_sequential_cs[1]_i_4_TMR_2 
    (
        .I0(count_reg_TMR_2[14]),
        .I1(count_reg_TMR_2[12]),
        .I2(count_reg_TMR_2[11]),
        .I3(count_reg_TMR_2[10]),
        .O(\FSM_sequential_cs[1]_i_4_n_0_TMR_2 )
    );
    LUT5 #(
        .INIT(32'h80000000)
    )
    \FSM_sequential_cs[1]_i_5_TMR_0 
    (
        .I0(count_reg_TMR_0[8]),
        .I1(count_reg_TMR_0[13]),
        .I2(count_reg_TMR_0[15]),
        .I3(count_reg_TMR_0[18]),
        .I4(count_reg_TMR_0[16]),
        .O(\FSM_sequential_cs[1]_i_5_n_0_TMR_0 )
    );
    LUT5 #(
        .INIT(32'h80000000)
    )
    \FSM_sequential_cs[1]_i_5_TMR_1 
    (
        .I0(count_reg_TMR_1[8]),
        .I1(count_reg_TMR_1[13]),
        .I2(count_reg_TMR_1[15]),
        .I3(count_reg_TMR_1[18]),
        .I4(count_reg_TMR_1[16]),
        .O(\FSM_sequential_cs[1]_i_5_n_0_TMR_1 )
    );
    LUT5 #(
        .INIT(32'h80000000)
    )
    \FSM_sequential_cs[1]_i_5_TMR_2 
    (
        .I0(count_reg_TMR_2[8]),
        .I1(count_reg_TMR_2[13]),
        .I2(count_reg_TMR_2[15]),
        .I3(count_reg_TMR_2[18]),
        .I4(count_reg_TMR_2[16]),
        .O(\FSM_sequential_cs[1]_i_5_n_0_TMR_2 )
    );
    LUT5 #(
        .INIT(32'h80000000)
    )
    \FSM_sequential_cs[1]_i_6_TMR_0 
    (
        .I0(count_reg_TMR_0[0]),
        .I1(count_reg_TMR_0[1]),
        .I2(count_reg_TMR_0[2]),
        .I3(count_reg_TMR_0[4]),
        .I4(count_reg_TMR_0[3]),
        .O(\FSM_sequential_cs[1]_i_6_n_0_TMR_0 )
    );
    LUT5 #(
        .INIT(32'h80000000)
    )
    \FSM_sequential_cs[1]_i_6_TMR_1 
    (
        .I0(count_reg_TMR_1[0]),
        .I1(count_reg_TMR_1[1]),
        .I2(count_reg_TMR_1[2]),
        .I3(count_reg_TMR_1[4]),
        .I4(count_reg_TMR_1[3]),
        .O(\FSM_sequential_cs[1]_i_6_n_0_TMR_1 )
    );
    LUT5 #(
        .INIT(32'h80000000)
    )
    \FSM_sequential_cs[1]_i_6_TMR_2 
    (
        .I0(count_reg_TMR_2[0]),
        .I1(count_reg_TMR_2[1]),
        .I2(count_reg_TMR_2[2]),
        .I3(count_reg_TMR_2[4]),
        .I4(count_reg_TMR_2[3]),
        .O(\FSM_sequential_cs[1]_i_6_n_0_TMR_2 )
    );
(* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *)
    FDRE #(
        .INIT(1'b0)
    )
    \FSM_sequential_cs_reg_TMR_0[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[0]_i_1_n_0_TMR_0 ),
        .Q(\FSM_sequential_cs_reg_TMR_0[0]_Q_VOTER ),
        .R(\<const0> )
    );
(* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *)
    FDRE #(
        .INIT(1'b0)
    )
    \FSM_sequential_cs_reg_TMR_1[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[0]_i_1_n_0_TMR_1 ),
        .Q(\FSM_sequential_cs_reg_TMR_1[0]_Q_VOTER ),
        .R(\<const0> )
    );
(* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *)
    FDRE #(
        .INIT(1'b0)
    )
    \FSM_sequential_cs_reg_TMR_2[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[0]_i_1_n_0_TMR_2 ),
        .Q(\FSM_sequential_cs_reg_TMR_2[0]_Q_VOTER ),
        .R(\<const0> )
    );
(* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *)
    FDRE #(
        .INIT(1'b0)
    )
    \FSM_sequential_cs_reg_TMR_0[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[1]_i_1_n_0_TMR_0 ),
        .Q(\FSM_sequential_cs_reg_TMR_0[1]_Q_VOTER ),
        .R(\<const0> )
    );
(* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *)
    FDRE #(
        .INIT(1'b0)
    )
    \FSM_sequential_cs_reg_TMR_1[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[1]_i_1_n_0_TMR_1 ),
        .Q(\FSM_sequential_cs_reg_TMR_1[1]_Q_VOTER ),
        .R(\<const0> )
    );
(* FSM_ENCODED_STATES = "S1:01,S2:10,S3:11,S0:00" *)
    FDRE #(
        .INIT(1'b0)
    )
    \FSM_sequential_cs_reg_TMR_2[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\FSM_sequential_cs[1]_i_1_n_0_TMR_2 ),
        .Q(\FSM_sequential_cs_reg_TMR_2[1]_Q_VOTER ),
        .R(\<const0> )
    );
    GND GND
    (
        .G(\<const0> )
    );
    VCC VCC
    (
        .P(\<const1> )
    );
    LUT2 #(
        .INIT(4'h1)
    )
    \count[0]_i_1_TMR_0 
    (
        .I0(btnu_IBUF),
        .I1(cs_TMR_0),
        .O(\count[0]_i_1_n_0_TMR_0 )
    );
    LUT2 #(
        .INIT(4'h1)
    )
    \count[0]_i_1_TMR_1 
    (
        .I0(btnu_IBUF),
        .I1(cs_TMR_1),
        .O(\count[0]_i_1_n_0_TMR_1 )
    );
    LUT2 #(
        .INIT(4'h1)
    )
    \count[0]_i_1_TMR_2 
    (
        .I0(btnu_IBUF),
        .I1(cs_TMR_2),
        .O(\count[0]_i_1_n_0_TMR_2 )
    );
    LUT1 #(
        .INIT(2'h1)
    )
    \count[0]_i_3_TMR_0 
    (
        .I0(count_reg_TMR_0[0]),
        .O(\count[0]_i_3_n_0 )
    );
    LUT1 #(
        .INIT(2'h1)
    )
    \count[0]_i_3_TMR_1 
    (
        .I0(count_reg_TMR_1[0]),
        .O()
    );
    LUT1 #(
        .INIT(2'h1)
    )
    \count[0]_i_3_TMR_2 
    (
        .I0(count_reg_TMR_2[0]),
        .O()
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_7 ),
        .Q(\count_reg_TMR_0[0]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_7 ),
        .Q(\count_reg_TMR_1[0]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[0] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_7 ),
        .Q(\count_reg_TMR_2[0]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
(* ADDER_THRESHOLD = "11" *)
    CARRY4 \count_reg[0]_i_2 
    (
        .CI(\<const0> ),
        .CO({\count_reg[0]_i_2_n_0 , \count_reg[0]_i_2_n_1 , \count_reg[0]_i_2_n_2 , \count_reg[0]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> , \<const0> , \<const0> , \<const1> }),
        .O({\count_reg[0]_i_2_n_4 , \count_reg[0]_i_2_n_5 , \count_reg[0]_i_2_n_6 , \count_reg[0]_i_2_n_7 }),
        .S({count_reg_TMR_0[3:1], \count[0]_i_3_n_0 })
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[10] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_5 ),
        .Q(\count_reg_TMR_0[10]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[10] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_5 ),
        .Q(\count_reg_TMR_1[10]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[10] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_5 ),
        .Q(\count_reg_TMR_2[10]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[11] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_4 ),
        .Q(\count_reg_TMR_0[11]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[11] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_4 ),
        .Q(\count_reg_TMR_1[11]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[11] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_4 ),
        .Q(\count_reg_TMR_2[11]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[12] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_7 ),
        .Q(\count_reg_TMR_0[12]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[12] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_7 ),
        .Q(\count_reg_TMR_1[12]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[12] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_7 ),
        .Q(\count_reg_TMR_2[12]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
(* ADDER_THRESHOLD = "11" *)
    CARRY4 \count_reg[12]_i_1 
    (
        .CI(\count_reg[8]_i_1_n_0 ),
        .CO({\count_reg[12]_i_1_n_0 , \count_reg[12]_i_1_n_1 , \count_reg[12]_i_1_n_2 , \count_reg[12]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> , \<const0> , \<const0> , \<const0> }),
        .O({\count_reg[12]_i_1_n_4 , \count_reg[12]_i_1_n_5 , \count_reg[12]_i_1_n_6 , \count_reg[12]_i_1_n_7 }),
        .S(count_reg_TMR_0[15:12])
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[13] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_6 ),
        .Q(\count_reg_TMR_0[13]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[13] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_6 ),
        .Q(\count_reg_TMR_1[13]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[13] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_6 ),
        .Q(\count_reg_TMR_2[13]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[14] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_5 ),
        .Q(\count_reg_TMR_0[14]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[14] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_5 ),
        .Q(\count_reg_TMR_1[14]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[14] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_5 ),
        .Q(\count_reg_TMR_2[14]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[15] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_4 ),
        .Q(\count_reg_TMR_0[15]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[15] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_4 ),
        .Q(\count_reg_TMR_1[15]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[15] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[12]_i_1_n_4 ),
        .Q(\count_reg_TMR_2[15]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[16] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_7 ),
        .Q(\count_reg_TMR_0[16]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[16] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_7 ),
        .Q(\count_reg_TMR_1[16]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[16] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_7 ),
        .Q(\count_reg_TMR_2[16]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
(* ADDER_THRESHOLD = "11" *)
    CARRY4 \count_reg[16]_i_1 
    (
        .CI(\count_reg[12]_i_1_n_0 ),
        .CO({\count_reg[16]_i_1_n_2 , \count_reg[16]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> , \<const0> , \<const0> , \<const0> }),
        .O({\count_reg[16]_i_1_n_5 , \count_reg[16]_i_1_n_6 , \count_reg[16]_i_1_n_7 }),
        .S({\<const0> , count_reg_TMR_0[18:16]})
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[17] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_6 ),
        .Q(\count_reg_TMR_0[17]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[17] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_6 ),
        .Q(\count_reg_TMR_1[17]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[17] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_6 ),
        .Q(\count_reg_TMR_2[17]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[18] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_5 ),
        .Q(\count_reg_TMR_0[18]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[18] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_5 ),
        .Q(\count_reg_TMR_1[18]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[18] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[16]_i_1_n_5 ),
        .Q(\count_reg_TMR_2[18]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_6 ),
        .Q(\count_reg_TMR_0[1]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_6 ),
        .Q(\count_reg_TMR_1[1]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[1] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_6 ),
        .Q(\count_reg_TMR_2[1]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[2] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_5 ),
        .Q(\count_reg_TMR_0[2]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[2] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_5 ),
        .Q(\count_reg_TMR_1[2]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[2] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_5 ),
        .Q(\count_reg_TMR_2[2]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[3] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_4 ),
        .Q(\count_reg_TMR_0[3]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[3] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_4 ),
        .Q(\count_reg_TMR_1[3]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[3] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[0]_i_2_n_4 ),
        .Q(\count_reg_TMR_2[3]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[4] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_7 ),
        .Q(\count_reg_TMR_0[4]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[4] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_7 ),
        .Q(\count_reg_TMR_1[4]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[4] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_7 ),
        .Q(\count_reg_TMR_2[4]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
(* ADDER_THRESHOLD = "11" *)
    CARRY4 \count_reg[4]_i_1 
    (
        .CI(\count_reg[0]_i_2_n_0 ),
        .CO({\count_reg[4]_i_1_n_0 , \count_reg[4]_i_1_n_1 , \count_reg[4]_i_1_n_2 , \count_reg[4]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> , \<const0> , \<const0> , \<const0> }),
        .O({\count_reg[4]_i_1_n_4 , \count_reg[4]_i_1_n_5 , \count_reg[4]_i_1_n_6 , \count_reg[4]_i_1_n_7 }),
        .S(count_reg_TMR_0[7:4])
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[5] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_6 ),
        .Q(\count_reg_TMR_0[5]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[5] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_6 ),
        .Q(\count_reg_TMR_1[5]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[5] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_6 ),
        .Q(\count_reg_TMR_2[5]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[6] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_5 ),
        .Q(\count_reg_TMR_0[6]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[6] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_5 ),
        .Q(\count_reg_TMR_1[6]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[6] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_5 ),
        .Q(\count_reg_TMR_2[6]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[7] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_4 ),
        .Q(\count_reg_TMR_0[7]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[7] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_4 ),
        .Q(\count_reg_TMR_1[7]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[7] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[4]_i_1_n_4 ),
        .Q(\count_reg_TMR_2[7]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[8] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_7 ),
        .Q(\count_reg_TMR_0[8]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[8] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_7 ),
        .Q(\count_reg_TMR_1[8]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[8] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_7 ),
        .Q(\count_reg_TMR_2[8]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
(* ADDER_THRESHOLD = "11" *)
    CARRY4 \count_reg[8]_i_1 
    (
        .CI(\count_reg[4]_i_1_n_0 ),
        .CO({\count_reg[8]_i_1_n_0 , \count_reg[8]_i_1_n_1 , \count_reg[8]_i_1_n_2 , \count_reg[8]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> , \<const0> , \<const0> , \<const0> }),
        .O({\count_reg[8]_i_1_n_4 , \count_reg[8]_i_1_n_5 , \count_reg[8]_i_1_n_6 , \count_reg[8]_i_1_n_7 }),
        .S(count_reg_TMR_0[11:8])
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_0[9] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_6 ),
        .Q(\count_reg_TMR_0[9]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_0 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_1[9] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_6 ),
        .Q(\count_reg_TMR_1[9]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_1 )
    );
    FDRE #(
        .INIT(1'b0)
    )
    \count_reg_TMR_2[9] 
    (
        .C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\count_reg[8]_i_1_n_6 ),
        .Q(\count_reg_TMR_2[9]_Q_VOTER ),
        .R(\count[0]_i_1_n_0_TMR_2 )
    );
    LUT2 #(
        .INIT(4'h2)
    )
    one_shot_1_i_1_TMR_0
    (
        .I0(\FSM_sequential_cs_reg_n_0__TMR_0[1] ),
        .I1(btnu_IBUF),
        .O(\FSM_sequential_cs_reg[1]_0_TMR_0 )
    );
    LUT2 #(
        .INIT(4'h2)
    )
    one_shot_1_i_1_TMR_1
    (
        .I0(\FSM_sequential_cs_reg_n_0__TMR_1[1] ),
        .I1(btnu_IBUF),
        .O(\FSM_sequential_cs_reg[1]_0_TMR_1 )
    );
    LUT2 #(
        .INIT(4'h2)
    )
    one_shot_1_i_1_TMR_2
    (
        .I0(\FSM_sequential_cs_reg_n_0__TMR_2[1] ),
        .I1(btnu_IBUF),
        .O(\FSM_sequential_cs_reg[1]_0_TMR_2 )
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[10]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[10]_Q_VOTER ),
        .I1(\count_reg_TMR_1[10]_Q_VOTER ),
        .I2(\count_reg_TMR_2[10]_Q_VOTER ),
        .O(count_reg_TMR_0[10])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[10]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[10]_Q_VOTER ),
        .I1(\count_reg_TMR_1[10]_Q_VOTER ),
        .I2(\count_reg_TMR_2[10]_Q_VOTER ),
        .O(count_reg_TMR_1[10])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[10]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[10]_Q_VOTER ),
        .I1(\count_reg_TMR_1[10]_Q_VOTER ),
        .I2(\count_reg_TMR_2[10]_Q_VOTER ),
        .O(count_reg_TMR_2[10])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[8]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[8]_Q_VOTER ),
        .I1(\count_reg_TMR_1[8]_Q_VOTER ),
        .I2(\count_reg_TMR_2[8]_Q_VOTER ),
        .O(count_reg_TMR_0[8])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[8]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[8]_Q_VOTER ),
        .I1(\count_reg_TMR_1[8]_Q_VOTER ),
        .I2(\count_reg_TMR_2[8]_Q_VOTER ),
        .O(count_reg_TMR_1[8])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[8]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[8]_Q_VOTER ),
        .I1(\count_reg_TMR_1[8]_Q_VOTER ),
        .I2(\count_reg_TMR_2[8]_Q_VOTER ),
        .O(count_reg_TMR_2[8])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \FSM_sequential_cs_reg_TMR_0[0]_Q_VOTER 
    (
        .I0(\FSM_sequential_cs_reg_TMR_0[0]_Q_VOTER ),
        .I1(\FSM_sequential_cs_reg_TMR_1[0]_Q_VOTER ),
        .I2(\FSM_sequential_cs_reg_TMR_2[0]_Q_VOTER ),
        .O(cs_TMR_0)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \FSM_sequential_cs_reg_TMR_1[0]_Q_VOTER 
    (
        .I0(\FSM_sequential_cs_reg_TMR_0[0]_Q_VOTER ),
        .I1(\FSM_sequential_cs_reg_TMR_1[0]_Q_VOTER ),
        .I2(\FSM_sequential_cs_reg_TMR_2[0]_Q_VOTER ),
        .O(cs_TMR_1)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \FSM_sequential_cs_reg_TMR_2[0]_Q_VOTER 
    (
        .I0(\FSM_sequential_cs_reg_TMR_0[0]_Q_VOTER ),
        .I1(\FSM_sequential_cs_reg_TMR_1[0]_Q_VOTER ),
        .I2(\FSM_sequential_cs_reg_TMR_2[0]_Q_VOTER ),
        .O(cs_TMR_2)
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[2]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[2]_Q_VOTER ),
        .I1(\count_reg_TMR_1[2]_Q_VOTER ),
        .I2(\count_reg_TMR_2[2]_Q_VOTER ),
        .O(count_reg_TMR_0[2])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[2]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[2]_Q_VOTER ),
        .I1(\count_reg_TMR_1[2]_Q_VOTER ),
        .I2(\count_reg_TMR_2[2]_Q_VOTER ),
        .O(count_reg_TMR_1[2])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[2]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[2]_Q_VOTER ),
        .I1(\count_reg_TMR_1[2]_Q_VOTER ),
        .I2(\count_reg_TMR_2[2]_Q_VOTER ),
        .O(count_reg_TMR_2[2])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[0]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[0]_Q_VOTER ),
        .I1(\count_reg_TMR_1[0]_Q_VOTER ),
        .I2(\count_reg_TMR_2[0]_Q_VOTER ),
        .O(count_reg_TMR_0[0])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[0]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[0]_Q_VOTER ),
        .I1(\count_reg_TMR_1[0]_Q_VOTER ),
        .I2(\count_reg_TMR_2[0]_Q_VOTER ),
        .O(count_reg_TMR_1[0])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[0]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[0]_Q_VOTER ),
        .I1(\count_reg_TMR_1[0]_Q_VOTER ),
        .I2(\count_reg_TMR_2[0]_Q_VOTER ),
        .O(count_reg_TMR_2[0])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[11]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[11]_Q_VOTER ),
        .I1(\count_reg_TMR_1[11]_Q_VOTER ),
        .I2(\count_reg_TMR_2[11]_Q_VOTER ),
        .O(count_reg_TMR_0[11])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[11]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[11]_Q_VOTER ),
        .I1(\count_reg_TMR_1[11]_Q_VOTER ),
        .I2(\count_reg_TMR_2[11]_Q_VOTER ),
        .O(count_reg_TMR_1[11])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[11]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[11]_Q_VOTER ),
        .I1(\count_reg_TMR_1[11]_Q_VOTER ),
        .I2(\count_reg_TMR_2[11]_Q_VOTER ),
        .O(count_reg_TMR_2[11])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[5]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[5]_Q_VOTER ),
        .I1(\count_reg_TMR_1[5]_Q_VOTER ),
        .I2(\count_reg_TMR_2[5]_Q_VOTER ),
        .O(count_reg_TMR_0[5])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[5]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[5]_Q_VOTER ),
        .I1(\count_reg_TMR_1[5]_Q_VOTER ),
        .I2(\count_reg_TMR_2[5]_Q_VOTER ),
        .O(count_reg_TMR_1[5])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[5]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[5]_Q_VOTER ),
        .I1(\count_reg_TMR_1[5]_Q_VOTER ),
        .I2(\count_reg_TMR_2[5]_Q_VOTER ),
        .O(count_reg_TMR_2[5])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[17]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[17]_Q_VOTER ),
        .I1(\count_reg_TMR_1[17]_Q_VOTER ),
        .I2(\count_reg_TMR_2[17]_Q_VOTER ),
        .O(count_reg_TMR_0[17])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[17]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[17]_Q_VOTER ),
        .I1(\count_reg_TMR_1[17]_Q_VOTER ),
        .I2(\count_reg_TMR_2[17]_Q_VOTER ),
        .O(count_reg_TMR_1[17])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[17]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[17]_Q_VOTER ),
        .I1(\count_reg_TMR_1[17]_Q_VOTER ),
        .I2(\count_reg_TMR_2[17]_Q_VOTER ),
        .O(count_reg_TMR_2[17])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[14]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[14]_Q_VOTER ),
        .I1(\count_reg_TMR_1[14]_Q_VOTER ),
        .I2(\count_reg_TMR_2[14]_Q_VOTER ),
        .O(count_reg_TMR_0[14])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[14]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[14]_Q_VOTER ),
        .I1(\count_reg_TMR_1[14]_Q_VOTER ),
        .I2(\count_reg_TMR_2[14]_Q_VOTER ),
        .O(count_reg_TMR_1[14])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[14]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[14]_Q_VOTER ),
        .I1(\count_reg_TMR_1[14]_Q_VOTER ),
        .I2(\count_reg_TMR_2[14]_Q_VOTER ),
        .O(count_reg_TMR_2[14])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[3]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[3]_Q_VOTER ),
        .I1(\count_reg_TMR_1[3]_Q_VOTER ),
        .I2(\count_reg_TMR_2[3]_Q_VOTER ),
        .O(count_reg_TMR_0[3])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[3]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[3]_Q_VOTER ),
        .I1(\count_reg_TMR_1[3]_Q_VOTER ),
        .I2(\count_reg_TMR_2[3]_Q_VOTER ),
        .O(count_reg_TMR_1[3])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[3]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[3]_Q_VOTER ),
        .I1(\count_reg_TMR_1[3]_Q_VOTER ),
        .I2(\count_reg_TMR_2[3]_Q_VOTER ),
        .O(count_reg_TMR_2[3])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[12]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[12]_Q_VOTER ),
        .I1(\count_reg_TMR_1[12]_Q_VOTER ),
        .I2(\count_reg_TMR_2[12]_Q_VOTER ),
        .O(count_reg_TMR_0[12])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[12]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[12]_Q_VOTER ),
        .I1(\count_reg_TMR_1[12]_Q_VOTER ),
        .I2(\count_reg_TMR_2[12]_Q_VOTER ),
        .O(count_reg_TMR_1[12])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[12]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[12]_Q_VOTER ),
        .I1(\count_reg_TMR_1[12]_Q_VOTER ),
        .I2(\count_reg_TMR_2[12]_Q_VOTER ),
        .O(count_reg_TMR_2[12])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[6]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[6]_Q_VOTER ),
        .I1(\count_reg_TMR_1[6]_Q_VOTER ),
        .I2(\count_reg_TMR_2[6]_Q_VOTER ),
        .O(count_reg_TMR_0[6])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[6]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[6]_Q_VOTER ),
        .I1(\count_reg_TMR_1[6]_Q_VOTER ),
        .I2(\count_reg_TMR_2[6]_Q_VOTER ),
        .O(count_reg_TMR_1[6])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[6]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[6]_Q_VOTER ),
        .I1(\count_reg_TMR_1[6]_Q_VOTER ),
        .I2(\count_reg_TMR_2[6]_Q_VOTER ),
        .O(count_reg_TMR_2[6])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[18]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[18]_Q_VOTER ),
        .I1(\count_reg_TMR_1[18]_Q_VOTER ),
        .I2(\count_reg_TMR_2[18]_Q_VOTER ),
        .O(count_reg_TMR_0[18])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[18]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[18]_Q_VOTER ),
        .I1(\count_reg_TMR_1[18]_Q_VOTER ),
        .I2(\count_reg_TMR_2[18]_Q_VOTER ),
        .O(count_reg_TMR_1[18])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[18]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[18]_Q_VOTER ),
        .I1(\count_reg_TMR_1[18]_Q_VOTER ),
        .I2(\count_reg_TMR_2[18]_Q_VOTER ),
        .O(count_reg_TMR_2[18])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[15]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[15]_Q_VOTER ),
        .I1(\count_reg_TMR_1[15]_Q_VOTER ),
        .I2(\count_reg_TMR_2[15]_Q_VOTER ),
        .O(count_reg_TMR_0[15])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[15]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[15]_Q_VOTER ),
        .I1(\count_reg_TMR_1[15]_Q_VOTER ),
        .I2(\count_reg_TMR_2[15]_Q_VOTER ),
        .O(count_reg_TMR_1[15])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[15]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[15]_Q_VOTER ),
        .I1(\count_reg_TMR_1[15]_Q_VOTER ),
        .I2(\count_reg_TMR_2[15]_Q_VOTER ),
        .O(count_reg_TMR_2[15])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[9]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[9]_Q_VOTER ),
        .I1(\count_reg_TMR_1[9]_Q_VOTER ),
        .I2(\count_reg_TMR_2[9]_Q_VOTER ),
        .O(count_reg_TMR_0[9])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[9]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[9]_Q_VOTER ),
        .I1(\count_reg_TMR_1[9]_Q_VOTER ),
        .I2(\count_reg_TMR_2[9]_Q_VOTER ),
        .O(count_reg_TMR_1[9])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[9]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[9]_Q_VOTER ),
        .I1(\count_reg_TMR_1[9]_Q_VOTER ),
        .I2(\count_reg_TMR_2[9]_Q_VOTER ),
        .O(count_reg_TMR_2[9])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \FSM_sequential_cs_reg_TMR_0[1]_Q_VOTER 
    (
        .I0(\FSM_sequential_cs_reg_TMR_0[1]_Q_VOTER ),
        .I1(\FSM_sequential_cs_reg_TMR_1[1]_Q_VOTER ),
        .I2(\FSM_sequential_cs_reg_TMR_2[1]_Q_VOTER ),
        .O(\FSM_sequential_cs_reg_n_0__TMR_0[1] )
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \FSM_sequential_cs_reg_TMR_1[1]_Q_VOTER 
    (
        .I0(\FSM_sequential_cs_reg_TMR_0[1]_Q_VOTER ),
        .I1(\FSM_sequential_cs_reg_TMR_1[1]_Q_VOTER ),
        .I2(\FSM_sequential_cs_reg_TMR_2[1]_Q_VOTER ),
        .O(\FSM_sequential_cs_reg_n_0__TMR_1[1] )
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \FSM_sequential_cs_reg_TMR_2[1]_Q_VOTER 
    (
        .I0(\FSM_sequential_cs_reg_TMR_0[1]_Q_VOTER ),
        .I1(\FSM_sequential_cs_reg_TMR_1[1]_Q_VOTER ),
        .I2(\FSM_sequential_cs_reg_TMR_2[1]_Q_VOTER ),
        .O(\FSM_sequential_cs_reg_n_0__TMR_2[1] )
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[4]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[4]_Q_VOTER ),
        .I1(\count_reg_TMR_1[4]_Q_VOTER ),
        .I2(\count_reg_TMR_2[4]_Q_VOTER ),
        .O(count_reg_TMR_0[4])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[4]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[4]_Q_VOTER ),
        .I1(\count_reg_TMR_1[4]_Q_VOTER ),
        .I2(\count_reg_TMR_2[4]_Q_VOTER ),
        .O(count_reg_TMR_1[4])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[4]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[4]_Q_VOTER ),
        .I1(\count_reg_TMR_1[4]_Q_VOTER ),
        .I2(\count_reg_TMR_2[4]_Q_VOTER ),
        .O(count_reg_TMR_2[4])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[7]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[7]_Q_VOTER ),
        .I1(\count_reg_TMR_1[7]_Q_VOTER ),
        .I2(\count_reg_TMR_2[7]_Q_VOTER ),
        .O(count_reg_TMR_0[7])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[7]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[7]_Q_VOTER ),
        .I1(\count_reg_TMR_1[7]_Q_VOTER ),
        .I2(\count_reg_TMR_2[7]_Q_VOTER ),
        .O(count_reg_TMR_1[7])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[7]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[7]_Q_VOTER ),
        .I1(\count_reg_TMR_1[7]_Q_VOTER ),
        .I2(\count_reg_TMR_2[7]_Q_VOTER ),
        .O(count_reg_TMR_2[7])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[1]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[1]_Q_VOTER ),
        .I1(\count_reg_TMR_1[1]_Q_VOTER ),
        .I2(\count_reg_TMR_2[1]_Q_VOTER ),
        .O(count_reg_TMR_0[1])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[1]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[1]_Q_VOTER ),
        .I1(\count_reg_TMR_1[1]_Q_VOTER ),
        .I2(\count_reg_TMR_2[1]_Q_VOTER ),
        .O(count_reg_TMR_1[1])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[1]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[1]_Q_VOTER ),
        .I1(\count_reg_TMR_1[1]_Q_VOTER ),
        .I2(\count_reg_TMR_2[1]_Q_VOTER ),
        .O(count_reg_TMR_2[1])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[16]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[16]_Q_VOTER ),
        .I1(\count_reg_TMR_1[16]_Q_VOTER ),
        .I2(\count_reg_TMR_2[16]_Q_VOTER ),
        .O(count_reg_TMR_0[16])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[16]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[16]_Q_VOTER ),
        .I1(\count_reg_TMR_1[16]_Q_VOTER ),
        .I2(\count_reg_TMR_2[16]_Q_VOTER ),
        .O(count_reg_TMR_1[16])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[16]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[16]_Q_VOTER ),
        .I1(\count_reg_TMR_1[16]_Q_VOTER ),
        .I2(\count_reg_TMR_2[16]_Q_VOTER ),
        .O(count_reg_TMR_2[16])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_0[13]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[13]_Q_VOTER ),
        .I1(\count_reg_TMR_1[13]_Q_VOTER ),
        .I2(\count_reg_TMR_2[13]_Q_VOTER ),
        .O(count_reg_TMR_0[13])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_1[13]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[13]_Q_VOTER ),
        .I1(\count_reg_TMR_1[13]_Q_VOTER ),
        .I2(\count_reg_TMR_2[13]_Q_VOTER ),
        .O(count_reg_TMR_1[13])
    );
    LUT3 #(
        .INIT(8'hE8)
    )
    \count_reg_TMR_2[13]_Q_VOTER 
    (
        .I0(\count_reg_TMR_0[13]_Q_VOTER ),
        .I1(\count_reg_TMR_1[13]_Q_VOTER ),
        .I2(\count_reg_TMR_2[13]_Q_VOTER ),
        .O(count_reg_TMR_2[13])
    );
endmodule

`celldefine
module LUT5
(
    I0,
    I1,
    I2,
    I3,
    I4,
    O
);

    input I0;
    input I1;
    input I2;
    input I3;
    input I4;
    output O;

endmodule
`endcelldefine

`celldefine
module CARRY4
(
    CI,
    CO,
    CYINIT,
    DI,
    O,
    S
);

    input CI;
    output [3:0]CO;
    input CYINIT;
    input [3:0]DI;
    output [3:0]O;
    input [3:0]S;

endmodule
`endcelldefine

