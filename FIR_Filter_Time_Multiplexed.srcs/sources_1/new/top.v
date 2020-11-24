`timescale 1ns / 1ps

module top # ( parameter ORDER = 3, WI = 2, WF = 6 )
(
    input CLK
);
    
    reg [7 : 0] h_coeff[0 : ORDER - 1];                     // h coefficients
    initial $readmemh("h.mem", h_coeff);                    // Initialize Inputs
    
    input_controller # ( .ORDER(ORDER), .WI(WI), .WF(WF) )
        x_input( .CLK(CLK), .out() );
    
    
    
    
endmodule

