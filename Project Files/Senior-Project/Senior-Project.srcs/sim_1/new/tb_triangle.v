`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2022 03:53:10 PM
// Design Name: 
// Module Name: tb_triangle
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


module tb_triangle;
reg [9:0] x1;
reg [9:0] x2;
reg [9:0] x3;
reg [9:0] y1;
reg [9:0] y2;
reg [9:0] y3;
reg clk;
reg rts;
wire rtr;
wire [9:0]x_out;
wire [9:0]y_out;


drawTriangle TEST(
clk,
x1,
x2,
x3,
y1,
y2,
y3,
x_out,
y_out,
rtr,
rts
);


initial
begin
    clk = 0;
    #3;
    rts <= 1;
    x1 <= 3;
    y1 <= 5;
    x2 <= 0;
    y2 <= 0;
    x3 <= 10;
    y3 <= 0;
    #2;
    rts <= 0;
end
always #1 clk = ~clk;

endmodule