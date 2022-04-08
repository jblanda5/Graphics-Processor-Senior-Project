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
        PMOD <= 8'b01000000; //opcode + 1/2 color
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b1111100; //1/2 color + first 4 bits of x1
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b10000010; //last 6 bits of x1 + first 2 of y1
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b01011000; //end of y1
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00110010; //x2 first 8 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00001100; //x2 last 2 bits and y2 first 6 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b10001100; //y2 last 4 bits x3 first 4 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b10000000; //x3 last 6 bits and first 2 of y3
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b11001000; //y3 last 8 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        
        #40; //delay
        //For some reason I need an empty bit here
   /*     PMOD <= 8'b00000000;
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        */
    /*    
        PMOD <= 8'b01001111; //opcode + 1/2 color
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b1110000; //1/2 color + first 4 bits of x1
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b11001000; //last 6 bits of x1 + first 2 of y1
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00110010; //end of y1
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000; //x2 first 8 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000; //x2 last 2 bits and y2 first 6 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000001; //y2 last 4 bits x3 first 4 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b10010000; //x3 last 6 bits and first 2 of y3
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        PMOD <= 8'b00000000; //y3 first 8 bits
        while (fpga_rtr == 0) begin
        #10;
        end
        pi_rts_raw <= 1;
        while (fpga_rtr == 1) begin
        #10;
        end
        pi_rts_raw <= 0;
        */
end
endmodule
