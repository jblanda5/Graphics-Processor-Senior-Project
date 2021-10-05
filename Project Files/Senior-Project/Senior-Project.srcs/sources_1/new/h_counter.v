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
    output reg v_clk,
    output reg [10:0] h_count
    );
    
    initial begin
        h_count = 11'b00000000000;
    
    end
    always@(posedge clk) begin
        if (h_count == 11'b10000011101) begin
           h_count <= 11'b00000000000;
            v_clk <= 1;
       end
       else begin
            h_count <= h_count + 11'b1;
            v_clk <= 0;
       end

    end
endmodule
