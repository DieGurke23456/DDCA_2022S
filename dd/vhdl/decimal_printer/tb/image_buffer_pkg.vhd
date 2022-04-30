library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package image_buffer_pkg is
	type image_buffer_t is protected
		procedure Init(w, h, d : natural);
		impure function get_width return integer;
		impure function get_height return integer;
		impure function get_pixel(x,y : integer) return std_logic_vector;
		procedure set_pixel(x,y : integer; color : std_logic_vector);
	end protected;
end package;

package body image_buffer_pkg is

	type image_buffer_t is protected body
		type img_data_t is array(natural range<>) of std_logic_vector;
		type img_data_ptr_t is access img_data_t;
		variable width, height, color_depth : natural;
		variable img_data : img_data_ptr_t;
		
		procedure Init(w, h, d : natural) is
		begin
			width := w;
			height := h;
			color_depth := d;
			img_data := new img_data_t(0 to w*h-1)(d-1 downto 0);
			for i in 0 to w*h-1 loop
				img_data(i) := std_logic_vector(to_unsigned(0, d));
			end loop;
		end procedure;
		
		impure function get_width return integer is
		begin
			return width;
		end function;
		impure function get_height return integer is
		begin
			return height;
		end function;
		
		impure function get_pixel(x,y : integer) return std_logic_vector is
			variable color : std_logic_vector(color_depth-1 downto 0);
		begin
			color := img_data(y*width+x);
			return color;
		end function;
		
		procedure set_pixel(x,y : integer; color : std_logic_vector) is
		begin
			img_data(y*width+x) := color;
		end procedure;
	end protected body;

end package body;
