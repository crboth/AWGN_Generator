`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2016 09:57:12 PM
// Design Name: 
// Module Name: log_tb
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


module log_tb();
        reg [47:0] u0;
        wire [30:0] e;
        reg [30:0] expected_e;
        log dut( e, u0);
        integer u0_fd;
        integer e_fd;
        integer status;
        initial begin
            e_fd = $fopen("../../../../MATLAB/e.txt","r");
            if(e_fd == 0) begin
                $display("Failed to open e.txt");
                $finish;
            end
            u0_fd = $fopen("../../../../MATLAB/u0.txt","r");
            if(u0_fd == 0) begin
                $display("Failed to open u0.txt");
                $finish;
            end
         end
         
        always begin
            while(!$feof(e_fd) && !$feof(u0_fd)) begin
                status = $fscanf(u0_fd, "%d\n",u0);
                status = $fscanf(e_fd, "%d\n",expected_e);
                #5
                if(expected_e != e) begin
                    $display("e was %d when %d was expected", e, expected_e);
                end
            end
            $finish;                 
        end
endmodule
