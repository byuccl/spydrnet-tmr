`default_nettype none
`timescale 1ns / 1ps
/***************************************************************************
*
* Module: <module Name>
*
* Author: Ethan Monlux
* Class: ECEN 220, Section 1, Winter 2022
* Date: <Date file was created>
*
* Description: <Provide a brief description of what this SystemVerilog file does>
*
*
****************************************************************************/



module BallDrawer (
    input wire logic            clk,
    input wire logic            reset,
    input wire logic            start,
    output logic                draw,
    output logic                done,
    input wire logic    [8:0]   x_in,
    input wire logic    [7:0]   y_in,
    output logic        [8:0]   x_out,
    output logic        [7:0]   y_out
);

logic [1:0] x;
logic [1:0] y;

assign x_out=x_in+x;
assign y_out=y_in+y;
                
//State register
typedef enum logic [3:0] {Idle,P1,P2,P3,P4,P5,P6,P7,P8,P9,Finished,ERR='X} StateType;
StateType ns,cs;  

 //finite State Machine
    always_comb
        begin
            //default assignments     
            ns = ERR;
            draw=0;
            done=0;
            x=0;
            y=0;
            
            if(reset)
                ns=Idle;          
            else 
                case (cs)

                    Idle: 
                        if(~start)
                            ns=Idle;
                        else
                            
                            ns=P1;
                            
                    P1:
                        begin
                        x=0;
                        y=0;
                        draw=1;
                        ns=P2;
                        end
                        
                    P2:
                        begin
                        x=1;
                        y=0;
                        draw=1;
                        ns=P3;
                        end
                    P3:
                        begin
                        x=2;
                        y=0;
                        draw=1;
                        ns=P4;
                        end
                    P4:
                        begin
                        x=0;
                        y=1;
                        draw=1;
                        ns=P5;
                        end  
                    P5:
                        begin
                        x=1;
                        y=1;
                        draw=1;
                        ns=P6;
                        end    
                     P6:
                        begin
                        x=2;
                        y=1;
                        draw=1;
                        ns=P7;
                        end  
                        
                     P7:
                        begin
                        x=0;
                        y=2;
                        draw=1;
                        ns=P8;
                        end  
                     P8:
                        begin
                        x=1;
                        y=2;
                        draw=1;
                        ns=P9;
                        end    
                     P9:
                        begin
                        x=2;
                        y=2;
                        draw=1;
                        ns=Finished;
                        done=1;
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

