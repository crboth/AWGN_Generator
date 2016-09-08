`timescale 1ns / 1ps

module taus_tb();
        wire [31:0] out;
        reg [31:0] expected_out;
        reg clk;
        reg rst;
        reg [31:0] s0;
        reg [31:0] s1;
        reg [31:0] s2;
        reg [31:0] expected_s0;
        reg [31:0] expected_s1;
        reg [31:0] expected_s2;
        integer status;
        integer out_fd;
        integer s0_fd;
        integer s1_fd;
        integer s2_fd;
        taus dut(out, clk, rst, s0, s1, s2);
        initial begin
            out_fd = $fopen("../../../../MATLAB/tausa_out.txt","r");
            if(out_fd == 0) begin
                $display("Failed to open tausa_out.txt");
                $finish;
            end
            s0_fd = $fopen("../../../../MATLAB/s0a.txt","r");
            if(s0_fd == 0) begin
                $display("Failed to open s0a.txt");
                $finish;
            end
            s1_fd = $fopen("../../../../MATLAB/s1a.txt","r");
            if(s1_fd == 0) begin
                $display("Failed to open s1a.txt");
                $finish;
            end
            s2_fd = $fopen("../../../../MATLAB/s2a.txt","r");
            if(s2_fd == 0) begin
                $display("Failed to open s2a.txt");
                $finish;
            end                     
            status = $fscanf(s0_fd, "%d\n",s0);
            status = $fscanf(s1_fd, "%d\n",s1);
            status = $fscanf(s2_fd, "%d\n",s2);
            status = $fscanf(out_fd, "%d\n",expected_out);
            clk = 0;
            rst = 1;
            #1
            clk = 1;
            #1 
            rst = 0;
            clk = 0;
        end
        

        always begin
            while(!$feof(out_fd) && !$feof(s0_fd) && !$feof(s1_fd) && !$feof(s2_fd)) begin
                if(expected_out != out) begin
                    $display("out was %d when %d was expected", out, expected_out);
                end
                #5 clk = 1;
                #5 clk = 0;
                status = $fscanf(out_fd, "%d\n",expected_out);
                status = $fscanf(s0_fd, "%d\n", expected_s0);
                status = $fscanf(s1_fd, "%d\n", expected_s1);
                status = $fscanf(s2_fd, "%d\n", expected_s2);
                if(expected_s0 != dut.s0) begin
                    $display("s0 was %d when %d was expected", dut.s0, expected_s0);
                end
                if(expected_s1 != dut.s1) begin
                    $display("s1 was %d when %d was expected", dut.s1, expected_s1);
                end
                if(expected_s2 != dut.s2) begin
                    $display("s2 was %d when %d was expected", dut.s2, expected_s2);
                end
            end
            $finish;
        end
endmodule
