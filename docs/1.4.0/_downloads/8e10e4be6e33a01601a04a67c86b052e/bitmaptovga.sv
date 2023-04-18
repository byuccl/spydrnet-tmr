/***************************************************************************
*
* Module: BitmapToVga
*
* Author: Jeff Goeders
* Date: May 13, 2019
*
* Description: Stores a 320x240 RGB bitmap (1 bit per color), and outputs
*              a scaled up image as 640x480 video over the VGA outputs.
*
****************************************************************************/
`default_nettype none

module BitmapToVga (
    input wire logic            clk,
    input wire logic            clk_vga,
    input wire logic            reset,
    input wire logic    [8:0]   x,
    input wire logic    [7:0]   y,
    input wire logic    [2:0]   color,
    input wire logic            wr_en,
    output logic        [3:0]   VGA_R,
    output logic        [3:0]   VGA_G,
    output logic        [3:0]   VGA_B,
    output logic                VGA_hsync,
    output logic                VGA_vsync
);

// Configuration of VGA Timing information
localparam V_PIXELS             = 10'd480;
localparam V_SYNC_START         = V_PIXELS + 14 - 1;
localparam V_SYNC_END           = V_SYNC_START + 2 - 1;
localparam V_TOTAL              = 10'd525;

localparam H_PIXELS             = 10'd640;
localparam H_SYNC_START         = H_PIXELS + 20 - 1;
localparam H_SYNC_END           = H_SYNC_START + 96 - 1;
localparam H_TOTAL              = 10'd800;

// horizontal and vertical counters
logic   [9:0]   hcount;
logic   [9:0]   vcount;

// Data read from bitmap memory
logic   [2:0]   rd_data;

// Logic to control when h/v counters are reset
logic           hcount_clear;
logic           vcount_clear;

assign hcount_clear = (hcount == (H_TOTAL - 1));
assign vcount_clear = (vcount == (V_TOTAL - 1));

// VGA Colors are taken from bitmap memory when h/v count is within drawable area
// 0 when outside drawable area
always_comb begin
    integer index;
    index = 0;
    if (hcount < H_PIXELS && vcount < V_PIXELS) begin
        for (index = 0; index < 4; index = index + 1) begin
            VGA_R[index] = rd_data[2];
            VGA_G[index] = rd_data[1];
            VGA_B[index] = rd_data[0];
        end
    end else begin
        VGA_R = 4'b0000;
        VGA_B = 4'b0000;
        VGA_G = 4'b0000;
    end
end

// hcount
always_ff @(posedge clk_vga) begin
    if (reset)
        hcount <= 10'b0;
    else if (hcount_clear)
        hcount <= 10'b0;
    else
        hcount <= hcount + 1;
end

// vcount
always_ff @(posedge clk_vga) begin
    if (reset)
        vcount <= 10'b0;
    else if (vcount_clear && hcount_clear)
        vcount <= 0;
    else if (hcount_clear)
        vcount <= vcount + 1;
end

// VGA_hsync/VGA_vsync
always_ff @(posedge clk_vga) begin
    VGA_hsync <= ~((hcount >= H_SYNC_START) && (hcount <= H_SYNC_END));
    VGA_vsync <= ~((vcount >= V_SYNC_START) && (vcount <= V_SYNC_END));
end

VgaRam VgaRam_inst (
    .clk_user(clk),
    .clk_vga(clk_vga),
    .ena(1'b1),
    .enb(1'b1),
    .wr_en(wr_en),
    .wr_addr({y, x}), // can address up to 512x256
    .rd_addr({vcount[8:1], hcount[9:1]}),
    .wr_data(color),
    .rd_data(rd_data)
);

endmodule

module VgaRam (
    input wire logic            clk_user,
    input wire logic            clk_vga,
    input wire logic            ena,
    input wire logic            enb,
    input wire logic            wr_en,
    input wire logic    [16:0]  wr_addr,
    input wire logic    [16:0]  rd_addr,
    input wire logic    [2:0]   wr_data,
    output logic        [2:0]   rd_data
);

reg     [2:0]   ram [122879:0];  // 512x240

always_ff @(posedge clk_user)
    if (ena)
        if (wr_en)
            ram[wr_addr] <= wr_data;

always_ff @(posedge clk_vga)
    if (enb)
        rd_data <= ram[rd_addr];

endmodule