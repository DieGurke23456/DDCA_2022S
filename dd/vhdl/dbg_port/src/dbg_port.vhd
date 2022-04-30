
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.dbg_port_pkg.all;

entity dbg_port is
	port (
		clk   : in std_logic;
		res_n : in std_logic;
		rx    : in std_logic;
		tx    : out std_logic;
		hw_switches : in std_logic_vector(17 downto 0);
		hw_keys : in std_logic_vector(3 downto 0);
		switches : out std_logic_vector(17 downto 0);
		keys : out std_logic_vector(3 downto 0);
		ledr : in std_logic_vector(17 downto 0);
		ledg : in std_logic_vector(8 downto 0);
		gfx_instr : out std_logic_vector(15 downto 0);
		gfx_instr_wr : out std_logic;
		gfx_instr_full : in std_logic;
		hex0 : in std_logic_vector(6 downto 0);
		hex1 : in std_logic_vector(6 downto 0);
		hex2 : in std_logic_vector(6 downto 0);
		hex3 : in std_logic_vector(6 downto 0);
		hex4 : in std_logic_vector(6 downto 0);
		hex5 : in std_logic_vector(6 downto 0);
		hex6 : in std_logic_vector(6 downto 0);
		hex7 : in std_logic_vector(6 downto 0);
		gisc  : out std_logic;
		sw_reset : out std_logic;
		emulated_gc_data : inout std_logic
	);
end entity;


architecture arch of dbg_port is
	signal emulated_gc_cntrl_state_slv : std_logic_vector(63 downto 0);
begin
	dbg_port_inst : dbg_port_top
	port map (
		clk              => clk,
		res_n            => res_n,
		rx               => rx,
		tx               => tx,
		hw_switches      => hw_switches,
		switches         => switches,
		hw_keys          => hw_keys,
		keys             => keys,
		ledr             => ledr,
		ledg             => ledg,
		gfx_instr        => gfx_instr,
		gfx_instr_wr     => gfx_instr_wr,
		gfx_instr_full   => gfx_instr_full,
		emulated_gc_data => emulated_gc_data,
		emulated_gc_cntrl_state => open,
		hex0 => hex0,
		hex1 => hex1,
		hex2 => hex2,
		hex3 => hex3,
		hex4 => hex4,
		hex5 => hex5,
		hex6 => hex6,
		hex7 => hex7,
		gisc  => gisc,
		sw_reset => sw_reset
	);
end architecture;
