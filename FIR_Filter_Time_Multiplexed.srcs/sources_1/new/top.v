`timescale 1ns / 1ps

module top # ( parameter ORDER = 3, WI = 2, WF = 6, WL = WI + WF )
(
    input CLK
);
    
    input_controller # ( .ORDER(ORDER), .WI(WI), .WF(WF) )
        x_input( .CLK(CLK), .out() );
    
    coeff_controller # ( .ORDER(ORDER), .WI(WI), .WF(WF) )
        coeff_out( .CLK(CLK), .out() );
    
    mult_Fixed # ( .WI1(WI), .WF1(WF), .WI2(WI), .WF2(WF) )
        MAC_mult( .in1(x_input.out), .in2(coeff_out.out), .out() );
    
    
    MUX # ( .WL(WL + WL) ) MUX( .in(MAC_reg.out), .out() );
    
    
    add_Fixed # ( .WI1(WI + WI), .WF1(WF + WF), .WI2(WI + WI), .WF2(WF + WF), .WIO(WI + WI), .WFO(WF + WF) )
        MAC_add( .in1(MAC_mult.out), .in2(MUX.out), .out() );
    
    delay_register # ( .WL(WL + WL) )
        MAC_reg( .CLK(CLK), .in(MAC_add.out), .out() );
    
    
    
    reg answer_CLK = 0;
    localparam CLK_BITS = $clog2(ORDER);
    reg [CLK_BITS - 1 : 0] divide_clock = 0;
    always @ (posedge CLK)
    if( divide_clock < (ORDER - 1) )
    begin
        divide_clock <= divide_clock + 1;
        if( answer_CLK == 1 ) answer_CLK <= 0;
    end
    else
    begin
        divide_clock <= 0;
        answer_CLK <= ~answer_CLK;
    end
    
    delay_register # ( .WL(WL + WL) )
        Answer( .CLK(answer_CLK), .in(MAC_reg.out), .out() );
    
    
    
endmodule




