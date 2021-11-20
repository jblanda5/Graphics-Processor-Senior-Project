-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Tue Nov 16 18:25:57 2021
-- Host        : Apollo running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               {c:/Users/jblan/Documents/GitHub/Graphics-Processor-Senior-Project/Project
--               Files/Senior-Project/Senior-Project.gen/sources_1/ip/commandFIFO/commandFIFO_stub.vhdl}
-- Design      : commandFIFO
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity commandFIFO is
  Port ( 
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 70 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 70 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC
  );

end commandFIFO;

architecture stub of commandFIFO is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,din[70:0],wr_en,rd_en,dout[70:0],full,empty";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_2_5,Vivado 2021.1";
begin
end;
