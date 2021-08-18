`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2021 03:25:43 PM
// Design Name: 
// Module Name: TB_Hsync
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


module TB_Hsync;
reg Clk;
wire Hsync, Active;
HCounter test(Clk, Hsync, Active);
integer i=0;

initial begin
while (i<1100) 
    begin
    Clk <= 0;
    #1
    Clk <= 1;
    #1
    i=i+1;
    end
end
endmodule
