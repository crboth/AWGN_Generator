`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2016 06:42:45 PM
// Design Name: 
// Module Name: 2bitlzd
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


module twobitlzd(
    output p,
    output v,
    input a,
    input b
    );
    wire a;
    wire b;
    wire p;
    wire v;
    assign p = (!a)&b;
    assign v = a|b;
    
endmodule
