`timescale 1ns / 1ps

module tb_FIR_Filter_Time_Multiplexed;
    
    //Inputs
    reg CLK = 0;                            // Clock

    // Clock generation
    always #15 CLK <= ~CLK;

    // Instantiate DUT
    top  # (.ORDER(3))
        top( .CLK(CLK) );                  // Clock
    
endmodule
