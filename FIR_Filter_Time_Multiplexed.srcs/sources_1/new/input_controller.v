`timescale 1ns / 1ps

module input_controller # ( parameter ORDER = 3, WI = 2, WF = 6 )
(
    input CLK,
    output reg [WI + WF - 1 : 0] out
);
    localparam CLK_BITS = $clog2(ORDER);
    reg [2 : 0] index = 0;
    reg [1 : 0] end_of_index = 0;
    reg [CLK_BITS - 1 : 0] divide_clock = 0;
    reg [WI + WF - 1 : 0] x_input[0 : 3];       // Input x values
    initial $readmemh("x.mem", x_input);        // Initialize Inputs
    
    always @ ( posedge CLK )
    begin
        if( divide_clock < (ORDER - 1) ) divide_clock <= divide_clock + 1;
        else
        begin
            if( index < 3 ) index <= index + 1;
            if( index >= 3 && end_of_index < 3 ) end_of_index <= end_of_index + 1;
            divide_clock <= 0;
        end
    end
    
    
    always @ (*)
    begin
        if( (index - divide_clock) > index ) out <= 0;
        else if( (end_of_index > 0) && (divide_clock < end_of_index) )  out <= 0;
        else if( (end_of_index > 0) && (divide_clock >= end_of_index) ) out <= x_input[index - divide_clock + end_of_index];
        else out <= x_input[index - divide_clock];
    end
    
    
    
endmodule







