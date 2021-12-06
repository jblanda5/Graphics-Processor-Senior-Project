`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2021 08:52:49 PM
// Design Name: 
// Module Name: h_counter
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


module h_counter(
    input wire clk,
    input wire reset,
    output reg v_clk,
    output reg [10:0] h_count
    );
    
    initial begin //Initial Condition, TODO: Replace, violates best practice
        h_count = 11'b00000000000;
    
    end
    always@(posedge clk) begin
    if (reset) begin
        h_count = 11'b00000000000;
    end
        if (h_count == 11'b10000011101) begin //If we've reached the end of the screen, reset
           h_count <= 11'b00000000000;
            v_clk <= 1; //Increment v_counter
       end
       else begin
            h_count <= h_count + 11'b1; //Increment
            v_clk <= 0;
       end

    end
endmodule
