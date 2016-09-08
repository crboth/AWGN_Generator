`timescale 1ns / 1ps

module logp(
    output wire [30:0] e, 
    input wire half_clk, 
    input wire [47:0] u0
    );
wire [31:0] ln2;
assign ln2 = 32'd2977044472;
wire [5:0] numlzs;
wire [5:0] exp_e;
wire v;
wire [47:0] x_e;
wire [7:0] x_a;
wire [39:0] x_b;
wire [79:0] xx_bt;
wire [39:0] xx_b;
wire [52:0] xxc2t;
wire [58:0] xxc2;
wire [61:0] xc1t;
wire [58:0] xc1;
wire [37:0] e_temp;
wire signed [66:0] ep_temp;
wire [12:0] c2;
wire [21:0] c1;
wire [29:0] c0;
reg [12:0] c2_mem[0:255];
reg [21:0] c1_mem[0:255];
reg [29:0] c0_mem[0:255];
wire signed [59:0] ye_temp;
wire [66:0] y_temp;
wire signed [58:0] xc1p; 
wire signed [58:0] xxc2p;
wire signed [58:0] c0p;
wire [30:0] et;

reg [47:0] u0_reg;
reg [47:0] x_e_reg;
reg [5:0] exp_e_reg1;


reg [5:0] exp_e_reg2;
reg signed [59:0] ye_temp_reg;

lzdetector #(48) lzd(numlzs, v, u0_reg);
assign exp_e = numlzs+1;
shifter #(48) shift(x_e, u0_reg, exp_e);

assign x_a = x_e_reg[47:40];
assign x_b = x_e_reg[39:0];
assign c2 = c2_mem[x_a];
assign c1 = c1_mem[x_a];
assign c0 = c0_mem[x_a];


assign xx_bt = x_b*x_b;
assign xx_b = xx_bt[39]? xx_bt[79:40]+1:xx_bt[79:40]; 
assign xxc2t = xx_b*c2;
assign xxc2 = xxc2t[12]? xxc2t[52:13]+1:xxc2t[52:13]; 
assign xc1t = x_b*c1;
assign xc1 = xc1t[2]? xc1t[61:3]+1:xc1t[61:3]; 
assign xc1p = {{10{1'b0}},xc1[58:10]};
assign xxc2p = -{{18{1'b0}},xxc2}; 
assign c0p = {1'b0, c0,{27{1'b0}}};
assign ye_temp = c0p + xxc2p + xc1p;

assign e_temp = exp_e_reg2*ln2;
assign ep_temp = {1'b0, e_temp,{25{1'b0}}};

assign y_temp = ep_temp-ye_temp_reg;
assign et = y_temp[31] ? y_temp[62:32]+1 : y_temp[62:32]; 
assign e = (u0==0) ? 0 : et;


initial begin
    $readmemh("../../../../MATLAB/lnc2h.txt", c2_mem);
    $readmemh("../../../../MATLAB/lnc1h.txt", c1_mem);
    $readmemh("../../../../MATLAB/lnc0h.txt", c0_mem);
end

always@(posedge half_clk) begin
    u0_reg <= u0;
    x_e_reg <= x_e;
    
    
    exp_e_reg1 <= exp_e;
    exp_e_reg2 <= exp_e_reg1;
    ye_temp_reg <= ye_temp;
end
endmodule