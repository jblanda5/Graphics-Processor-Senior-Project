// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2021.1" *)
module blk_mem_gen_0(clka, wea, addra, dina, clkb, enb, addrb, doutb);
  input clka;
  input [0:0]wea;
  input [18:0]addra;
  input [7:0]dina;
  input clkb;
  input enb;
  input [18:0]addrb;
  output [7:0]doutb;
endmodule
