`timescale 1ns / 1ps
module shifter(
                out, 
                in, 
                shift_amount
                );
parameter BIT_WIDTH = 32;
`define LOG2_WIDTH $clog2(BIT_WIDTH)

output wire [BIT_WIDTH-1:0] out;
input wire [BIT_WIDTH-1:0] in;
input wire [`LOG2_WIDTH-1:0] shift_amount;
wire [BIT_WIDTH-1:0] temp[`LOG2_WIDTH:0];

assign temp[0] = in;
assign out = temp[`LOG2_WIDTH];

generate
   genvar i;
    for(i = 0; i <`LOG2_WIDTH; i = i+1)begin:shifter_generator
        assign temp[i+1] = shift_amount[i] ? {temp[i][BIT_WIDTH-1-(1<<i):0],{(1<<i){1'b0}}} : temp[i];
    end
endgenerate


endmodule