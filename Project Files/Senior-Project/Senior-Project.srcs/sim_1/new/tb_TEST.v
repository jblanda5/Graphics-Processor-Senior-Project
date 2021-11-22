`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2021 07:38:20 PM
// Design Name: 
// Module Name: tb_TEST
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


module tb_TEST;
wire clk, Hsync, Vsync;
wire [11:0] vga;
reg [3:0] x1, x2, y1, y2;
TEST DEMO(
    .CLK100MHZ(clk),
    .Hsync(Hsync), //Horizontal Sync signal  
    .Vsync(Vsync), //Vertical Sync signal
    .vga(vga), //Pixel output
    .x1(x1),
    .y1(y1),
    .x2(x2),
    .y2(y2)
);
initial begin
x1 <= 4'b1111;
y1 <= 4'b1111;
x2 <= 4'b1111;
y2 <= 4'b1111;
end

endmodule
