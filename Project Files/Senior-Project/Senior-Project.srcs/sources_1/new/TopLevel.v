`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 12:32:23 PM
// Design Name: 
// Module Name: TopLevel
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
module TopLevel(
    input wire CLK100MHZ,
    output wire Hsync, //Horizontal Sync signal  
    output wire Vsync, //Vertical Sync signal
    output wire [7:0] pixel //Pixel output
    );
    
function [18:0]xyToMem(input[18:0]x, input[18:0]y);
    xyToMem = (x-1)+((y-1)*800);
endfunction    
    
//Define our clock
wire clk;
wire CLK400MHZ;
clk_wiz_0 clockModule(clk,CLK400MHZ,CLK100MHZ); //Convert CLK100MHZ to a 40MHz clock

//Define our Frame Buffer module
reg[18:0] writeAddr;
reg[7:0] pixel_write;
wire[18:0] readAddr;
wire[7:0] pixel_read;
frameBuffer frame(writeAddr,pixel_write,readAddr,pixel_read,clk);

//Define our display engine module
wire [7:0]active;
wire [10:0] h_count;
wire [10:0] v_count;
vga_controller displayEngine(clk,Hsync,Vsync,active,h_count,v_count,CLK400MHZ);

//Output pixel read & active
assign pixel = pixel_read & active;

//Map pixel output from frame active
assign readAddr = xyToMem(h_count,v_count);

endmodule
