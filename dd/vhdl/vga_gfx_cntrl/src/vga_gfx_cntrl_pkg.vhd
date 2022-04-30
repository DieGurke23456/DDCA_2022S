library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package vga_gfx_cntrl_pkg is

	component vga_gfx_cntrl is
		port (
			clk   : in std_logic;
			res_n : in std_logic;
			
			display_clk   : in std_logic;
			display_res_n : in std_logic;
		
			--instruction interface
			gfx_instr       : in std_logic_vector(15 downto 0);
			gfx_instr_wr    : in std_logic;
			gfx_instr_full  : out std_logic;
			gfx_frame_sync  : out std_logic;
			
			--external interface to SRAM
			sram_dq : inout std_logic_vector(15 downto 0);
			sram_addr : out std_logic_vector(19 downto 0);
			sram_ub_n : out std_logic;
			sram_lb_n : out std_logic;
			sram_we_n : out std_logic;
			sram_ce_n : out std_logic;
			sram_oe_n : out std_logic;
			
			-- connection to VGA connector/DAC
			vga_hsync       : out std_logic;
			vga_vsync       : out std_logic;
			vga_dac_clk     : out std_logic;
			vga_dac_blank_n : out std_logic;
			vga_dac_sync_n  : out std_logic;
			vga_dac_r       : out std_logic_vector(7 downto 0);
			vga_dac_g       : out std_logic_vector(7 downto 0);
			vga_dac_b       : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component precompiled_vga_gfx_cntrl is
		port (
			clk   : in std_logic;
			res_n : in std_logic;
			
			display_clk   : in std_logic;
			display_res_n : in std_logic;
		
			--instruction interface
			gfx_instr       : in std_logic_vector(15 downto 0);
			gfx_instr_wr    : in std_logic;
			gfx_instr_full  : out std_logic;
			gfx_frame_sync  : out std_logic;
			
			--external interface to SRAM
			sram_dq : inout std_logic_vector(15 downto 0);
			sram_addr : out std_logic_vector(19 downto 0);
			sram_ub_n : out std_logic;
			sram_lb_n : out std_logic;
			sram_we_n : out std_logic;
			sram_ce_n : out std_logic;
			sram_oe_n : out std_logic;
			
			-- connection to VGA connector/DAC
			vga_hsync       : out std_logic;
			vga_vsync       : out std_logic;
			vga_dac_clk     : out std_logic;
			vga_dac_blank_n : out std_logic;
			vga_dac_sync_n  : out std_logic;
			vga_dac_r       : out std_logic_vector(7 downto 0);
			vga_dac_g       : out std_logic_vector(7 downto 0);
			vga_dac_b       : out std_logic_vector(7 downto 0)
		);
	end component;
	
	
	constant GFX_INSTR_WIDTH : integer := 16;
	
	constant OPCODE_NOP : std_logic_vector(3 downto 0) := x"0"; 
	constant OPCODE_MOVE_GP : std_logic_vector(3 downto 0) := x"1";
	constant OPCODE_SET_PIXEL : std_logic_vector(3 downto 0) := x"2";
	constant OPCODE_DRAW_LINE : std_logic_vector(3 downto 0) := x"3";
	constant OPCODE_CLEAR : std_logic_vector(3 downto 0) := x"4";
	constant OPCODE_BIT_BLIT :  std_logic_vector(3 downto 0) := x"5"; 
	constant OPCODE_COMPACT_BIT_BLIT :  std_logic_vector(3 downto 0) := x"6"; 
	constant OPCODE_CFG : std_logic_vector(3 downto 0) := x"7";
 
	constant OPCODE_INC_GP_X : std_logic_vector(3 downto 0) := x"8";
	constant OPCODE_INC_GP_Y : std_logic_vector(3 downto 0) := x"9";

	constant OPCODE_FRAME_SYNC : std_logic_vector(3 downto 0) := x"d";
	constant OPCODE_SELECT_PALETTE : std_logic_vector(3 downto 0) := x"e";
	constant OPCODE_LOAD_PALETTE : std_logic_vector(3 downto 0) := x"f";
	
	constant MOVX_INDEX : integer := 3;
	constant MOVY_INDEX : integer := 2;
	constant RELATIVE_FLAG_INDEX : integer := 0;
	constant ALPHA_MODE_FLAG_INDEX : integer := 8;
	constant HFLIP_INDEX : integer := 7;
	constant VFLIP_INDEX : integer := 6;
	constant EN_TPG_INDEX : integer := 0;
	constant EN_DB_INDEX : integer := 4;

	function gfx_instr_clear(color: std_logic_vector(3 downto 0)) return std_logic_vector;
	function gfx_instr_set_pixel(color: std_logic_vector(3 downto 0); movx, movy : boolean) return std_logic_vector;
	function gfx_instr_move_gp(relative : boolean) return std_logic_vector;
	function gfx_instr_inc_gp_x(value : std_logic_vector(11 downto 0)) return std_logic_vector;
	function gfx_instr_inc_gp_y(value : std_logic_vector(11 downto 0)) return std_logic_vector;
	function gfx_instr_frame_sync return std_logic_vector;
	function gfx_instr_draw_line(color: std_logic_vector(3 downto 0); movx, movy, relative : boolean) return std_logic_vector;
	function gfx_instr_cfg(en_tpg, en_db : boolean) return std_logic_vector;
	function gfx_instr_bit_blit(alpha_mode, hflip, vflip, movx, movy : boolean := False) return std_logic_vector;
	function gfx_instr_compact_bit_blit(alpha_mode, hflip, vflip, movx, movy : boolean := False) return std_logic_vector;
	function gfx_instr_load_palette(palette_index : integer range 0 to 31) return std_logic_vector;
	function gfx_instr_select_palette(alpha_color : std_logic_vector(3 downto 0); palette_index : integer range 0 to 31) return std_logic_vector;
	
	function gfx_instr_unsigned(v : integer) return std_logic_vector;
	function gfx_instr_signed(v : integer) return std_logic_vector;
end package;


package body vga_gfx_cntrl_pkg is

	function gfx_instr_frame_sync return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_FRAME_SYNC;
		return ret_val;
	end function;
	
	function gfx_instr_inc_gp_x(value : std_logic_vector(11 downto 0)) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_INC_GP_X;
		ret_val(11 downto 0) := value;
		return ret_val;
	end function;
	
	function gfx_instr_inc_gp_y(value : std_logic_vector(11 downto 0)) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_INC_GP_Y;
		ret_val(11 downto 0) := value;
		return ret_val;
	end function;

	function gfx_instr_bit_blit(alpha_mode, hflip, vflip, movx, movy : boolean  := False) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_BIT_BLIT;
		if (movx) then
			ret_val(MOVX_INDEX) := '1';
		end if;
		if (movy) then
			ret_val(MOVY_INDEX) := '1';
		end if;
		if (hflip) then
			ret_val(HFLIP_INDEX) := '1';
		end if;
		if (vflip) then
			ret_val(VFLIP_INDEX) := '1';
		end if;
		if (alpha_mode) then
			ret_val(ALPHA_MODE_FLAG_INDEX ) := '1';
		end if;
		return ret_val;
	end function;

	function gfx_instr_compact_bit_blit(alpha_mode, hflip, vflip, movx, movy : boolean  := False) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_COMPACT_BIT_BLIT;
		if (movx) then
			ret_val(MOVX_INDEX) := '1';
		end if;
		if (movy) then
			ret_val(MOVY_INDEX) := '1';
		end if;
		if (hflip) then
			ret_val(HFLIP_INDEX) := '1';
		end if;
		if (vflip) then
			ret_val(VFLIP_INDEX) := '1';
		end if;
		if (alpha_mode) then
			ret_val(ALPHA_MODE_FLAG_INDEX ) := '1';
		end if;
		return ret_val;
	end function;

	function gfx_instr_cfg(en_tpg, en_db : boolean) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_CFG;
		if (en_tpg) then
			ret_val(EN_TPG_INDEX) := '1';
		end if;
		if (en_db) then
			ret_val(EN_DB_INDEX) := '1';
		end if;
		return ret_val;
	end function;

	function gfx_instr_draw_line(color: std_logic_vector(3 downto 0); movx, movy, relative : boolean) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_DRAW_LINE;
		ret_val(11 downto 8) := color;
		if (movx) then
			ret_val(MOVX_INDEX) := '1';
		end if;
		if (movy) then
			ret_val(MOVY_INDEX) := '1';
		end if;
		if (relative) then
			ret_val(RELATIVE_FLAG_INDEX ) := '1';
		end if;
		return ret_val;
	end function;
	
	function gfx_instr_set_pixel(color: std_logic_vector(3 downto 0); movx, movy : boolean) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_SET_PIXEL;
		ret_val(11 downto 8) := color;
		if (movx) then
			ret_val(MOVX_INDEX) := '1';
		end if;
		if (movy) then
			ret_val(MOVY_INDEX) := '1';
		end if;
		return ret_val;
	end function;
	
	function gfx_instr_move_gp(relative : boolean) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_MOVE_GP;
		if (relative) then
			ret_val(RELATIVE_FLAG_INDEX ) := '1';
		end if;
		return ret_val;
	end function;
	
	function gfx_instr_clear(color: std_logic_vector(3 downto 0)) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_CLEAR;
		ret_val(11 downto 8) := color;
		return ret_val;
	end function;

	function gfx_instr_load_palette(palette_index : integer range 0 to 31) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_LOAD_PALETTE;
		ret_val(4 downto 0) := std_logic_vector(to_unsigned(palette_index, 5));
		return ret_val;
	end function;
	
	function gfx_instr_select_palette(alpha_color : std_logic_vector(3 downto 0); palette_index : integer range 0 to 31) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val(15 downto 12) := OPCODE_SELECT_PALETTE;
		ret_val(11 downto 8) := alpha_color;
		ret_val(4 downto 0) := std_logic_vector(to_unsigned(palette_index, 5));
		return ret_val;
	end function;


	function gfx_instr_unsigned(v : integer) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val := std_logic_vector(to_unsigned(v, GFX_INSTR_WIDTH));
		return ret_val;
	end function;
	
	
	function gfx_instr_signed(v : integer) return std_logic_vector is
		variable ret_val : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0) := (others=>'0');
	begin
		ret_val := std_logic_vector(to_signed(v, GFX_INSTR_WIDTH));
		return ret_val;
	end function;
	

end package body;

