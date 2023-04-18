`default_nettype none
`timescale 1ns / 1ps
/***************************************************************************
*
* Module: VLineDrawer
* Author: Ethan Monlux
* Description: Draws the paddles for the pong game
*
****************************************************************************/

module VLineDrawer (
    input wire logic            clk,
    input wire logic            reset,
    input wire logic            start,
    input wire logic    [7:0]   height,
    output logic                draw,
    output logic                done,
    input wire logic    [8:0]   x_in,
    input wire logic    [7:0]   y_in,
    output logic        [8:0]   x_out,
    output logic        [7:0]   y_out
);

logic lineDone, resetCount,startCount;
logic [7:0] count;

assign lineDone = (count==(height-1));

always_ff @(posedge clk)
    if(resetCount)
        count<=0;
    else if(startCount)
        count<=count+1;        

assign x_out=x_in;
assign y_out=y_in+count;
    

//State register
typedef enum logic [2:0] {Idle,DrawLine,delay,Finished,ERR='X} StateType;
StateType ns,cs;  

 //finite State Machine
    always_comb
        begin
            //default assignments     
            ns = ERR;
            draw=0;
            resetCount=0;
            done=0;
            startCount=0;
            
            if(reset)
                ns=Idle;          
            else 
                case (cs)

                    Idle: 
                        if(~start)
                            ns=Idle;
                        else
                            begin
                                resetCount=1;
                                ns=DrawLine;
                            end
                            
                    DrawLine:   
                        begin 
                            startCount=1;                           
                            if(~lineDone)
                                begin   
                                    draw=1;                                 
                                    ns=DrawLine;
                                end
                            else      
                            begin
                                    done=1;                     
                                    ns=Finished; 
                                    end                    
                        end
                 
                    Finished: 
                    begin
                        if(start)
                            ns=Finished;
                        else 
                            ns=Idle;                        
                     end
                endcase
            end
       
 //State register    
always_ff @(posedge clk)
        cs<=ns;        

endmodule