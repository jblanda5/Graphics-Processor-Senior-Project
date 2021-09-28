`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2021 01:33:19 PM
// Design Name: 
// Module Name: tb_vgaController
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


module tb_vgaController;

reg clk;
wire [7:0] pixel;
wire Hsync;
wire Vsync;
vga_controller test(clk, Hsync, Vsync, pixel);

integer i = 0;

initial begin
while (i<66316900) begin
    clk <= 0;
    #1;
    clk <= 1;
    i = i+1;
    #1;
    end
 end
 endmodule
