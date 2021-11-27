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
    reg writeEnable;
    // Clock
    reg CLK;
    
    
    frameBuffer testBuffer(writeAddr, pixel_write, readAddr, pixel_read, writeEnable, CLK);
    
    integer i=0;
    initial begin
        readAddr <= 'h0;
        CLK <= 0;
        while (1) begin
        #1; 
        CLK <= ~CLK;
        end
    end
    initial begin
    #20;
        while (1) begin
        #2 readAddr <= readAddr + 1;
        end
    end
    initial begin
        #10;
            writeEnable <= 1;
            writeAddr <= 'h643;
            pixel_write <= 'h80;
        #2;
            writeAddr <= 'h644;
        #2;
            writeAddr <= 'h645;
        #2;
            writeAddr <= 0;
            pixel_write <= 0;
            writeEnable <= 0;
        #2;  
            readAddr = 'h641;
    end
    
endmodule
