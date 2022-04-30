
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tpg is
	generic (
		WIDTH : integer := 640;
		HEIGHT : integer := 480
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		
		prepare_frame_start : in std_logic;
		pix_ack : in std_logic;
		pix_data_r : out std_logic_vector(7 downto 0);
		pix_data_g : out std_logic_vector(7 downto 0);
		pix_data_b : out std_logic_vector(7 downto 0)
	);
end entity;


architecture arch of tpg is
	signal x : integer range 0 to WIDTH-1;
	signal y : integer range 0 to HEIGHT-1;
	signal first_pix : std_logic;
begin
	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			x <= 0;
			y <= 0;
			pix_data_r <= (others=>'0');
			pix_data_g <= (others=>'0');
			pix_data_b <= (others=>'0');
			first_pix <= '0';
		elsif (rising_edge(clk)) then
			first_pix <= prepare_frame_start;
			
			if (prepare_frame_start = '1') then
				x <= 0;
				y <= 0;
			end if;
		
			if (first_pix = '1' or pix_ack = '1') then
				if (x = WIDTH-1) then
					y <= y + 1;
					x <= 0;
				else
					x <= x + 1;
				end if;
				
				--black
				pix_data_r <= (others=>'0');
				pix_data_g <= (others=>'0');
				pix_data_b <= (others=>'0');
				
				if (x < 256 and y < 256 ) then
					pix_data_r <= std_logic_vector(to_unsigned(x,8));
					pix_data_g <= std_logic_vector(to_unsigned(y,8));
					pix_data_b <= std_logic_vector(to_unsigned(255-x,8));
				elsif (x < 128) then
					pix_data_r <= (others=>'0');
					pix_data_g <= (others=>'0');
					pix_data_b <= (others=>'0');
				elsif (x < 128*2) then
					pix_data_r <= (others=>'1');
					pix_data_g <= (others=>'1');
					pix_data_b <= (others=>'1');
				elsif (x < 128*3) then
					pix_data_r <= (others=>'1');
					pix_data_g <= (others=>'0');
					pix_data_b <= (others=>'0');
				elsif (x < 128*4) then
					pix_data_r <= (others=>'0');
					pix_data_g <= (others=>'1');
					pix_data_b <= (others=>'0');
				else 
					pix_data_r <= (others=>'0');
					pix_data_g <= (others=>'0');
					pix_data_b <= (others=>'1');
				end if;
				
				--white frame
				if (x=0 or x=WIDTH-1 or y=0 or y=HEIGHT-1) then
					pix_data_r <= (others=>'1');
					pix_data_g <= (others=>'1');
					pix_data_b <= (others=>'1');
				end if;
			end if;
		end if;
	end process;

end architecture;
