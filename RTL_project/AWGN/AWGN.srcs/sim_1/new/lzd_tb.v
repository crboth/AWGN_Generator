`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2016 07:25:08 PM
// Design Name: 
// Module Name: lzd_tb
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


module lzd_tb();
    wire [5:0] p;
    wire v;
    reg [47:0] in;
    lzdetector #(48) dut(p, v, in);
    integer i;
    
    initial begin
    in = 0;
    #1
    if(p != 48) begin
        $display("p was %d when %d was expected", p, 48);
    end
    in = 1;
    for(i = 47; i >= 0; i = i-1) begin
        #1
        if(p != i) begin
            $display("p was %d when %d was expected", p, i);
        end
        in = in*2;
    end
    $finish;
    end
endmodule
