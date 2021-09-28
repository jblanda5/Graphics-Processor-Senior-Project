`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2021 10:27:38 AM
// Design Name: 
// Module Name: horizontal_counter
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


module vga_controller(
    input clk,
    output reg Hsync, //Horizontal Sync signal  
    output reg Vsync,  
    output reg [7:0] pixel
    );
    
wire [10:0]h_count;
wire [10:0]v_count;
wire v_clk; //This will be used to increment the vertical counter. Will be high on reset and low elsewhere
h_counter Hcounter(clk, v_clk, h_count);
v_counter Vcounter(v_clk, v_count);

always @(posedge clk) begin
//Vsync
    if (v_count <= 11'b01001011000) begin //From 1 to 600, Vsync is 0 (low-active) and video is active
        Vsync <= 0;
        pixel <= 8'b00000000; //Later this will be removed.
    end
    //Front Porch
    else if (v_count > 11'b01001011000 & v_count <= 11'b01001011001) begin //For 601, Vsync is 0 and video is not active
        Vsync <= 0;
        pixel <= 8'b00000000;
    end
    //Vsync Pulse
    else if (v_count > 11'b01001011001 & v_count <= 11'b01001011100) begin //From 602 to 604 Vsync is 1 and video is not active
        Vsync <= 1;
        pixel <= 8'b00000000;
    end
    //Back Porch
    else if (v_count > 11'b01001011100 & v_count <= 11'b01001110100) begin //From 605 to 628 Vsync is 0 and video is not active
        Vsync <= 0;
        pixel <= 8'b00000000;
    end

//Hsync
    if (h_count <= 11'b01100100000) begin //From 1 to 800, Hsync is 0 (low-active) and video is active
        Hsync <= 0;
        pixel <= 8'b00000000;
    end
    //Front Porch
    else if (h_count > 11'b01100100000 & h_count <= 11'b01101001000) begin //From 801 to 840, Hsync is 0 and video is not active
        Hsync <= 0;
        pixel <= 8'b00000000;
    end
    //Hsync Pulse
    else if (h_count > 11'b01101001000 & h_count <= 11'b01111001000) begin //From 841 to 968 Hsync is 1 and video is not active
        Hsync <= 1;
        pixel <= 8'b00000000;
    end
    //Back Porch
    else if (h_count > 11'b01111001000 & h_count <= 11'b10000100000) begin //From 968 to 1056 Hsync is 0 and video is not active
        Hsync <= 0;
        pixel <= 8'b00000000;
    end
end
endmodule