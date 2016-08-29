`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2016 08:31:24 PM
// Design Name: 
// Module Name: sincos
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


module sincos( g0, g1, u1);
    input wire [15:0] u1;
    output wire [15:0] g0;
    output wire [15:0] g1;
    wire [1:0] quad;
    wire [13:0] index_bits;
    wire [13:0] cos_bits;
    wire [13:0] sin_bits;
    wire [6:0] cos_index;
    wire [6:0] sin_index;
    wire [6:0] xcos;
    wire [6:0] xsin;
    reg [11:0] c1_mem[0:127];
    reg [18:0] c0_mem[0:127];
    wire [11:0] c1_cos;
    wire [18:0] c0_cos;
    wire [11:0] c1_sin;
    wire [18:0] c0_sin;
    wire [32:0] yt_cos;
    wire [32:0] yt_sin;
    wire signed [32:0] y_cos;
    wire signed [32:0] y_sin;
    
    assign quad = u1[15:14];
    assign index_bits = u1[13:0];
    assign cos_bits = quad[0] ? 14'h3fff-index_bits : index_bits;  
    assign sin_bits = quad[0] ? index_bits : 14'h3fff-index_bits;
    assign cos_index = cos_bits[13:7];
    assign sin_index = sin_bits[13:7];
    assign xcos = cos_bits[7:0];
    assign xsin = sin_bits[7:0];
    
    assign c0_cos = c0_mem[cos_index];
    assign c1_cos = c1_mem[cos_index];
    assign c1_sin = c1_mem[sin_index];
    assign c0_sin = c0_mem[sin_index];
    
    assign yt_cos = {c0_cos,{14{1'b0}}} - c1_cos*xcos;
    assign yt_sin = {c0_sin,{14{1'b0}}} - c1_sin*xsin;
    
    //assign y_cos = quad[1]^quad[0] ? {33{1'b1}}-yt_cos : yt_cos;
   // assign y_sin = quad[1] ? {33{1'b1}}-yt_sin : yt_sin;
    assign y_cos = quad[1]^quad[0] ? -yt_cos : yt_cos;
    assign y_sin = quad[1] ? -yt_sin : yt_sin;
    assign g1 = y_cos[16] ? y_cos[32:17]+1:y_cos[32:17];
    assign g0 = y_sin[16] ? y_sin[32:17]+1:y_sin[32:17];
    initial begin
        $readmemh("../../../../MATLAB/cosc1h.txt", c1_mem);
        $readmemh("../../../../MATLAB/cosc0h.txt", c0_mem);
    end
endmodule
