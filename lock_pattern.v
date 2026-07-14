`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 10:25:38
// Design Name: 
// Module Name: lock_pattern
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

module lock_pattern (
    input  wire clk,
    input  wire rst,
    input  wire b0,    // High when '0' button is pressed
    input  wire b1,    // High when '1' button is pressed
    output reg  y      // High when unlocked
);

    parameter S_reset = 3'd0;
    parameter S_0     = 3'd1;
    parameter S_01    = 3'd2;
    parameter S_010   = 3'd3;
    parameter S_0101  = 3'd4;
    parameter S_01011 = 3'd5;

    reg [2:0] state, next_state;

    // State Register Block
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S_reset;
        else
            state <= next_state;
    end

    // Next State Logic Block (Fixed sensitivity list and button conditions)
    always @(*) begin
        case(state)
            S_reset: begin
                if (b0)      next_state = S_0;
                else if (b1) next_state = S_reset;
                else         next_state = S_reset;
            end

            S_0: begin
                if (b1)      next_state = S_01;
                else if (b0) next_state = S_0;
                else         next_state = S_0;
            end

            S_01: begin
                if (b0)      next_state = S_010;
                else if (b1) next_state = S_reset;
                else         next_state = S_01;
            end

            S_010: begin
                if (b1)      next_state = S_0101;
                else if (b0) next_state = S_0;
                else         next_state = S_010;
            end

            S_0101: begin
                if (b1)      next_state = S_01011;
                else if (b0) next_state = S_010;
                else         next_state = S_0101;
            end

            S_01011: begin
                if (b0)      next_state = S_0;
                else if (b1) next_state = S_reset;
                else         next_state = S_01011;
            end

            default: next_state = S_reset;
        endcase
    end

    // Output Logic Block
    always @(*) begin
        if (state == S_01011)
            y = 1'b1;
        else
            y = 1'b0;
    end

endmodule