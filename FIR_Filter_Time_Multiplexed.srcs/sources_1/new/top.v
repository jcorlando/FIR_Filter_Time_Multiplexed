`timescale 1ns / 1ps

module top # ( parameter ORDER = 3, WI = 2, WF = 6 )
(
    input CLK
);
    
    input_controller # ( .ORDER(ORDER), .WI(WI), .WF(WF) )
        x_input( .CLK(CLK), .out() );
    
    coeff_controller # ( .ORDER(ORDER), .WI(WI), .WF(WF) )
        coeff_out( .CLK(CLK), .out() );
    
    
    
    
    
    
endmodule

