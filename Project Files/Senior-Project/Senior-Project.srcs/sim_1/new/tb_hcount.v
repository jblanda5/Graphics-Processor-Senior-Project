`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2021 01:24:06 PM
// Design Name: 
// Module Name: tb_hcount
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


module tb_hcount;
    reg clk;
    wire [10:0] h_count;
    h_counter test(clk, h_count);
    
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