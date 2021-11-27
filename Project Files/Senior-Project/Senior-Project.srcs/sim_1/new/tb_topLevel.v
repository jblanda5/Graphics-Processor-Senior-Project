`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 01:14:13 PM
// Design Name: 
// Module Name: tb_topLevel
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


module tb_topLevel();
reg CLK100MHZ;
wire Hsync;
wire Vsync;
wire [11:0]vga;
reg [7:0] PMOD;
reg pi_rts_raw;
wire fpga_rtr;
TopLevel testTopLevel(
    CLK100MHZ,
    Hsync, //Horizontal Sync signal
    Vsync, //Vertical Sync signal
    vga, //Pixel output
    PMOD, //Data to send
    pi_rts_raw,
    fpga_rtr
);

integer i=0;
initial begin
  CLK100MHZ <= 0;
  #1;
    while(1)
        #1 CLK100MHZ <= ~CLK100MHZ;
end
initial begin
        #570; //Wait for PLL to catch up.
        PMOD <= 8'b00101110;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        PMOD <= 8'b00000000;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        #2;
        PMOD <= 8'b00000000;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        #2;
        PMOD <= 8'b00000000;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        #2;
        PMOD <= 8'b11111111;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        #2;
        PMOD <= 8'b11111111;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        #2; 
        PMOD <= 8'b11110000;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        #2; 
        PMOD <= 8'b00000000;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
        #2;
        PMOD <= 8'b0000000;
        pi_rts_raw <= 1;
        while (fpga_rtr) begin
        #2;
        end
        while (~fpga_rtr) begin
        #2;
        pi_rts_raw <= 0;
        end
end
endmodule
