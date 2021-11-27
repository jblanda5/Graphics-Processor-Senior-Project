`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2021 10:42:21 AM
// Design Name: 
// Module Name: tb_Interface
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


module tb_Interface;

reg [7:0] PMOD;
reg pi_rts_raw;
reg clk;
wire [70:0]dataIn;
wire write_en;
wire fpga_rtr;

InterfaceModule TESTINTERFACE(
clk, 
pi_rts_raw, 
PMOD,
dataIn,
write_en,
fpga_rtr
);

initial begin
clk <= 0;
    while (1) begin
        #1 clk <= ~clk;
    end
end

initial begin

while (1) begin
    pi_rts_raw <= 1; //should have valid data when RTS is high
    PMOD <= 8'b11111111;
    #1;
    while (~fpga_rtr) begin
    #1;
    end
    pi_rts_raw <= 0;
    while (fpga_rtr) begin
    #1;
    end
end
end

endmodule
