

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.vga_gfx_cntrl_pkg.all;
use work.math_pkg.all;

entity decimal_printer is
	port (
		clk : in std_logic;
		res_n : in std_logic;
		
		gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
		gfx_instr_wr : out std_logic;
		gfx_instr_full : in std_logic;
		
		start : in std_logic;
		busy : out std_logic;
		x : in std_logic_vector(15 downto 0);
		y : in std_logic_vector(15 downto 0);
		number : in std_logic_vector(15 downto 0)
	); 
end entity;


architecture arch of decimal_printer is
begin
	--Task 3: add your implementation here
	busy <= '0'; -- set the output to a defined state
end architecture;
