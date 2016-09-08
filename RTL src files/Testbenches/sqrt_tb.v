`timescale 1ns / 1ps


module sqrt_tb();
    reg [30:0] e;
    wire [16:0] f;
    reg [16:0] expected_f;
    sqrt dut( f, e);
    integer f_fd;
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
        f_fd = $fopen("../../../../MATLAB/f.txt","r");
        if(f_fd == 0) begin
            $display("Failed to open f.txt");
            $finish;
        end
        num_tests = 0;
        tests_passed = 0;
     end
     
    always begin
        while(!$feof(e_fd) && !$feof(f_fd)) begin
            num_tests = num_tests+1;
            status = $fscanf(e_fd, "%d\n",e);
            status = $fscanf(f_fd, "%d\n",expected_f);
            #5
            if(expected_f != f) begin
                $display($time, ": f was %d when %d was expected (%d) ", f, expected_f, f-expected_f);
            end
            else begin
                tests_passed = tests_passed +1;
            end
        end
        $display("%d / %d Tests Passed",tests_passed, num_tests);  
        $finish;                 
    end
endmodule
