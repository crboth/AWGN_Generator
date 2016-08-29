`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2016 05:25:57 AM
// Design Name: 
// Module Name: lndebug
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
