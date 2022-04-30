library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tetris_util_pkg.all;
use work.vga_gfx_cntrl_pkg.all;

entity tetromino_drawer is
	generic (
		BLOCK_SIZE : integer;
		BLOCK_ROW : integer
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		
		start : in std_logic;
		busy : out std_logic;
		
		x : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0); --signed
		y : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0); --signed
		tetromino : tetromino_t;
		rotation : rotation_t;
		
		gfx_instr       : out std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
		gfx_instr_wr    : out std_logic;
		gfx_instr_full  : in std_logic
	); 
end entity;


architecture arch of tetromino_drawer is
	type fsm_state_t is (TD_IDLE, MOVE_GP, MOVE_GP_X, MOVE_GP_Y, BB, BB_X, BB_Y, BB_WIDTH, BB_HEIGHT);
	type state_t is record 
		fsm_state : fsm_state_t;
		block_coutner : std_logic_vector(3 downto 0);
		done : std_logic;
	end record;
	
	signal state, state_nxt : state_t;
begin
	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => TD_IDLE,
				block_coutner => (others=>'0'),
				done => '0'
			);
		elsif (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;
	
	next_state : process(all)
	begin
		state_nxt <= state;
		busy <= '1';
		gfx_instr_wr <= '0';
		gfx_instr <= (others=>'0');
		
		case state.fsm_state is
			when TD_IDLE => 
				busy <= '0';
				if (start = '1') then
					busy <= '1';
					state_nxt.fsm_state <= MOVE_GP;
					state_nxt.block_coutner <= (others=>'0');
					state_nxt.done <= '0';
				end if;
			
			when MOVE_GP =>
				if (state.done = '1') then
					state_nxt.fsm_state <= TD_IDLE;
					state_nxt.done <= '0';
				elsif (gfx_instr_full = '0') then
					--new line?
					if (state.block_coutner(1 downto 0) = "00") then 
						state_nxt.fsm_state <= MOVE_GP_X;
						gfx_instr <= gfx_instr_move_gp(relative => false);
						gfx_instr_wr <= '1';
					else
						state_nxt.fsm_state <= BB;
					end if;
				end if;
			
			when MOVE_GP_X =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= MOVE_GP_Y;
					gfx_instr_wr <= '1';
					gfx_instr <= std_logic_vector(resize(signed(x), gfx_instr'length));
				end if;
				
			when MOVE_GP_Y =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= BB;
					gfx_instr_wr <= '1';
					if (unsigned(state.block_coutner) = 0) then
						gfx_instr <= std_logic_vector(resize(signed(y) + BLOCK_SIZE*0, gfx_instr'length));
					elsif (unsigned(state.block_coutner) = 4) then
						gfx_instr <= std_logic_vector(resize(signed(y) + BLOCK_SIZE*1, gfx_instr'length));
					elsif (unsigned(state.block_coutner) = 8) then
						gfx_instr <= std_logic_vector(resize(signed(y) + BLOCK_SIZE*2, gfx_instr'length));
					elsif (unsigned(state.block_coutner) = 12) then
						gfx_instr <= std_logic_vector(resize(signed(y) + BLOCK_SIZE*3, gfx_instr'length));
					end if;
				end if;
				
			when BB =>
				if (gfx_instr_full = '0') then
					if (unsigned(state.block_coutner) = 15) then
						state_nxt.done <= '1';
					else
						state_nxt.block_coutner <= std_logic_vector(unsigned(state.block_coutner) + 1);
					end if;
					
					if (is_tetromino_solid_at(tetromino, rotation, state.block_coutner(1 downto 0), state.block_coutner(3 downto 2))) then
						gfx_instr_wr <= '1';
						gfx_instr <= gfx_instr_bit_blit(
							movx => true, movy => false,
							alpha_mode => false,
							vflip => false, hflip => False
						);
						state_nxt.fsm_state <= BB_X;
					else
						--draw nothing, just move the gp
						gfx_instr_wr <= '1';
						gfx_instr <= gfx_instr_inc_gp_x(std_logic_vector(to_unsigned(BLOCK_SIZE, 12)));
						state_nxt.fsm_state <= MOVE_GP;
					end if;
				end if;
			
			when BB_X =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= BB_Y;
					gfx_instr_wr <= '1';
					gfx_instr <= std_logic_vector(resize(to_unsigned(BLOCK_SIZE, GFX_INSTR_WIDTH) * unsigned(tetromino), GFX_INSTR_WIDTH));
				end if;
			
			when BB_Y =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= BB_WIDTH;
					gfx_instr_wr <= '1';
					gfx_instr <= std_logic_vector(to_unsigned(BLOCK_ROW*BLOCK_SIZE, GFX_INSTR_WIDTH));
				end if;
			
			when BB_WIDTH =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= BB_HEIGHT;
					gfx_instr_wr <= '1';
					gfx_instr <= std_logic_vector(to_unsigned(BLOCK_SIZE, GFX_INSTR_WIDTH));
				end if;
			
			when BB_HEIGHT =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= MOVE_GP;
					gfx_instr_wr <= '1';
					gfx_instr <= std_logic_vector(to_unsigned(BLOCK_SIZE, GFX_INSTR_WIDTH));
				end if;
		end case;
		
	end process;
end architecture;
