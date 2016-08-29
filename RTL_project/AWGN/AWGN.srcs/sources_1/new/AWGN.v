`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2016 08:31:24 PM
// Design Name: 
// Module Name: AWGN
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


module AWGN(
    output [15:0] awgn_out1,
    output [15:0] awgn_out2,
    input clk,
    input reset,
    input [31:0] urng_seed1,
    input [31:0] urng_seed2,
    input [31:0] urng_seed3,
    input [31:0] urng_seed4,
    input [31:0] urng_seed5,
    input [31:0] urng_seed6
    );
    wire [31:0] a;
    wire [31:0] b;
    wire [47:0] u0;
    wire [15:0] u1;
    wire [30:0] e;
    wire [16:0] f;
    wire signed[17:0] _f;
    wire signed [15:0] g0;
    wire signed [15:0] g1;
    wire signed [15:0] awgn_out1;
    wire signed [15:0] awgn_out2;
    //can use a clock divider at the Taus and alternate between x0 and x1 every clock
    taus urng_a( a, clk, reset, urng_seed1, urng_seed2, urng_seed3);
    taus urng_b( b, clk, reset, urng_seed4, urng_seed5, urng_seed6);
    assign u0 = {a,b[31:16]};
    assign u1 = b[15:0];
    
    //log module
    log log_module(e, u0);
    
    //sqrt module
    sqrt sqrt_module(f, e);
    
    //cos module
    sincos cos_module(g0, g1, u1);
    
    //still need to bit select appropriatly
    assign awgn_out1 = f*g0;
    assign awgn_out2 = f*g1;
endmodule
