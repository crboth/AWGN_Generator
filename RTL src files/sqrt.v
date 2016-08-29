`timescale 1ns / 1ps
module sqrt(f, e);
    output wire [16:0] f;
    input wire [30:0] e;
    wire v;
    wire [4:0] numlzs;
    wire signed [6:0] exp_f;
    wire [5:0] exp_ft;
    wire [30:0] x_ft;
    wire [30:0] x_f;
    wire [6:0] xb;
    wire [23:0] xa;
    reg [11:0] c1_mem[0:127];
    reg [19:0] c0_mem[0:127];
    wire [11:0] c1;
    wire [19:0] c0;
    wire [41:0] xc1;
    wire [45:0] y_ft;
    wire [45:0] y_ftt;
    
    
    lzdetector #(31) lzd(numlzs, v, e);
    assign exp_f = 5 - numlzs;
    //Need to keep track of what Range reduction is doing
    shifter #(31) shift(x_ft, e, numlzs);
    assign x_f = exp_f[0]? x_ft>>1:x_ft;//What does this accomplish?
    assign xb = x_f[30:24];
    assign xa = x_f[23:0];
    
    assign c0 = c0_mem[xb];
    assign c1 = c1_mem[xb];
    assign xc1 = c1*xa; //24 bits[0-1) * 12 bits(6 lzs below decimal) =  36 bits(42 bits [0-1))
    
    assign y_ft = xc1 + {c0,{21{1'b0}}};//43bits [0-1.9) shouldn't exceed 1, padded to 46
    //assign exp_ft = (exp_f+1)>>1;
    assign exp_ft = ((exp_f+1)>>1)+13;
    //Need to left shift at most 3 and right shift at most 13
    //shift(-(exp_ft-3))?
    shifter #(46) shift2(y_ftt, y_ft, exp_ft);//may need to pad exp_ft with a 0
    assign f = y_ftt[28]? y_ftt[45:29]+1:y_ftt[45:29];
    //pad to 48
    //shift to a temp reg
    //round and output    
    //ft1 [38:0    ]
    //shift(ft,ft1,exp)
    //round
    //assign f = ft[43:27]?
    //assign exp_ft = exp_f[0]? (exp_f+1)>>1 : exp_f>>1;
    //dont need a ternary op as if the lsb is 0 adding 1 to it will just get the 1 shifted out immediatly. 
    //Just do the add no matter what and save on the mux/standardize the timing

    
    
    
    
    
     
    


initial begin
    $readmemh("../../../../MATLAB/sqrtc1h.txt", c1_mem);
    $readmemh("../../../../MATLAB/sqrtc0h.txt", c0_mem);
end

endmodule