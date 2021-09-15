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
    reg [18:0] writeBus;
    reg [2:0] R_write;
    reg [2:0] G_write;
    reg [1:0] B_write;
    // Output frame I/O
    reg [18:0] index;
    wire [2:0] R_read;
    wire [2:0] G_read;
    wire [1:0] B_read;
    // Clock
    reg CLK;
    
    
    frameBuffer testBuffer(writeBus, R_write, G_write, B_write, index, R_read, G_read, B_read, CLK);
    
    integer i=0;
    initial begin
        while (i<1100) 
            begin
            CLK <= 0;
            writeBus <= 19'b0;
            R_write <= 3'b010;
            G_write <= 3'b101;
            B_write <= 2'b01;
            index <= 19'b0;
            #1
            CLK <= 1;
            #1
            i=i+1;
        end
    
    end
    
endmodule
