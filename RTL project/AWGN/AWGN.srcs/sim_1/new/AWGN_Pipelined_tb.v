`timescale 1ns / 1ps

module AWGN_Pipelined_tb();
    wire signed [15:0] awgn_out;
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
    
    AWGN_Pipelined dut(
        awgn_out,
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
    integer num_tests;
    integer tests_passed;
    integer largest_error;
    
initial begin
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
    urng_seed1 = 64650448;
    urng_seed2 = 83372788;
    urng_seed3 = 21948290;
    urng_seed4 = 64504248;
    urng_seed5 = 8337978;
    urng_seed6 = 21948180;
    reset = 1;
    clk = 0;
    num_tests = 0;
    tests_passed = 0;
    largest_error = 0;
    //clk must be toggled at least twice to get the synchronous reset to apply to the URNGs
    //with the unknown initial state, it must be toggled 4 times for simulation but still only twice for an implimentation
    //initial implimentation used asynchronous resests but vivado disliked it
    #2
    clk = 1;
    #2
    clk = 0;
    #2
    clk = 1;
    #2
    clk = 0;
    reset = 0;
 end
     
always begin
    #100
    #5 clk = 1;
    #5 clk = 0;
    #5 clk = 1;
    #5 clk = 0;
    #5 clk = 1;
    #5 clk = 0;
    #5 clk = 1;
    #5 clk = 0;    
    #5 clk = 1;
    #5 clk = 0;
    #5 clk = 1;
    #5 clk = 0;
    #5 clk = 1;
    #5 clk = 0;       
        
    while(!$feof(x1_fd) && !$feof(x0_fd)) begin
        #5 clk = 1;  
        num_tests = num_tests + 2;
        status = $fscanf(x0_fd, "%d\n", expected_x0);
        status = $fscanf(x1_fd, "%d\n", expected_x1);
        if(expected_x0 != awgn_out) begin
            $display($time, ": x0 was %d when %d was expected (%d)", awgn_out, expected_x0, expected_x0-awgn_out);
            if(expected_x0-awgn_out > largest_error) begin
                largest_error = expected_x0-awgn_out;
            end
        end
        else begin
            tests_passed = tests_passed+1;
        end
        #5 clk = 0;
        #5 clk = 1;                
        if(expected_x1 != awgn_out) begin
            $display($time,": x1 was %d when %d was expected (%d)", awgn_out, expected_x1, expected_x1-awgn_out);
            if(expected_x1-awgn_out > largest_error) begin
                largest_error = expected_x1-awgn_out;
            end
        end
        else begin
            tests_passed = tests_passed+1;
        end
        if(largest_error > 1) begin
            $finish;
        end
        #5 clk = 0;     
    end
    $display("%d / %d Tests Passed",tests_passed, num_tests);
    $display("Largest error was %d",largest_error);
    $finish;                 
end
endmodule
