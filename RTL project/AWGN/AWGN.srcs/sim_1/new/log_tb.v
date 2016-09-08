`timescale 1ns / 1ps

module log_tb();
        reg [47:0] u0;
        wire [30:0] e;
        reg [30:0] expected_e;
        log dut( e, u0);
        integer u0_fd;
        integer e_fd;
        integer status;
        integer num_tests;
        integer tests_passed;
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
            num_tests = 0;
            tests_passed = 0;
         end
         
        always begin
            while(!$feof(e_fd) && !$feof(u0_fd)) begin
                status = $fscanf(u0_fd, "%d\n",u0);
                status = $fscanf(e_fd, "%d\n",expected_e);
                num_tests = num_tests+1;
                #5
                if(expected_e != e) begin
                    $display($time, ": e was %d when %d was expected (%d)", e, expected_e, e-expected_e);
                end
                else begin
                    tests_passed = tests_passed+1;
                end
            end
            $display("%d / %d Tests Passed",tests_passed, num_tests);   
            $finish;                 
        end
endmodule
