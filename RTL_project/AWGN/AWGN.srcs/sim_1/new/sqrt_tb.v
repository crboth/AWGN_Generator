`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2016 12:31:54 PM
// Design Name: 
// Module Name: sqrt_tb
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


module sqrt_tb();
    reg [30:0] e;
    wire [16:0] f;
    reg [16:0] expected_f;
    sqrt dut( f, e);
    integer f_fd;
    integer e_fd;
    integer status;
    initial begin
        e_fd = $fopen("../../../../MATLAB/e.txt","r");
        if(e_fd == 0) begin
            $display("Failed to open e.txt");
            $finish;
        end
        f_fd = $fopen("../../../../MATLAB/f.txt","r");
        if(f_fd == 0) begin
            $display("Failed to open f.txt");
            $finish;
        end
     end
     
    always begin
        while(!$feof(e_fd) && !$feof(f_fd)) begin
            status = $fscanf(e_fd, "%d\n",e);
            status = $fscanf(f_fd, "%d\n",expected_f);
            #5
            if(expected_f != f) begin
                $display("f was %d when %d was expected", f, expected_f);
            end
        end
        $finish;                 
    end
endmodule
