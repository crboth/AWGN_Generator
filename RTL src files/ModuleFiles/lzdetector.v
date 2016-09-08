`timescale 1ns / 1ps
//This is a recursive funtion which generates a tree to determine the number of leading zeroes in a function
module lzdetector( p, v, in);
    parameter INPUT_WIDTH = 32;
    `define OUT_WIDTH $clog2(INPUT_WIDTH)
    //padding is the number of 1's to be added at the end of the number to make its length a power of 2 so that the tree works properly
    `define PADDING ((1<<`OUT_WIDTH)-INPUT_WIDTH)
    `define PADDED INPUT_WIDTH+`PADDING
    
    output wire [`OUT_WIDTH-1:0] p;
    output wire v;
    input wire [INPUT_WIDTH-1:0] in;
    
    //There's room to improve the efficency of the tree structure by replacing the padding approach with logic that understands how to concatenate trees of varying size 
    wire [`PADDED-1:0] in2;   
    generate

    //{`PARAM{1'b1}} was bugging out when `PARAM is 0, this caused an error whenever the INPUT_WIDTH was a power of 2 and no padding was needed
    // simply manually check for this case and dont add padding
    if(`PADDING != 0)begin
        assign in2 = {in,{`PADDING{1'b1}}};
    end
    else begin
        assign in2 = in;
    end 
    
    //For lengths greater than two, recursivly call lzdetector for each half of the length
    //This generates a warning with Vivado as multiple modules are named "left" and "right", but does not affect simulation  
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
        //Once the tree has been parsed down to leaves of length 2, the 2-bit lzd module can be used
        twobitlzd lzd(p, v, in[1], in[0]);
    end
    endgenerate         
endmodule 