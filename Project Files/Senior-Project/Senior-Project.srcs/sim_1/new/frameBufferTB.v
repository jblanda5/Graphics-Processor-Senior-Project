`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2021 10:11:49 AM
// Design Name: 
// Module Name: frameBufferTB
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


module frameBufferTB;
    // Write to frame inputs
    reg [18:0] writeAddr;
    reg [7:0] pixel_write;
    // Output frame I/O
    reg [18:0] readAddr;
    wire [7:0] pixel_read;
    // Clock
    reg CLK;
    
    
    frameBuffer testBuffer(writeAddr, pixel_write, readAddr, pixel_read, CLK);
    
    reg [3839999:0]testPattern = 3840000'b1;//Put test pattern data here
    integer i=0;
    initial begin
        while (i<3840000) 
            begin
            CLK <= 0;
            writeAddr <= i;
            pixel_write <= testPattern[i];
            readAddr <= i;
            #1
            CLK <= 1;
            #1
            i=i+8;
        end
    
    end
    
endmodule
