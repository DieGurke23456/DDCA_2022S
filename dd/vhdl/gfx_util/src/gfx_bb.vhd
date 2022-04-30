
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.gfx_util_pkg.all;

entity gfx_bb is
	generic (
		DATA_WIDTH : integer;
		BB_ROM : bb_rom_t
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		
		--control signals
		start : in std_logic;
		stall : in std_logic;
		busy : out std_logic;
		
		--drawing parameters
		w : in std_logic_vector(DATA_WIDTH-1 downto 0);
		h : in std_logic_vector(DATA_WIDTH-1 downto 0);
		x_src : in std_logic_vector(DATA_WIDTH-1 downto 0);
		y_src : in std_logic_vector(DATA_WIDTH-1 downto 0);
		x_dest : in std_logic_vector(DATA_WIDTH-1 downto 0);
		y_dest : in std_logic_vector(DATA_WIDTH-1 downto 0);
		vflip : in std_logic;
		hflip : in std_logic;

		--pixel coordinates output
		pixel_valid : out std_logic;
		pixel_color : out std_logic_vector(3 downto 0);
		pixel_x : out std_logic_vector(DATA_WIDTH-1 downto 0);
		pixel_y : out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity;

architecture arch of gfx_bb is

	constant BB_ROM_ADDR_WIDTH : integer := log2c(BB_ROM'length);

	type state_t is record
		pixel_x : std_logic_vector(DATA_WIDTH-1 downto 0);
		pixel_y : std_logic_vector(DATA_WIDTH-1 downto 0);
		src_pixel_x : std_logic_vector(BB_ROM_ADDR_WIDTH/2-1 downto 0);
		src_pixel_y : std_logic_vector(BB_ROM_ADDR_WIDTH/2-1 downto 0);
		running : std_logic;
	end record;
	
	constant STATE_RESET : state_t := (
		pixel_y => (others=>'0'),
		pixel_x => (others=>'0'),
		src_pixel_x => (others=>'0'),
		src_pixel_y => (others=>'0'),
		running => '0'
	);
	
	signal state, state_nxt : state_t;
	
	type output_reg_t is record
		pixel_x : std_logic_vector(DATA_WIDTH-1 downto 0);
		pixel_y : std_logic_vector(DATA_WIDTH-1 downto 0);
		pixel_valid : std_logic;
	end record;
	
	signal output_reg, output_reg_nxt : output_reg_t;
	
	signal rom_data : std_logic_vector(3 downto 0) := (others=>'0'); --init for simulation
	signal rom_addr : std_logic_vector(BB_ROM_ADDR_WIDTH-1 downto 0);
	signal rom_rd : std_logic;
begin
	busy <= state.running or output_reg.pixel_valid;
	
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
		rom_rd <= '0';
		
		if (start = '1') then
			state_nxt.running <= '1';
			state_nxt.pixel_x <= x_dest;
			state_nxt.pixel_y <= y_dest;
			if (hflip = '1') then
				state_nxt.src_pixel_x <= std_logic_vector(
					unsigned(x_src(BB_ROM_ADDR_WIDTH/2-1 downto 0)) +
					unsigned(w(BB_ROM_ADDR_WIDTH/2-1 downto 0)) - 1);
			else
				state_nxt.src_pixel_x <= x_src(BB_ROM_ADDR_WIDTH/2-1 downto 0);
			end if;
			
			if (vflip = '1') then
				state_nxt.src_pixel_y <= std_logic_vector(
					unsigned(y_src(BB_ROM_ADDR_WIDTH/2-1 downto 0)) +
					unsigned(h(BB_ROM_ADDR_WIDTH/2-1 downto 0)) - 1);
			else
				state_nxt.src_pixel_y <= y_src(BB_ROM_ADDR_WIDTH/2-1 downto 0);
			end if;
		end if;
		
		if(state.running = '1' ) then
			
			rom_rd <= '1';
			
			if (state.pixel_x = std_logic_vector(signed(x_dest)+signed(w)-1)) then
				state_nxt.pixel_x <= x_dest;
				if (hflip = '1') then
					state_nxt.src_pixel_x <= std_logic_vector(
						unsigned(x_src(BB_ROM_ADDR_WIDTH/2-1 downto 0)) +
						unsigned(w(BB_ROM_ADDR_WIDTH/2-1 downto 0)) - 1);
				else
					state_nxt.src_pixel_x <= x_src(BB_ROM_ADDR_WIDTH/2-1 downto 0);
				end if;
				
				if (state.pixel_y = std_logic_vector(signed(y_dest)+signed(h)-1)) then
					state_nxt.running <= '0';
				else
					state_nxt.pixel_y <= std_logic_vector(signed(state.pixel_y) + 1);
					if (vflip = '1') then
						state_nxt.src_pixel_y <= std_logic_vector(unsigned(state.src_pixel_y) - 1);
					else
						state_nxt.src_pixel_y <= std_logic_vector(unsigned(state.src_pixel_y) + 1);
					end if;
				end if;
			else
				state_nxt.pixel_x <= std_logic_vector(signed(state.pixel_x) + 1);
				if (hflip = '1') then
					state_nxt.src_pixel_x <= std_logic_vector(unsigned(state.src_pixel_x) - 1);
				else
					state_nxt.src_pixel_x <= std_logic_vector(unsigned(state.src_pixel_x) + 1);
				end if;
			end if;
			
			
		end if;
	end process;
	
	rom_addr <= state.src_pixel_y & state.src_pixel_x;

	rom : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rom_rd = '1' and stall = '0') then
				rom_data <= BB_ROM(to_integer(unsigned(rom_addr)));
			end if;
		end if;
	end process;

	output_reg_comb : process(all)
	begin
		output_reg_nxt <= output_reg;
		output_reg_nxt.pixel_x <= state.pixel_x;
		output_reg_nxt.pixel_y <= state.pixel_y;
		output_reg_nxt.pixel_valid <= rom_rd;
	end process;
	
	output_reg_sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			output_reg <= (
				pixel_x => (others=>'0'),
				pixel_y => (others=>'0'),
				pixel_valid => '0'
			);
		elsif (rising_edge(clk)) then
			if stall = '0' then
				output_reg <= output_reg_nxt;
			end if;
		end if;
	end process;
	
	pixel_color <= rom_data;
	pixel_x <= output_reg.pixel_x;
	pixel_y <= output_reg.pixel_y;
	pixel_valid <= output_reg.pixel_valid;
end architecture;
