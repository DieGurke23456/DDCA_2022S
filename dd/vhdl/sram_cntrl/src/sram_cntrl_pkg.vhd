library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package sram_cntrl_pkg is

	component sram_cntrl is
		generic (
			ADDR_WIDTH : integer := 20;
			DATA_WIDTH : integer := 16;
			WR_BUF_SIZE : integer := 8
		);
		port (
			clk : in std_logic;
			res_n : in std_logic;
			wr_addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
			wr_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
			wr : in std_logic;
			wr_full : out std_logic;
			wr_half_full : out std_logic;
			rd_addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
			rd : in std_logic;
			rd_busy : out std_logic;
			rd_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
			rd_valid : out std_logic;
			sram_dq : inout std_logic_vector(DATA_WIDTH-1 downto 0);
			sram_addr : out std_logic_vector(ADDR_WIDTH-1 downto 0);
			sram_ub_n : out std_logic;
			sram_lb_n : out std_logic;
			sram_we_n : out std_logic;
			sram_ce_n : out std_logic;
			sram_oe_n : out std_logic
		);
	end component;
end package;

