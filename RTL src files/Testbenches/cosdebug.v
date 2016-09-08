`timescale 1ns / 1ps


module cosdebug();
    reg [15:0] u1;
    wire [15:0] g0;
    wire [15:0] g1;
    sincos dut( g0, g1, u1);

    initial begin
        u1 = 15'd17862;
        #5
        $finish;                 
    end
endmodule
