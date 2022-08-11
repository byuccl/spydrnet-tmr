`timescale 1ns / 1ps
/***************************************************************************
* Module: simpleCounter
*
* Author: Ethan Monlux
* Date: 3/29/2022
* Description: Debounced Counter that increments once
*
****************************************************************************/


module simpleCounter(

    //Types and directions of ports
    input wire logic clk,
    input wire logic btnu,
    input wire logic btnc,
    output logic [3:0] led
    );
    
    //Internal signals for debounceCounter_top module
    logic f1, f2, one_shot_1, one_shot_2, enable, out;

     
    //Instance of DebounceCounter Finite-State-Machine
    debounceCounter my_debounceCounter(.clk(clk), .reset(btnu), .noisy(f2), .debounced(out));
    
    //Synchronizer
    always_ff @(posedge clk)
          f1<=btnc;     
    always_ff @(posedge clk)
          f2<=f1;

    //One shot detector
    always_ff @(posedge clk)
        one_shot_1<=out;
    always_ff @(posedge clk)
        one_shot_2<=one_shot_1;         
    and(enable, one_shot_1, ~one_shot_2);
    
    //Debounced counter
    always_ff @(posedge clk)
        if(btnu)
            led<=0;
        else if(enable)
            led<=led+1;
            
endmodule 
            

module debounceCounter(

    //Types and directions of ports
    input wire logic clk, 
    input wire logic reset, 
    input wire logic noisy,
    output logic debounced
    );

    //Defining the state register
    typedef enum logic [1:0] {S0,S1,S2,S3,ERR='X} StateType;
    StateType ns,cs;
    
    //Internal signals for debounce module
    logic timerDone, clrTimer;
    
    //State machine
    always_comb
        begin
            //Default assignments     
            ns=ERR;
            clrTimer=0;
            debounced=0;
            
            if(reset)
                ns=S0;
            else 
                case (cs)
                
                    //IDLE state
                    S0: 
                        begin
                            clrTimer=1;
                            if(noisy)
                                ns=S1;
                            else if(~noisy)
                                ns=S0; 
                        end  
                        
                    //Signal is noisy and stays noisy until the timer is done
                    S1: 
                        if(~noisy)
                            ns=S0;
                        else if (noisy&&timerDone)
                            ns=S2;
                        else if(noisy&&~timerDone)
                            ns=S1;  
                            
                    //The signal is debounced                   
                    S2: 
                        begin
                            debounced=1;
                            clrTimer=1;
                            if(~noisy)
                                ns=S3;
                            else if(noisy)
                                ns=S2;
                        end
                        
                    //Signal is not noisy and waits for timer to be done then goes to IDLE state
                    S3: 
                        begin
                            debounced=1;
                            if(noisy)
                                ns=S2;
                            else if(~noisy&&timerDone)
                                ns=S0;
                            else if(~noisy&&~timerDone)
                                ns=S3;    
                        end
                
                endcase
                
        end
            
    //State register
    always_ff @(posedge clk)
        cs<=ns;
    
    //Internal signal for count
    logic [18:0] count;
    
    //Timer has run for 5ms
    assign timerDone = (count==(500000-1));
    
        //Timer    
        always_ff @(posedge clk)
        if(clrTimer)
            count<=0;
        else 
            count<=count+1;  
            
endmodule

