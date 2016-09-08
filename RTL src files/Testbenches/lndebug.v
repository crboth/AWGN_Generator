`timescale 1ns / 1ps


module lndebug();
    reg [47:0] u0;
    wire [30:0] e;
    log dut( e, u0);

    initial begin
        u0 = 48'd27633567797105;
        #5
        $finish;                 
    end
endmodule
