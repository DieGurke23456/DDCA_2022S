
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.ram_pkg.all;

entity frame_reader is
	generic (
		VRAM_ADDR_WIDTH : integer;
		VRAM_DATA_WIDTH : integer := 16
	);
	port(
		clk : std_logic;
		res_n : std_logic;
	
		frame_start : out std_logic;
		vram_base_addr : in std_logic_vector(VRAM_ADDR_WIDTH-1 downto 0);
	
		-- read interface
		vram_rd_addr : out std_logic_vector(VRAM_ADDR_WIDTH-1 downto 0);
		vram_rd : out std_logic;
		vram_rd_busy : in std_logic;
		vram_rd_data : in std_logic_vector(VRAM_DATA_WIDTH-1 downto 0);
		vram_rd_valid : in std_logic;
		
		
		display_clk : in std_logic;
		display_res_n : in std_logic;
		
		--interface to VGA controller
		prepare_frame_start : in std_logic;
		pix_ack : in std_logic;
		pix_data_r : out std_logic_vector(7 downto 0);
		pix_data_g : out std_logic_vector(7 downto 0);
		pix_data_b : out std_logic_vector(7 downto 0)
	);
begin
	assert VRAM_DATA_WIDTH = 16 report "Unsupported data width" severity failure;
end entity;


architecture arch of frame_reader is

	signal pix_data : std_logic_vector(VRAM_DATA_WIDTH-1 downto 0);
	signal half_full : std_logic;
	signal rd_ack : std_logic;

	constant WIDTH : integer := 320;
	constant HEIGHT : integer := 240;
	
	type frame_reader_state_t is (WAIT_FRAME_START, READ_BASE_ADDR, BURST_START, BURST, WAIT_BURST_COMPLETE);
	signal state : frame_reader_state_t;
	signal state_nxt : frame_reader_state_t;
	
	signal x_cnt : std_logic_vector(log2c(WIDTH)-1 downto 0);
	signal x_cnt_nxt : std_logic_vector(log2c(WIDTH)-1 downto 0);
	
	signal y_cnt : std_logic_vector(log2c(2*HEIGHT-1)-1 downto 0);
	signal y_cnt_nxt : std_logic_vector(log2c(2*HEIGHT-1)-1 downto 0);
	
	signal cur_mem_pointer : std_logic_vector(VRAM_ADDR_WIDTH-1 downto 0);
	signal cur_mem_pointer_nxt : std_logic_vector(VRAM_ADDR_WIDTH-1 downto 0);
begin
	vram_rd_addr <= cur_mem_pointer;

	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= WAIT_FRAME_START;
			cur_mem_pointer <= (others=>'0');
			x_cnt <= (others=>'0');
			y_cnt <= (others=>'0');
		elsif (rising_edge(clk)) then
			state <= state_nxt;
			cur_mem_pointer <= cur_mem_pointer_nxt;
			x_cnt <= x_cnt_nxt;
			y_cnt <= y_cnt_nxt;
		end if;
	end process;

	process(all)
	begin
		state_nxt <= state;
		cur_mem_pointer_nxt <= cur_mem_pointer;
		x_cnt_nxt <= x_cnt;
		y_cnt_nxt <= y_cnt;
		
		vram_rd <= '0';
		frame_start <= '0';
		
		case state is
			when WAIT_FRAME_START =>
				if (prepare_frame_start = '1') then
					frame_start <= '1';
					state_nxt <= READ_BASE_ADDR;
					x_cnt_nxt <= (others=>'0');
					y_cnt_nxt <= (others=>'0');
				end if;
			
			when READ_BASE_ADDR =>
				cur_mem_pointer_nxt <= vram_base_addr;
				state_nxt <= BURST_START;
			
			when BURST_START =>
				if (vram_rd_busy = '0' and half_full = '0') then
					vram_rd <= '1';
					cur_mem_pointer_nxt <= std_logic_vector(unsigned(cur_mem_pointer) + 1);
					x_cnt_nxt <= std_logic_vector(unsigned(x_cnt) + 1);
					state_nxt <= BURST;
				end if;
			
			when BURST => 
				vram_rd <= '1';
				cur_mem_pointer_nxt <= std_logic_vector(unsigned(cur_mem_pointer) + 1);
				x_cnt_nxt <= std_logic_vector(unsigned(x_cnt) + 1);
				if (unsigned(x_cnt(1 downto 0)) = 3) then
					state_nxt <= WAIT_BURST_COMPLETE;
				end if;
			
			when WAIT_BURST_COMPLETE =>
				if (vram_rd_valid = '0') then
					state_nxt <= BURST_START;
				
					--do pointer management when line is complete
					if (unsigned(x_cnt) = WIDTH) then
						x_cnt_nxt <= (others=>'0');
						
						if (y_cnt(0) = '0') then
							cur_mem_pointer_nxt <= std_logic_vector(unsigned(cur_mem_pointer) - WIDTH);
						end if;
						
						if(y_cnt = 2*HEIGHT-1) then
							state_nxt <= WAIT_FRAME_START; --frame complete
						else
							y_cnt_nxt <= std_logic_vector(unsigned(y_cnt) + 1);
						end if;
					end if;
				end if;
		end case;
	end process;
	
	fifo_1c1r1w_fwft_inst : fifo_1c1r1w_fwft
	generic map (
		DEPTH      => 8,
		DATA_WIDTH => 16
	)
	port map (
		clk       => clk,
		res_n     => res_n,
		rd_data   => pix_data,
		rd_ack    => rd_ack,
		rd_valid  => open,
		wr_data   => vram_rd_data,
		wr        => vram_rd_valid,
		full      => open,
		half_full => half_full
	);

	--red
	pix_data_r(7 downto 4) <= pix_data(15 downto 12);
	pix_data_r(3 downto 0) <= (others=>pix_data(11));

	--green
	pix_data_g(7 downto 3) <= pix_data(10 downto 6);
	pix_data_g(2 downto 0) <= (others=>pix_data(5));

	--blue
	pix_data_b(7 downto 4) <= pix_data(4 downto 1) ;
	pix_data_b(3 downto 0) <= (others=>pix_data(0));


	count_pix_ack : block
		signal prev_pix_ack : std_logic_vector(2 downto 0);
	begin
		process(clk, res_n)
		begin
			if (res_n = '0') then
				prev_pix_ack <= (others=>'0');
			elsif (rising_edge(clk)) then
				prev_pix_ack(0) <= pix_ack;
				prev_pix_ack(1) <= prev_pix_ack(0);
				prev_pix_ack(2) <= prev_pix_ack(1);
				if(rd_ack = '1') then
					prev_pix_ack <= (others=>'0');
				end if;
			end if;
		end process;
		
		rd_ack <= '1' when pix_ack = '1' and (prev_pix_ack(2 downto 0) = "111") else '0';
	end block;

end architecture;
