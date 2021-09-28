`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2021 06:36:24 PM
// Design Name: 
// Module Name: tb_vcount
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


module tb_vcount;
    reg clk;
    wire [10:0] v_count;
    v_counter test(clk, v_count);
    
    integer i = 0;
    
    initial begin
    while (i<1100) begin
        clk <= 0;
        #1;
        clk <= 1;
        i = i+1;
        #1;
        end
     end
 endmodule