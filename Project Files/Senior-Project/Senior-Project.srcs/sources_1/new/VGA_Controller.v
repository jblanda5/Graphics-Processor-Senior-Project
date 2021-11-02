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
    input wire clk,
    input wire reset,
    output reg Hsync, //Horizontal Sync signal  
    output reg Vsync,  
    output reg [7:0]active,
    output wire [10:0]h_count,
    output wire [10:0]v_count
    );
wire v_clk; //This will be used to increment the vertical counter. Will be high on reset and low elsewhere
h_counter Hcounter(
.clk(clk), 
.reset(reset), 
.v_clk(v_clk), 
.h_count(h_count)
);
v_counter Vcounter(
.v_clk(v_clk), 
.reset(reset), 
.v_count(v_count)
);

always @(posedge clk) begin
    //Vsync
    if (v_count <= 599) begin //From 0 to 599, Vsync is 0 (low-active) and video is active
        Vsync <= 0;
    end
    //Front Porch
    else if (v_count == 600) begin //For 600, Vsync is 0 and video is not active
        Vsync <= 0;
    end
    //Vsync Pulse
    else if (v_count > 600 & v_count <= 604) begin //From 601 to 604 Vsync is 1 and video is not active
        Vsync <= 1;
    end
    //Back Porch
    else if (v_count > 604 & v_count <= 627) begin //From 605 to 627 Vsync is 0 and video is not active
        Vsync <= 0;
    end

    //Hsync
    //Every value is 1 clock cycle early, as it won't take effect until the next cycle.
    if (h_count <= 798 | h_count == 1055) begin //From 1 to 800, Hsync is 0 (low-active) and video is active
        Hsync <= 0;
    end
    //Front Porch
    else if (h_count > 798 & h_count <= 838) begin //From 800 to 839, Hsync is 0 and video is not active
        Hsync <= 0;
    end
    //Hsync Pulse
    else if (h_count > 838 & h_count <= 966) begin //From 840 to 967 Hsync is 1 and video is not active
        Hsync <= 1;
    end
    //Back Porch
    else if (h_count > 966 & h_count <= 1054) begin //From 968 to 1056 Hsync is 0 and video is not active
        Hsync <= 0;
    end
    
    //Active check
    active <= 8'b11111111;
    if(v_count > 599) begin //check if its outside active vertical region
        active <= 8'b00000000;
    end
    if(h_count > 798 & ~(h_count == 1055)) begin //check if its outside active horizontal region
        active <= 8'b00000000;
    end
    if(h_count == 1055 & v_count == 599) begin //Niche case: inactive at first pixel of outside vertical area
        active <= 8'b00000000;
    end
    if(h_count == 1055 & v_count == 627) begin //Niche case: active at first pixel of new frame
        active <= 8'b11111111;
    end
end
endmodule