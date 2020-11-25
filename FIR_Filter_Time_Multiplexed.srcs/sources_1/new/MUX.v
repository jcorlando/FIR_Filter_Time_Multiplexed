`timescale 1ns / 1ps

module MUX # ( parameter WL = 16 )
(
    input [WL - 1 : 0] in,
    output [WL - 1 : 0] out
);
    
    assign out = top.answer_CLK ? 0 : top.MAC_reg.out;
    
    
endmodule
