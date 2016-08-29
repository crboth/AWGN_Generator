`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2016 07:28:58 PM
// Design Name: 
// Module Name: cos_tb
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


module cos_tb();
    reg [15:0] u1;
    wire [15:0] g0;
    wire [15:0] g1;
    reg [15:0] expected_g0;
    reg [15:0] expected_g1;
    sincos dut( g0, g1, u1);
    integer u1_fd;
    integer g0_fd;
    integer g1_fd;
    integer status;
    initial begin
        u1_fd = $fopen("../../../../MATLAB/u1.txt","r");
        if(u1_fd == 0) begin
            $display("Failed to open u1.txt");
            $finish;
        end
        g0_fd = $fopen("../../../../MATLAB/g0.txt","r");
        if(g0_fd == 0) begin
            $display("Failed to open g0.txt");
            $finish;
        end
        g1_fd = $fopen("../../../../MATLAB/g1.txt","r");
                if(g1_fd == 0) begin
                    $display("Failed to open g1.txt");
                    $finish;
                end
     end
     
    always begin
        while(!$feof(u1_fd) && !$feof(g0_fd) && !$feof(g1_fd)) begin
            status = $fscanf(u1_fd, "%d\n",u1);
            status = $fscanf(g0_fd, "%d\n",expected_g0);
            status = $fscanf(g1_fd, "%d\n",expected_g1);
            #5
            if(expected_g0 != g0) begin
                $display("g0 was %d when %d was expected", g0, expected_g0);
            end
            if(expected_g1 != g1) begin
                $display("g1 was %d when %d was expected", g1, expected_g1);
            end
        end
        $finish;                 
    end
endmodule
