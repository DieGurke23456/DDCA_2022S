library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.gc_cntrl_pkg.all;

entity precompiled_gc_cntrl is
	port (
		clk : in std_logic;
		res_n : in std_logic;

		-- connection to the controller
		data : inout std_logic;

		-- internal connection
		cntrl_state : out gc_cntrl_state_t;
		rumble : in std_logic
	);
end entity;

architecture rtl of precompiled_gc_cntrl is
	component gc_cntrl_top is
		port (
			clk : in std_logic;
			res_n : in std_logic;
			data : inout std_logic;
			cntrl_state : out std_logic_vector(63 downto 0);
			rumble : in std_logic
		);
	end component;
	signal cntrl_state_int : std_logic_vector(63 downto 0);
begin
	gc_cntrl_top_inst : gc_cntrl_top
	port map (
		clk         => clk,
		res_n       => res_n,
		data        => data,
		cntrl_state => cntrl_state_int,
		rumble      => rumble
	);
	cntrl_state <= to_gc_cntrl_state(cntrl_state_int);
end architecture;
