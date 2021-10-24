`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 01:33:22 PM
// Design Name: 
// Module Name: tb_drawLine
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


module tb_drawLine;
reg [10:0]x1;
reg [10:0]x2;
reg [10:0]y1;
reg [10:0]y2;
reg clk;
wire ready;
wire [10:0]x_out;
wire [10:0]y_out;
wire pixelWrite;

drawLine lineDraw(
.x1(x1),
.y1(y1),
.x2(x2),
.y2(y2),
.clk(clk),
.ready(ready),
.x_out(x_out),
.y_out(y_out),
.pixelWrite(pixelWrite)
);


integer i=0;
initial begin
x1 <= 0;
x2 <= 0;
y1 <= 0;
y2 <= 0;
#1
x1 <= 0;
y1 <= 2;
x2 <= 3;
y2 <= 2;
while (i<250) begin
clk <= 0;
#1
clk <= 1;
#1
i = i + 1;
end
end
endmodule
