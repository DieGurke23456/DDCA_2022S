library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.tetris_util_pkg.all;

entity tetromino_collider is
	generic (
		BLOCKS_X : integer;
		BLOCKS_Y : integer
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		
		start : in std_logic;
		busy : out std_logic;
		collision_detected : out std_logic;
		
		tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
		tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
		tetromino : tetromino_t;
		rotation : rotation_t;
		
		block_map_x : out std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
		block_map_y : out std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
		block_map_rd : out std_logic;
		block_map_solid : in std_logic
	); 
end entity;


architecture arch of tetromino_collider is
	type fsm_state_t is (IDLE, READ_BLOCK_MAP, CHECK_BLOCK_MAP, DONE_COLLISION_DETECTED, DONE_NO_COLLISION_DETECTED);

	type state_t is record
		fsm_state : fsm_state_t;
		block_counter : std_logic_vector(3 downto 0);
		collision_detected : std_logic;
	end record;
	
	signal state, state_nxt : state_t;
begin
	collision_detected <= state.collision_detected;
	
	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => IDLE,
				block_counter => (others=>'0'),
				collision_detected => '0'
			);
		elsif (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;
	
	next_state : process(all)
	begin
		state_nxt <= state;
		busy <= '1';
		block_map_rd <= '0';
		block_map_x <= (others=>'0');
		block_map_y <= (others=>'0');
		
		case state.fsm_state is
			when IDLE =>
				busy <= '0';
				if (start = '1') then
					state_nxt.block_counter <= (others=>'0');
					state_nxt.fsm_state <= READ_BLOCK_MAP;
				end if;
			
			when READ_BLOCK_MAP =>
				
				if (is_tetromino_solid_at(tetromino, rotation, state.block_counter(1 downto 0), state.block_counter(3 downto 2))) then
					-- out of bounds?
					if (
						signed(tetromino_x) + signed('0' & state.block_counter(1 downto 0)) < 0 or
						signed(tetromino_y) + signed('0' & state.block_counter(3 downto 2)) < 0 or
						signed(tetromino_x) + signed('0' & state.block_counter(1 downto 0)) >= BLOCKS_X or
						signed(tetromino_y) + signed('0' & state.block_counter(3 downto 2)) >= BLOCKS_Y 
						
					) then
						state_nxt.fsm_state <= DONE_COLLISION_DETECTED;
					else
						block_map_rd <= '1';
						block_map_x <= std_logic_vector(resize(unsigned(tetromino_x) + unsigned(state.block_counter(1 downto 0)), block_map_x'length));
						block_map_y <= std_logic_vector(resize(unsigned(tetromino_y) + unsigned(state.block_counter(3 downto 2)), block_map_y'length));
						state_nxt.fsm_state <= CHECK_BLOCK_MAP;
					end if;
				else
					--nothing to check
					if (unsigned(state.block_counter) = 15) then
						state_nxt.fsm_state <= DONE_NO_COLLISION_DETECTED;
					else
						state_nxt.block_counter <= std_logic_vector(unsigned(state.block_counter) + 1);
						state_nxt.fsm_state <= READ_BLOCK_MAP;
					end if;
				end if;
			
			when CHECK_BLOCK_MAP =>
				if (block_map_solid = '1') then
					state_nxt.fsm_state <= DONE_COLLISION_DETECTED;
				else
					if (unsigned(state.block_counter) = 15) then
						state_nxt.fsm_state <= DONE_NO_COLLISION_DETECTED;
					else
						state_nxt.block_counter <= std_logic_vector(unsigned(state.block_counter) + 1);
						state_nxt.fsm_state <= READ_BLOCK_MAP;
					end if;
				end if;
			
			when DONE_COLLISION_DETECTED =>
				state_nxt.fsm_state <= IDLE;
				state_nxt.collision_detected <= '1';
				
			when DONE_NO_COLLISION_DETECTED =>
				state_nxt.fsm_state <= IDLE;
				state_nxt.collision_detected <= '0';
			
			when others =>
		end case;
	end process;
end architecture;
