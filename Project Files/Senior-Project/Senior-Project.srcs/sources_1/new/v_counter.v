`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2021 12:36:56 PM
// Design Name: 
// Module Name: v_counter
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


module v_counter(
    input wire clk,
    output reg [10:0] v_count
    );
    
    initial begin
        v_count = 11'b00000000001;
    
    end
    always@(posedge clk) begin
        if (v_count == 11'b01001110100) begin
           v_count = 11'b00000000001;
       end
        else begin
            v_count <= v_count + 11'b1;
       end

    end
endmodule