// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Mon Nov 15 20:56:57 2021
// Host        : Apollo running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               {c:/Users/jblan/Documents/GitHub/Graphics-Processor-Senior-Project/Project
//               Files/Senior-Project/Senior-Project.gen/sources_1/ip/commandFIFO/commandFIFO_stub.v}
// Design      : commandFIFO
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_5,Vivado 2021.1" *)
module commandFIFO(clk, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="clk,din[70:0],wr_en,rd_en,dout[70:0],full,empty" */;
  input clk;
  input [70:0]din;
  input wr_en;
  input rd_en;
  output [70:0]dout;
  output full;
  output empty;
endmodule
