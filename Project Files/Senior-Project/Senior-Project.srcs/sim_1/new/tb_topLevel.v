`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 01:14:13 PM
// Design Name: 
// Module Name: tb_topLevel
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


module tb_topLevel();
reg CLK100MHZ;
wire Hsync;
wire Vsync;
wire [11:0]vga;
reg [70:0] dataIn;
reg write_en;
TopLevel testTopLevel(CLK100MHZ,Hsync,Vsync,vga,dataIn,write_en);

integer i=0;
initial begin
  CLK100MHZ <= 0;
  #1;
    while(1)
        #1 CLK100MHZ <= ~CLK100MHZ;
end
initial begin
        dataIn <= 71'b0;
        write_en <= 1;
        #2;
        write_en <= 0;
        #2;
        dataIn <= 71'b01010000000000000001100000000100000001111000000010100000000000000000000;
        write_en <= 1;
        #2;
        write_en <= 0;
        #50;
        dataIn <= 71'b01011111111000000001100000000100000001111000000010000000000000000000000;
        write_en <= 1;
        #2;
        write_en <= 0;
        
end
endmodule
