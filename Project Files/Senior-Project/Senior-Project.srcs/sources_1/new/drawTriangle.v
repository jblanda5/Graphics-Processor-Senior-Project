`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2022 02:31:30 PM
// Design Name: 
// Module Name: drawTriangle
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


module drawTriangle(
input wire clk,
input wire [9:0]x1,
input wire [9:0]x2,
input wire [9:0]x3,
input wire [9:0]y1,
input wire [9:0]y2,
input wire [9:0]y3,
output wire [9:0]x_out,
output reg [9:0]y_out,
output reg rtr,
input wire rts
);
reg enable1;
reg enable2;
reg rts1;
wire rtr1;
reg rts2;
wire rtr2;
wire [9:0] x_curr1, y_curr1;
wire [9:0] x_curr2, y_curr2;

//Instantiate draw side modules;
drawSide side1(
.x1(x2),
.x2(x1),
.y1(y2),
.y2(y1),
.clk(clk),
.rts(rts1),
.rtr(rtr1),
.x_out(x_curr1),
.y_out(y_curr1),
.enable(enable1)
);

drawSide side2(
.x1(x3),
.x2(x1),
.y1(y3),
.y2(y1),
.clk(clk),
.rts(rts2),
.rtr(rtr2),
.x_out(x_curr2),
.y_out(y_curr2),
.enable(enable2)
);

reg rts_draw;
wire rtr_draw;
drawHorizontal drawModule(
.x1(x_curr1),
.x2(x_curr2),
.clk(clk),
.x(x_out),
.rts(rts_draw),
.rtr(rtr_draw)
);

reg [3:0]state;
parameter reset = 4'b0000;
parameter setup = 4'b0001;
parameter flat_bottom = 4'b0010;
parameter flat_top = 4'b0011;
parameter idle = 4'b0100;
parameter draw = 4'b0101;
parameter intermediate = 4'b0110;
always @(posedge clk) begin
    case(state)
        reset: begin
            y_out <= 0;
            enable1 <= 0;
            enable2 <= 0;
            rtr <= 1;
            state <= idle;
            rts1 <= 0;
            rts2 <= 0;
            rts_draw <= 0;
        end
        
        idle: begin
            if (rts) begin
                rtr <= 0;
                state <= setup;
            end
            else begin
                rtr <= 1;
            end
        end
        
        setup: begin
           if (rtr1 & rtr2) begin
                rts1 <= 1;
                rts2 <= 1;
                if (y1 >= y2) begin
                    state <= flat_bottom;
                end
                else if (y2 > y1) begin
                    state <= flat_top;
                end
            end
        end
        
        flat_bottom: begin
            rts1 <= 0;
            rts2 <= 0;
            if (y_curr1 == y_curr2) begin
                enable1 <= 1;
                enable2 <= 2;
                rts_draw <= 1;
                state <= intermediate;
            end
            else if (y_curr1 > y_curr2) begin
                enable1 <= 0;
                enable2 <= 1;
                rts_draw <= 0;
            end
            else begin //y_curr2 > y_curr1
                enable1 <= 1;
                enable2 <= 0;
                rts_draw <= 0;
            end
        end
    
        flat_top: begin// Use code from bottom
        end
        
    intermediate: begin
        y_out <= y_curr1;
        rts_draw <= 0;
        enable1 <= 0;
        enable2 <= 0;
        state <= draw;
    end
    
    draw: begin
        if (rtr_draw) begin
            if (y_curr1 == y1) begin
                state <= reset;
            end
            if (y1 > y2) begin
                state <= flat_bottom;
            end
            else begin
                state <= flat_top;
            end
        end
    end
    
    default: state <= reset;
    endcase

end

endmodule
