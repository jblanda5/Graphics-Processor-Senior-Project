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
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        
        #570; //Beeg delay
        PMOD <= 8'b00101111;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        
end
endmodule
