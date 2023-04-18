/***************************************************************************
* Module: top_pong
*
* Author: Jeff Goeders
* Date: May 13, 2019
*
* Description: Game and drawing logic for 320x240 pong game
****************************************************************************/

`default_nettype none

module Pong (
    input wire logic        clk,
    input wire logic        reset,

    input wire logic        LPaddleUp,
    input wire logic        LPaddleDown,
    input wire logic        RPaddleUp,
    input wire logic        RPaddleDown,

    output logic    [8:0]   vga_x,
    output logic    [7:0]   vga_y,
    output logic    [2:0]   vga_color,
    output logic            vga_wr_en,

    output logic    [7:0]   P1score,
    output logic    [7:0]   P2score
);

localparam              PADDLE_H = 40; // paddle height
localparam              PADDLE_X_PAD = 10; // paddle distance from edge
localparam              PADDLE_DY = 2; // paddle move distance
localparam              BALL_W = 3; // ball width and height
localparam              BALL_H = 3;
localparam              VGA_W = 320; // screen width and height
localparam              VGA_H = 240;
localparam              TICK = 32'd1_000_000;  // 1,000,000 = 1/100th second

localparam BACK_CLR = 3'b000; // colors
localparam BALL_CLR = 3'b100;
localparam PADL_CLR = 3'b010;
localparam PADR_CLR = 3'b001;

// clear screen signals
logic           [8:0]   clearX;
logic           [7:0]   clearY;

// ball drawer signals
logic           [8:0]   ballDrawX;
logic           [7:0]   ballDrawY;
logic                   ballStart;
logic                   ballDone;
logic                   ballDrawEn;

// line drawer for paddles
logic           [8:0]   lineX, lineDrawX;
logic           [7:0]   lineY, lineDrawY;
logic                   lineStart;
logic                   lineDone;
logic                   lineDrawEn;

// location of ball, paddles
logic           [8:0]   ballX;
logic           [7:0]   ballY;
logic           [7:0]   LPaddleY;
logic           [7:0]   RPaddleY;

// velocity of ball
logic                   ballMovingRight;
logic                   ballMovingDown;

// delay counter
logic           [31:0]  timerCount;
logic                   timerDone;
logic                   timerRst;

logic                   initGame;
logic                   moveAndScore;
logic                   erasing;
logic                   invertErasing;


////////////////// Game Loop Timer //////////////////
always_ff @(posedge clk) begin
    if (timerRst)
        timerCount <= 0;
    else
        timerCount <= timerCount + 1;
end
assign timerDone = (timerCount == TICK);

////////////////// Erasing //////////////////
always_ff @(posedge clk)
    if (reset)
        erasing <= 0;
    else if (invertErasing)
        erasing <= !erasing;

////////////////// Ball Location //////////////////
always_ff @(posedge clk) begin
    if (initGame) begin
        // Ball location on reset
        ballX <= (VGA_W / 2);
        ballY <= (VGA_H / 2);

    end else if (moveAndScore) begin
        // Update ball location
        if (ballMovingRight)
            ballX <= ballX + 1'b1;
        else
            ballX <= ballX - 1'b1;

        if (ballMovingDown)
            ballY <= ballY + 1'b1;
        else
            ballY <= ballY - 1'b1;
    end
end

////////////////// Paddle Locations //////////////////
always_ff @(posedge clk) begin
    if (initGame) begin
        // Paddle locations on reset
        LPaddleY <= (VGA_H - PADDLE_H) / 2;
        RPaddleY <= (VGA_H - PADDLE_H) / 2;

    end else if (moveAndScore) begin
        // Update paddle1 location
        if (LPaddleUp) begin
            if (LPaddleY < PADDLE_DY)
                LPaddleY <= 0;
            else
                LPaddleY <= LPaddleY - PADDLE_DY;

        end else if (LPaddleDown) begin
            if (LPaddleY > (VGA_H - PADDLE_H - PADDLE_DY))
                LPaddleY <= VGA_H - PADDLE_H;
            else
                LPaddleY <= LPaddleY + PADDLE_DY;
        end

        // Update paddle2 location
        if (RPaddleUp) begin
            if (RPaddleY < PADDLE_DY)
                RPaddleY <= 0;
            else
                RPaddleY <= RPaddleY - PADDLE_DY;
        end else if (RPaddleDown) begin
            if (RPaddleY > (VGA_H - PADDLE_H - PADDLE_DY))
                RPaddleY <= VGA_H - PADDLE_H;
            else
                RPaddleY <= RPaddleY + PADDLE_DY;
        end
    end
end

////////////////// Player Score //////////////////
always_ff @(posedge clk) begin
    if (initGame) begin
        P1score <= 0;
        P2score <= 0;
    end else if (moveAndScore && ballX == 0) 
        P2score <= P2score + 1;
    else if (moveAndScore && ballX == (VGA_W - BALL_W))
        P1score <= P1score + 1;     
end

////////////////// Ball Direction //////////////////
always_ff @(posedge clk) begin
    if (initGame) begin
        ballMovingRight <= 1;
        ballMovingDown <= 1;
    end else begin
        // Ball hits left wall
        if (ballX == 0) begin
            ballMovingRight <= 1;
        // Ball hits right wall
        end else if (ballX == (VGA_W - BALL_W)) begin
            ballMovingRight <= 0;


        // Ball hits left paddle
        end else if (ballX == PADDLE_X_PAD + 1 &&
                (ballY + BALL_H) > LPaddleY &&
                ballY < (LPaddleY + PADDLE_H)) begin
                if(ballMovingRight==0)
            ballMovingRight <= 1;           
            
        // Ball hits right paddle
        end else if (ballX == (VGA_W - PADDLE_X_PAD - 1 - BALL_W) &&
                (ballY + BALL_H) > RPaddleY &&
                ballY < (RPaddleY + PADDLE_H)) begin
                if(ballMovingRight==1)
            ballMovingRight <= 0; 
        end

        // Ball hits top or bottom wall
        if (ballY == 0)begin
            ballMovingDown <= 1;
        end else if (ballY == (VGA_H - BALL_H))begin
            ballMovingDown <= 0;
        end    
            
    end
end

////////////////// State Machine //////////////////
//
// This implements the game loop:
//
//      Draw Ball/Paddles --> Wait --> Erase Ball/Paddles --> Move Ball/Paddles -|
//      ^                                                                        |
//      |----------------------PADDLE_H--------------------------------------------------|
//
typedef enum{
    INIT,
    BALL,
    PADDLE_L,
    PADDLE_R,
    WAIT_TIMER,
    MOVE,
    ERR = 'X
    } StateType;
StateType cs, ns;

always_ff @(posedge clk)
    if (reset)
        cs <= INIT;
    else
        cs <= ns;

always_ff @(posedge clk)
    if (reset) begin
        clearX <= 0;
        clearY <= 0;
    end else if (cs == INIT)
        if (clearX == VGA_W-1) begin
            clearX <= 0;
            clearY <= clearY+1;
        end else
            clearX <= clearX+1;

always_comb begin
    ns = ERR;
    timerRst = 0;
    invertErasing = 0;
    ballStart = 0;
    lineStart = 0;
    lineX = 0;
    lineY = 0;
    vga_x = 0;
    vga_y = 0;
    vga_wr_en = 0;
    vga_color = BACK_CLR;
    moveAndScore = 0;
    initGame = 0;

    case (cs)
        INIT: begin
            if (clearX == VGA_W-1 && clearY == VGA_H-1)
                ns = PADDLE_L;
            else
                ns = INIT;
            vga_x = clearX;
            vga_y = clearY;
            vga_wr_en = 1'b1;
            initGame = 1'b1;
        end
        PADDLE_L: begin
            if (lineDone)
                ns = BALL;
            else begin
                ns = PADDLE_L;
                lineStart = 1'b1;
            end
            vga_x = lineDrawX;
            vga_y = lineDrawY;
            vga_wr_en = lineDrawEn;
            if (!erasing)
                vga_color = PADL_CLR;
            lineX = PADDLE_X_PAD;
            lineY = LPaddleY;
        end
        BALL: begin
            if (ballDone)
                ns = PADDLE_R;
            else begin
                ns = BALL;
                ballStart = 1'b1;
            end
            vga_x = ballDrawX;
            vga_y = ballDrawY;
            vga_wr_en = ballDrawEn;
            if (!erasing)
                vga_color = BALL_CLR;
        end
        PADDLE_R: begin
            if (lineDone && erasing) begin
                ns = MOVE;
                invertErasing = 1'b1;
            end else if (lineDone && !erasing) begin
                ns = WAIT_TIMER;
                timerRst = 1'b1;
                invertErasing = 1'b1;
            end else begin
                ns = PADDLE_R;
                lineStart = 1'b1;
            end
            vga_x = lineDrawX;
            vga_y = lineDrawY;
            vga_wr_en = lineDrawEn;
            if (!erasing)
                vga_color = PADR_CLR;
            lineX = VGA_W - PADDLE_X_PAD - 1;
            lineY = RPaddleY;
        end
        WAIT_TIMER:
            if (timerDone)
                ns = PADDLE_L;
            else
                ns = WAIT_TIMER;
        MOVE: begin
            ns = PADDLE_L;
            moveAndScore = 1'b1;
        end
    endcase
end

////////////////// Drawing Submodules //////////////////
BallDrawer BallDrawer_inst (
    .clk(clk),
    .reset(reset),
    .draw(ballDrawEn),
    .start(ballStart),
    .done(ballDone),
    .x_in(ballX),
    .y_in(ballY),
    .x_out(ballDrawX),
    .y_out(ballDrawY)
);

VLineDrawer VLineDrawer_inst (
    .clk(clk),
    .reset(reset),
    .start(lineStart),
    .draw(lineDrawEn),
    .done(lineDone),
    .x_in(lineX),
    .y_in(lineY),
    .x_out(lineDrawX),
    .y_out(lineDrawY),
    .height(PADDLE_H)
);

endmodule