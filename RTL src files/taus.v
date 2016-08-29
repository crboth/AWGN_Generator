`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2016 08:31:24 PM
// Design Name: 
// Module Name: taus
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


module taus(
    output [31:0] urng,
    input clk,
    input reset,
    input [31:0] urng_seed1,
    input [31:0] urng_seed2,
    input [31:0] urng_seed3 
    );
    
    reg [31:0] s0;
    reg [31:0] s1;
    reg [31:0] s2;
    wire [31:0] next_s0;
    wire [31:0] next_s1;
    wire [31:0] next_s2;
    
    assign next_s0 = {s0[19:1], s0[18:6]^s0[31:19]};
    assign next_s1 = {s1[27:3], s1[29:23]^s1[31:25]};
    assign next_s2 = {s2[14:4], s2[28:8]^s2[31:11]};
    assign urng = next_s0^next_s1^next_s2;
    
    always@(posedge clk or posedge reset)begin
        if(!reset) begin
            s0 <= next_s0;
            s1 <= next_s1;
            s2 <= next_s2;
        end
        else begin
            s0 <= urng_seed1;
            s1 <= urng_seed2;
            s2 <= urng_seed3;
        end     
    end  
endmodule
