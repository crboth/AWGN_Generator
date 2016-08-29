`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2016 07:57:48 PM
// Design Name: 
// Module Name: AWGN_tb
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


module AWGN_tb();
    wire signed [15:0] x0;
    wire signed [15:0] x1;
    reg clk;
    reg reset;
    reg [31:0] urng_seed1;
    reg [31:0] urng_seed2;
    reg [31:0] urng_seed3;
    reg [31:0] urng_seed4;
    reg [31:0] urng_seed5;
    reg [31:0] urng_seed6;
    reg signed [15:0] expected_x0;
    reg signed [15:0] expected_x1;
    
    AWGN dut(
        x0,
        x1,
        clk,
        reset,
        urng_seed1,
        urng_seed2,
        urng_seed3,
        urng_seed4,
        urng_seed5,
        urng_seed6 );
        
        
    integer x0_fd;
    integer x1_fd;
    integer status;
    
initial begin
    urng_seed1 = 64650448;
    urng_seed2 = 83372788;
    urng_seed3 = 21948290;
    urng_seed4 = 64504248;
    urng_seed5 = 8337978;
    urng_seed6 = 21948180;
    clk = 0;
    reset = 0;
    #1
    reset = 1;
    #1 
    reset = 0;
    x0_fd = $fopen("../../../../MATLAB/x0.txt","r");
    if(x0_fd == 0) begin
        $display("Failed to open x0.txt");
        $finish;
    end
    x1_fd = $fopen("../../../../MATLAB/x1.txt","r");
    if(x1_fd == 0) begin
        $display("Failed to open x1.txt");
        $finish;
    end
 end
     
always begin
    while(!$feof(x1_fd) && !$feof(x0_fd)) begin
        status = $fscanf(x0_fd, "%d\n", expected_x0);
        status = $fscanf(x1_fd, "%d\n", expected_x1);
        if(expected_x0 != x0) begin
            $display("x0 was %d when %d was expected", x0, expected_x0);
        end
        if(expected_x1 != x1) begin
            $display("x1 was %d when %d was expected", x1, expected_x1);
        end
        #5
        clk = 1;
        #5
        clk = 0;
    end
    $finish;                 
end
endmodule
