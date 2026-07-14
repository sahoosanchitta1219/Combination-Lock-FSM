`timescale 1ns / 1ps

module lock_pattern_tb;

    reg clk;
    reg rst;
    reg b0;
    reg b1;
    wire y;

    // Instantiate the DUT
    lock_pattern uut (
        .clk(clk),
        .rst(rst),
        .b0(b0),
        .b1(b1),
        .y(y)
    );

    // Clock Generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        b0 = 0;
        b1 = 0;

        // Apply reset
        #20;
        rst = 0;
        #10;

        // Sequence: 0 -> 1 -> 0 -> 1 -> 1
        
        // Input 0
        b0 = 1; b1 = 0; #10;
        b0 = 0; b1 = 0; #10;

        // Input 1
        b0 = 0; b1 = 1; #10;
        b0 = 0; b1 = 0; #10;

        // Input 0
        b0 = 1; b1 = 0; #10;
        b0 = 0; b1 = 0; #10;

        // Input 1
        b0 = 0; b1 = 1; #10;
        b0 = 0; b1 = 0; #10;

        // Input 1
        b0 = 0; b1 = 1; #10;
        b0 = 0; b1 = 0; #10; // Output 'y' will be high here

        #40;
        $finish;
    end

endmodule