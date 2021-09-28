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
        while (i<3840000) 
            begin
            CLK <= 0;
            if (i<524288) begin
            writeEnable <= 1;
            end
            else begin 
            writeEnable <= 0;
            end
            writeAddr <= i;
            pixel_write <= 8'b11111111;
            readAddr <= i;
            #1
            CLK <= 1;
            #1
            i=i+8;
        end
    
    end
    
endmodule
