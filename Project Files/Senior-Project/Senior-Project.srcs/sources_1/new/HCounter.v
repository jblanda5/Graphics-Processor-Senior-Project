`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2021 02:17:39 PM
// Design Name: 
// Module Name: VCounter
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


module HCounter(
input wire Clk, //40Mhz clock
output reg Hsync, //Horizontal Sync signal    
output reg Active //Determine if colors can be displayed or not
);
begin
integer count = 0;
always @(posedge Clk) begin
    if (count < 800) begin  //From 0 to 799, Hsync is 1 and video is active
        Hsync <= 1;
        Active <= 1;
        count <= count + 1;
    end
    else if (count >= 800 & count < 840) begin //From 800 to 839, Hsync is 1 and video is not active
        Hsync <= 1;
        Active <= 0;
        count <= count + 1;
    end
    else if (count >= 840 & count < 968) begin //From 840 to 967 Hsync is 0 and video is not active
        Hsync <= 0;
        Active <= 0;
        count <= count + 1;
    end
    else if (count >= 968 & count < 1056) begin //From 967 to 1056 Hsync is 1 and video is not active
        Hsync <= 1;
        Active <= 0;
        count <= count + 1;
    end
    else if (count == 1056) begin
        Hsync <= 1;
        Active <= 1;
        count <= 0;
    end
end

end
endmodule
