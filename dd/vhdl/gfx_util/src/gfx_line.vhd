
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;

entity gfx_line is
	generic (
		DATA_WIDTH : integer
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		
		--control signals
		start : in std_logic;
		stall : in std_logic;
		busy : out std_logic;
		
		--drawing parameters
		x0 : in std_logic_vector(DATA_WIDTH-1 downto 0);
		y0 : in std_logic_vector(DATA_WIDTH-1 downto 0);
		x1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
		y1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
		
		--pixel coordinates output
		pixel_valid : out std_logic;
		pixel_x : out std_logic_vector(DATA_WIDTH-1 downto 0);
		pixel_y : out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity;

architecture arch of gfx_line is

	type state_t is record
		dx : integer range -2**(DATA_WIDTH+1) to 2**(DATA_WIDTH+1)-1;
		dy : integer range -2**(DATA_WIDTH+1) to 2**(DATA_WIDTH+1)-1;
		err : integer range -2**(DATA_WIDTH+1) to 2**(DATA_WIDTH+1)-1;
		
		pixel_x : std_logic_vector(DATA_WIDTH-1 downto 0);
		pixel_y : std_logic_vector(DATA_WIDTH-1 downto 0);
		
		sx : std_logic;
		sy : std_logic;
		
		running : std_logic;
	end record;
	
	constant STATE_RESET : state_t := (
		dx => 0, dy => 0, err => 0,
		pixel_x => (others=>'0'), pixel_y => (others=>'0'),
		others => '0'
	);
	
	signal state : state_t := STATE_RESET;
	signal state_nxt : state_t;
	
	constant ADD_ONE : std_logic := '1';
	constant SUB_ONE : std_logic := '0';
begin
	busy <= state.running or pixel_valid;
	pixel_x <= state.pixel_x;
	pixel_y <= state.pixel_y;
	
	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= STATE_RESET;
		elsif (rising_edge(clk)) then
			if stall = '0' then
				state <= state_nxt;
			end if;
		end if;
	end process;
	
	nxt : process(all)
		variable err_temp_var : integer;
	begin
		state_nxt <= state;
		pixel_valid <= '0';
		err_temp_var := 0;
		
		if (start = '1') then
			state_nxt.pixel_x <= x0;
			state_nxt.pixel_y <= y0;

			state_nxt.dx <= abs(to_integer(signed(x1(DATA_WIDTH-1) & x1) - signed(x0)));
			state_nxt.dy <= -abs(to_integer(signed(y1(DATA_WIDTH-1) & y1) - signed(y0)));
			
			if signed(x0) < signed(x1) then
				state_nxt.sx <= ADD_ONE;
			else
				state_nxt.sx <= SUB_ONE;
			end if;

			if signed(y0) < signed(y1) then
				state_nxt.sy <= ADD_ONE;
			else
				state_nxt.sy <= SUB_ONE;
			end if;

			state_nxt.err <= abs(to_integer(signed(x1(DATA_WIDTH-1) & x1) - signed(x0)))-
				abs(to_integer(signed(y1(DATA_WIDTH-1) & y1) - signed(y0)));
				
			state_nxt.running <= '1';
		end if;
		
		if(state.running = '1' ) then
			pixel_valid <= '1';
			err_temp_var := state.err;
				
			-- The following two if-statements can be true 
			-- at the same time! That means that only 
			-- the last signal assignment is executed if 
			-- only signals for the error are used!
			if ((state.err*2) >= state.dy) then 
				err_temp_var := state.err + state.dy;
				if(state.sx = SUB_ONE) then
					state_nxt.pixel_x <= std_logic_vector(signed(state.pixel_x) - 1);
				else
					state_nxt.pixel_x <= std_logic_vector(signed(state.pixel_x) + 1);
				end if;
			end if; 
		
			if ((state.err*2) <= state.dx) then 
				err_temp_var := err_temp_var + state.dx;
				if(state.sy = SUB_ONE) then
					state_nxt.pixel_y <= std_logic_vector(signed(state.pixel_y) - 1);
				else
					state_nxt.pixel_y <= std_logic_vector(signed(state.pixel_y) + 1);
				end if;
			end if;
		
			state_nxt.err <= err_temp_var;
			
			if (
				signed(state.pixel_x) = signed(x1) and
				signed(state.pixel_y) = signed(y1)
			) then
				state_nxt.running <= '0';
			end if;
		end if;
	end process;
end architecture;
