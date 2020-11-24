`timescale 1ns / 1ps

module tb_FIR_Filter_Time_Multiplexed;
    
    //Inputs
    reg CLK = 0;                            // Clock

    // Clock generation
    always #30 CLK <= ~CLK;

    // Instantiate DUT
    top  top( .CLK(CLK) );                  // Clock
    
endmodule
