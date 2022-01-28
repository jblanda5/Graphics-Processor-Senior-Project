`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2022 03:51:21 PM
// Design Name: 
// Module Name: tb_blank_screen
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


module tb_blank_screen;
reg rts;
wire rtr;
wire [9:0] x_out;
wire [9:0] y_out;
reg clk;
reg reset;

blank_screen blankScreen(rts, rtr, x_out, y_out, clk, reset);

initial begin
    clk <= 0;
    rts <= 0;
    while(1) begin
    #1;
    clk <= ~clk;
    end
end

initial begin
#5;
reset <= 1;
#1;
reset <= 0;
#5;
rts <= 1;
#2;
rts <= 0;
end

endmodule
