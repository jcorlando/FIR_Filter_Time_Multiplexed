`timescale 1ns / 1ps

module coeff_controller # ( parameter ORDER = 3, WI = 2, WF = 6 )
(
    input CLK,
    output reg [WI + WF - 1 : 0] out
);
    
    localparam CLK_BITS = $clog2(ORDER);
    reg [CLK_BITS - 1 : 0] divide_clock = 0;
    reg [7 : 0] h_coeff[0 : ORDER - 1];                     // h coefficients
    initial $readmemh("h.mem", h_coeff);                    // Initialize Inputs
    
    always @ ( posedge CLK ) if( divide_clock < (ORDER - 1) ) divide_clock <= divide_clock + 1;
                                else divide_clock <= 0;
    
    always @ (*) out <= h_coeff[divide_clock];
    
    
endmodule
