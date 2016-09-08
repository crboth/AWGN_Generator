`timescale 1ns / 1ps


module AWGN(
    output wire signed [15:0] awgn_out1,
    output wire signed [15:0] awgn_out2,
    input wire clk,
    input wire reset,
    input wire [31:0] urng_seed1,
    input wire [31:0] urng_seed2,
    input wire [31:0] urng_seed3,
    input wire [31:0] urng_seed4,
    input wire [31:0] urng_seed5,
    input wire [31:0] urng_seed6
    );
    wire [31:0] a;
    wire [31:0] b;
    wire [47:0] u0;
    wire [15:0] u1;
    wire [30:0] e;
    wire [16:0] f;
    wire signed [15:0] g0;
    wire signed [15:0] g1;
    wire signed [32:0] out1t;
    wire signed [32:0] out2t;

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
    
    
    assign out1t = $signed({1'b0,f})*g0;
    assign out2t = $signed({1'b0, f})*g1;
    assign awgn_out1 = out1t[32:17];
    assign awgn_out2 = out2t[32:17];
    
endmodule
