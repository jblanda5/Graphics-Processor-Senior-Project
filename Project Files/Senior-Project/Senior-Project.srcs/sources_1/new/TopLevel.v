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
wire[18:0] writeAddr;
wire[7:0] pixel_write;
wire[18:0] readAddr;
wire[7:0] pixel_read;
wire writeEnable;
frameBuffer frame(
.writeAddr(writeAddr),
.pixel_write(pixel_write),
.readAddr(readAddr),
.pixel_read(pixel_read),
.writeEnable(writeEnable),
.clk(clk)
);

//Define our display engine module
wire [7:0]active;
wire [10:0] h_count;
wire [10:0] v_count;
vga_controller displayEngine(
.clk(clk),
.Hsync(Hsync),
.Vsync(Vsync),
.active(active),
.h_count(h_count),
.v_count(v_count)
);

//Output pixel read & active
assign pixel = pixel_read & active;

//Map pixel output from frame active
assign readAddr = xyToMem(h_count,v_count);

//Instantiate FIFO object
wire full;
//wire[70:0] dataIn;
//wire write_en;
wire empty;
wire read_clk;
wire read_en;
wire[70:0] dataOut;
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
wire rtr_drawLine;
wire rts_drawLine;
wire [9:0] x1,x2,y1,y2;
commandProcessor command_processor(
.clk(clk),
.Instruction(dataOut),
.empty(empty),
.rtr_drawLine(rtr_drawLine),
.rts_drawLine(rts_drawLine),
.read_en(read_en),
.x1(x1),
.x2(x2),
.y1(y1),
.y2(y2),
.color(pixel_write)
);

//Instantiate Line Drawing Module
wire [9:0] x_out;
wire [9:0] y_out;
drawLine line_drawing(
.x1(x1),
.y1(y1),
.x2(x2),
.y2(y2),
.clk(clk),
.rts(rts_drawLine),
.rtr(rtr_drawLine),
.x_out(x_out),
.y_out(y_out)
);

//Instantiate output mux
wire [18:0] drawLineAddr;
assign drawLineAddr = xyToMem(x_out,y_out);
outputMux mux(
.drawLineAddr(drawLineAddr),
.rtrDrawLine(rtr_drawLine),
.writeAddr(writeAddr),
.writeEnable(writeEnable)
);
endmodule