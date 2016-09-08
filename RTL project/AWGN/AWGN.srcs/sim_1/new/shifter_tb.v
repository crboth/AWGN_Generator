`timescale 1ns / 1ps


module shifter_tb();
    `define BIT_WIDTH 48
    `define LOG2_WIDTH $clog2(`BIT_WIDTH)
    reg [`BIT_WIDTH-1:0] in;
    reg [`LOG2_WIDTH-1:0] shift_amount;
    wire [`BIT_WIDTH-1:0] out;
    reg [`BIT_WIDTH-1:0] expected_out;
    integer i;
    shifter #(`BIT_WIDTH) dut(out, in, shift_amount);
    initial begin
        in = 1;
        for(i = 0; i < (2<<`LOG2_WIDTH); i = i+1)begin
        shift_amount = i;
        expected_out = 1<<shift_amount;
        #10
            if(out != expected_out) begin
                $display("out was %d when %d was expected", out, expected_out);
            end
        end
        $finish;
    end
endmodule
