`timescale 1ns / 1ps
//piecewise polynomial approximation of sqrt()

module sqrtp(f, e);
    output wire [16:0] f;
    input wire [30:0] e;
    wire v;
    wire [4:0] numlzs;
    wire signed [6:0] exp_f;
    wire [5:0] exp_ft;
    wire [30:0] x_f;
    wire [6:0] xb;
    wire [23:0] xa;
    reg [11:0] c1_mem[0:127];
    reg [19:0] c0_mem[0:127];
    wire [11:0] c1;
    wire [19:0] c0;
    wire [41:0] xc1;
    wire [42:0] y_ft;
    wire [57:0] y_ftt;
    wire [16:0] ft;
    
    //determine the number of leading zeroes and shift them out
    lzdetector #(31) lzd(numlzs, v, e);
    //5-numlzs in the spec was changed to 6 to change the range from [1,3) to [1,2) 
    //this allows the indecies to always be the 7 bits following the leading 1, whereas the spec requires an additional shift if the range is within [2,3)
    assign exp_f = 6 - numlzs;
    shifter #(31) shift(x_f, e, numlzs);
    
    //xb[6] corresponds to +64 in the MATLAB simulation, it selects the sqrt(2x) coefficents when the exponent was odd valued
    assign xb[6] = exp_f[0];
    assign xb[5:0] = x_f[29:24];
    
    //piecewise approximation, taking into account the neccesary c0 offset from how it was quantized
    assign xa = x_f[23:0];   
    assign c0 = c0_mem[xb];
    assign c1 = c1_mem[xb];
    assign xc1 = c1*xa;    
    assign y_ft = xc1 + {c0,{23{1'b0}}};
    
    //to perform range reconstruction y_ft could be shifted either direction, since only an efficent left shifter was created,
    //the amount to shift is offset by the maximum possible right shift and afterwards bit selection is performed taking this into account
    assign exp_ft = exp_f[6:1]+12;
    
    //While this being set to 58 and generates a warning, it doesn't affect simulation
    shifter #(58) shift2(y_ftt, {{15{1'b0}}, y_ft}, exp_ft);
    
    //perform bitselection and rounding to get the desired output
    assign ft = y_ftt[40]? y_ftt[57:41]+1:y_ftt[57:41];
    
    //for the special case where the input was 0, set the ouput to 0 
    assign f = (e==0) ? 0 : ft;

initial begin
    $readmemh("../../../../MATLAB/sqrtc1h.txt", c1_mem);
    $readmemh("../../../../MATLAB/sqrtc0h.txt", c0_mem);
end

endmodule