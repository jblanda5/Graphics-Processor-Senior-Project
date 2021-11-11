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
    output wire [11:0] vga, //Pixel output
    input wire[70:0] dataIn,
    input wire write_en
    );
//set up our pixel color wire
wire [7:0] pixel;
//set up our lookup table
rgb_lookup lookupTable(pixel,vga);

//Function to convert X and Y location to memory address
function [18:0]xyToMem(input[18:0]x, input[18:0]y);
    xyToMem = (x)+(y*800);
endfunction    

//Define our clock
wire clk;
clk_wiz_0 clockModule(clk,CLK100MHZ); //Convert CLK100MHZ to a 40MHz clock

//Define our Frame Buffer module
reg[18:0] writeAddr;
reg[7:0] pixel_write;
wire[18:0] readAddr;
wire[7:0] pixel_read;
wire writeEnable;
frameBuffer frame(writeAddr,pixel_write,readAddr,pixel_read,writeEnable,clk);

//Define our display engine module
wire [7:0]active;
wire [10:0] h_count;
wire [10:0] v_count;
vga_controller displayEngine(clk,Hsync,Vsync,active,h_count,v_count);

//Output pixel read & active
assign pixel = pixel_read & active;

//Map pixel output from frame active
assign readAddr = xyToMem(h_count,v_count);

//Instantiate FIFO object
wire full;
//wire[70:0] dataIn;
//wire write_en;
wire empty;
wire[70:0] dataOut;
wire read_en;
commandFIFO FIFO(
.full(full), 
.din(dataIn), 
.wr_en(write_en), 
.empty(empty), 
.dout(dataOut), 
.rd_en(read_en), 
.clk(clk)
);

//Instantiate Command Processor
wire finished;
wire[2:0] instruction;
wire [9:0]x1,y1,x2,y2,x3,y3;
commandProcessor command_processor(
.clk(clk),
.finished(finished),
.dataOut(dataOut),
.empty(empty),
.instruction(instruction),
.color(color),
.x1(x1),
.x2(x2),
.x3(x3),
.y1(y1),
.y2(y2),
.y3(y3),
.read_en(read_en)
);
endmodule
