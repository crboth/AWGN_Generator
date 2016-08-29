`timescale 1ns / 1ps
module lzdetector( p, v, in);
    parameter INPUT_WIDTH = 32;
    `define OUT_WIDTH $clog2(INPUT_WIDTH)
    `define PADDING ((1<<`OUT_WIDTH)-INPUT_WIDTH)
    output [`OUT_WIDTH-1:0] p;
    output v;
    input [INPUT_WIDTH-1:0] in;
    wire [`OUT_WIDTH-1:0] p;
    wire v;
    wire [INPUT_WIDTH-1:0] in;
    
    //padded input with 1's to save time, could reimpliment to more efficently handle inputs of not-power-of-2 size    
    `define PADDED INPUT_WIDTH+`PADDING
    wire [`PADDED-1:0] in2;   
    generate
    //{`PARAM{1'b1}} was bugging out when `PARAM is 0, used a cludgy work around
    if(`PADDING != 0)begin
        assign in2 = {in,{`PADDING{1'b1}}};
    end
    else begin
        assign in2 = in;
    end   
    if(INPUT_WIDTH > 2)begin
        `define TREE_SIDE_WIDTH (1<<(`OUT_WIDTH-1))
        `define SIDE_OUT_WIDTH `OUT_WIDTH-1
        wire [`SIDE_OUT_WIDTH-1:0] p_right;
        wire [`SIDE_OUT_WIDTH-1:0] p_left;
        wire v_right;
        wire v_left;
        
        lzdetector #(`TREE_SIDE_WIDTH) right(p_right, v_right, in2[`TREE_SIDE_WIDTH-1:0]);
        lzdetector #(`TREE_SIDE_WIDTH) left(p_left, v_left, in2[`PADDED-1:`TREE_SIDE_WIDTH]);
        assign v = v_right|v_left;
        assign p[`OUT_WIDTH-1] = !v_left;
        assign p[`OUT_WIDTH-2:0] = v_left? p_left:p_right;
    end    
    else if(INPUT_WIDTH == 2) begin
        twobitlzd lzd(p, v, in[1], in[0]);
    end
    endgenerate         
endmodule 