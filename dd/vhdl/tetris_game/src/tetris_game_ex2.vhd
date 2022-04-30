use work.vga_gfx_cntrl_pkg.all;
use work.math_pkg.all;
use work.gc_cntrl_pkg.all;
use work.audio_cntrl_pkg.all;
use work.ram_pkg.all;
use work.tetris_util_pkg.all;
use work.decimal_printer_pkg.all;

architecture ex2 of tetris_game is 

    type gfx_instr_array_t is array(natural range<>) of std_logic_vector;
    constant DISPLAY_WIDTH : integer := 320;
    constant DISPLAY_HEIGHT : integer := 240;
    constant BLOCK_SIZE : integer := 12; 
    constant BLOCK_SIZE_SLV : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(BLOCK_SIZE, log2c(BLOCK_SIZE)));
    constant BLOCKS_X : integer := 10;
    constant BLOCKS_Y : integer := 20;

    type state_t is record
        fsm_state : fsm_state_t;
        last_controller_state : gc_cntrl_state_t;
        cur_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
        cur_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
        cur_tetromino : tetromino_t;
        cur_rotation : rotation_t;
        
        dest_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
        dest_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
        dest_tetromino : tetromino_t;
        dest_rotation : rotation_t;
        
        next_tetromino : tetromino_t;

        row_counter : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
        column_counter : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
    end record;

    signal state, state_nxt : state_t;


    

begin
    sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => RESET,
				last_controller_state => GC_BUTTONS_RESET_VALUE,
				cur_tetromino => TET_Z,
				next_tetromino => TET_I,
				others => (others=>'0')
			);
		elsif (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;
end architecture;