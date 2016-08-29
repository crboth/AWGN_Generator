`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2016 09:52:36 PM
// Design Name: 
// Module Name: mult
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


module mult #(
  parameter out_len = 32,
  parameter out_frac_len = 0,
  parameter a_len = 16,
  parameter a_frac_len = 0,
  parameter b_len = 16,
  parameter b_frac_len = 0,
  parameter is_signed = 0
  ) (
    output [out_len-1:0] out,
    input [a_len-1:0] a,
    input [b_len-1:0] b
    );
  
  if(is_signed) begin
    wire signed [a_len+b_len-1:0] temp;
    assign temp = $signed(a)*$signed(b);
  end
  else begin
    wire [a_len+b_len-1:0] temp;
    assign temp = a*b;
  end
  if(a_frac_len+b_frac_len > out_frac_len) begin
    integer diff = a_frac_len+b_frac_len-out_frac_len;
  end
endmodule
