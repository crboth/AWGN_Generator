`timescale 1ns / 1ps


module AWGN_Pipelined(
    output wire signed [15:0] awgn_out,
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
    reg [47:0] u0_reg;
    wire [15:0] u1;
    reg [15:0] u1_reg;
    wire [30:0] e;
    reg [30:0] e_reg;
    wire [16:0] f;
    reg [16:0] f_reg;
    wire signed [15:0] g0;
    reg signed [15:0] g0_reg;
    reg signed [15:0] g0_reg2;
    wire signed [15:0] g1;
    reg signed [15:0] g1_reg;
    reg signed [15:0] g1_reg2;
    wire signed [32:0] x0;
    reg signed [15:0] x0_reg;
    wire signed [32:0] x1;
    reg signed [15:0] x1_reg;
    reg half_clk;
    reg out_select;
    
    //can use a clock divider at the Taus and alternate between x0 and x1 every clock
    taus urng_a( a, half_clk, reset, urng_seed1, urng_seed2, urng_seed3);
    taus urng_b( b, half_clk, reset, urng_seed4, urng_seed5, urng_seed6);
    
    assign u0 = {a,b[31:16]};
    assign u1 = b[15:0];
    
    //log module
    log log_module(e, u0_reg);
    
    //sqrt module
    sqrt sqrt_module(f, e_reg);
    
    //cos module
    sincos cos_module(g0, g1, u1_reg);
    
    
    assign x0 = $signed({1'b0, f_reg})*g0_reg2;
    assign x1 = $signed({1'b0, f_reg})*g1_reg2;
    
    assign awgn_out = out_select ? x1_reg : x0_reg;

    //as we can output two noise samples for every f value, we need the output clock to be twice as fast as the pipeline clock to switch between samples
    //While initial statements cannot be synthesized, it does not matter which value half_clk and out_select start with in a real implimentation
    //The only difference is which order (x0 or x1 first) that the noise samples come out in
    //attempting to add synthesisable reset behavior to these signals comes with significant overhead
    initial begin
        half_clk = 0;
        out_select = 1;
    end
    
    always@(posedge clk)begin
        half_clk <= !half_clk;  
        out_select <= !out_select;    

    end
    
    always@(posedge half_clk)begin
        u0_reg <= u0;
        u1_reg <= u1;
        e_reg <= e;
        f_reg <= f;
        g0_reg <= g0;
        g1_reg <= g1;
        //As u0 and u1 and their following operations are independant, we dont need to keep the two paths in sync
        //however that would require regenerating the simulation data to include the 1 clk cycle offset
        //instead an extra pipeline stage is added for g0 and g1 to keep them in sync with f
        g0_reg2 <= g0_reg;
        g1_reg2 <= g1_reg;
        x1_reg <= x1[32:17];
        x0_reg <= x0[32:17];
    end
endmodule
