`timescale 1ns / 1ps

//Approximation of the Sin and Cos functions

module cosp( g0, g1, u1);
    input wire [15:0] u1;
    output wire signed [15:0] g0;
    output wire signed [15:0] g1;
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
    wire [18:0] c1x_sin;
    wire [18:0] c1x_cos;
    wire [26:0] yt_cos;
    wire [26:0] yt_sin;
    wire signed [15:0] y_cos_sat;
    wire signed [15:0] y_sin_sat;
    wire [26:0] y_cos;
    wire [26:0] y_sin;
    wire signed [15:0] g0t;
    wire signed [15:0] g1t;
    
    //first two bits signify quadrant
    assign quad = u1[15:14];
    
    //remaining bits are used in the piecewise approximation
    assign index_bits = u1[13:0];
    
    //For quadrants 1 and 3 for cos, and 0 and 2 for sin, the x values need to be inverted
    //this would cause an error when all 14 bits are zero, as the desired x location is actually in the next quadrant
    //This is corrected at the end
    assign cos_bits = quad[0] ? 14'h4000-index_bits : index_bits;  
    assign sin_bits = quad[0] ? index_bits : 14'h4000-index_bits;
    
    //Bit selection for the index and x values
    assign cos_index = cos_bits[13:7];
    assign sin_index = sin_bits[13:7];
    assign xcos = cos_bits[7:0];
    assign xsin = sin_bits[7:0];
    
    //access the memory at the given index for both sin and cos
    assign c0_cos = c0_mem[cos_index];
    assign c1_cos = c1_mem[cos_index];
    assign c1_sin = c1_mem[sin_index];
    assign c0_sin = c0_mem[sin_index];
    
    //perform piecewise approximation
    assign c1x_cos = c1_cos*xcos;
    assign c1x_sin = c1_sin*xsin;
    assign yt_cos = {c0_cos,{7{1'b0}}} - c1x_cos;
    assign yt_sin = {c0_sin,{7{1'b0}}} - c1x_sin;
    
    //round
    assign y_cos = yt_cos[9] ? yt_cos+1 : yt_cos;
    assign y_sin = yt_sin[9] ? yt_sin+1 : yt_sin;
    
    //check for saturation
    assign y_cos_sat = y_cos[25] ? 16'h7FFF : y_cos[25:10];
    assign y_sin_sat = y_sin[25] ? 16'h7FFF : y_sin[25:10];

    //invert y value for neccesary quadrants
    assign g1t = quad[1]^quad[0] ? -y_cos_sat : y_cos_sat;
    assign g0t = quad[1] ? -y_sin_sat : y_sin_sat;
    
    //if all the bits were zero and inversion took place, set the ouput to zero to correct error
    assign g1 =  (quad[0]&(cos_bits == 0)) ? 16'b0 : g1t;
    assign g0 = (!quad[0]&(sin_bits == 0)) ? 16'b0 : g0t;

    initial begin
        $readmemh("../../../../MATLAB/cosc1h.txt", c1_mem);
        $readmemh("../../../../MATLAB/cosc0h.txt", c0_mem);
    end
endmodule
