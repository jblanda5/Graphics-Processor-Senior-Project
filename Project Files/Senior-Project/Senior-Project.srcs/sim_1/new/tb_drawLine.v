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
reg [9:0] x1;
reg [9:0] x2;
reg [9:0] y1;
reg [9:0] y2;
reg clk;
reg rts;
wire rtr;
wire [9:0]x_out;
wire [9:0]y_out;

drawLine lineDraw(
.x1(x1),
.y1(y1),
.x2(x2),
.y2(y2),
.clk(clk),
.rts(rts),
.rtr(rtr),
.x_out(x_out),
.y_out(y_out)
);


initial
begin
    clk = 0;
    #1
    rts <= 1;
    x1 <= 15;
    y1 <= 2;
    x2 <= 1;
    y2 <= 5;
    #10;
    rts <= 0;
end
always #1 clk = ~clk;

endmodule