`timescale 1ns / 1ps

module logp_tb();
        reg [47:0] u0;
        wire [30:0] e;
        reg [30:0] expected_e;
        reg clk;
        logp dut( e, clk, u0);
        integer u0_fd;
        integer e_fd;
        integer status;
        integer num_tests;
        integer tests_passed;
        integer i;
        initial begin
            clk = 0;
            i = 0;
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
            num_tests = 0;
            tests_passed = 0;
            status = $fscanf(u0_fd, "%d\n",u0);
            status = $fscanf(e_fd, "%d\n",expected_e);         
         end
         
        always begin
            #5 clk = 1;
            #5 clk = 0;
            status = $fscanf(u0_fd, "%d\n",u0);
            #5 clk = 1;
            #5 clk = 0;
            status = $fscanf(u0_fd, "%d\n",u0);     
            while(!$feof(e_fd) && !$feof(u0_fd)) begin
                #4 clk = 1;
                #5 clk = 0;
                #1
                num_tests= num_tests+1;
                if(expected_e != e) begin
                    $display($time, ": e was %d when %d was expected (%d)", e, expected_e, e-expected_e);
                end
                else begin
                    tests_passed = tests_passed+1;
                end
                status = $fscanf(u0_fd, "%d\n",u0);
                status = $fscanf(e_fd, "%d\n",expected_e);
            end
            $display("%d / %d Tests Passed",tests_passed, num_tests);   
            $finish;                 
        end
endmodule
