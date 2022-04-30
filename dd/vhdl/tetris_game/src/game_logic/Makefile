VCOM_ARGS=-2008 -work work -suppress 1236
VSIM_ARGS=-msgmode both

# The order is important!
# Compile of tetris_util_pkg.vhd was successful.
# Compile of vga_gfx_cntrl_pkg.vhd was successful.
# Compile of gfx_util_pkg.vhd was successful.
# Compile of ram_pkg.vhd was successful.
# Compile of bb_rom_pkg.vhd was successful.
# Compile of tetromino_collider.vhd was successful.
# Compile of tetromino_drawer.vhd was successful.
# Compile of precompiled_vga_gfx_cntrl.vho was successful.
# Compile of tpg.vhd was successful.
# Compile of dp_ram_1c1r1w.vhd was successful.
# Compile of gfx_bb.vhd was successful.
# Compile of gfx_line.vhd was successful.
# Compile of frame_reader.vhd was successful.
# Compile of fifo_1c1r1w.vhd was successful.
# Compile of fifo_1c1r1w_fwft.vhd was successful.
# Compile of tetris_drawers_package.vhd was successful.
# Compile of tetris_drawers_package_tb.vhd was successful.


VHDL_FILES = \
	../../../math/src/math_pkg.vhd\
	../../../vga_gfx_cntrl/src/vga_gfx_cntrl_pkg.vhd\
	../../../tetris_util/src/tetris_util_pkg.vhd\
	../../../gfx_util/src/gfx_util_pkg.vhd\
	../../../ram/src/ram_pkg.vhd\
	../../../vga_gfx_cntrl/src/bb_rom_pkg.vhd\
	../../../tetris_util/src/tetromino_collider.vhd\
	../../../tetris_util/src/tetromino_drawer.vhd\
	../../../vga_gfx_cntrl/src/precompiled_vga_gfx_cntrl.vho\
	../../../vga_gfx_cntrl/src/tpg.vhd\
	../../../ram/src/dp_ram_1c1r1w.vhd\
	../../../gfx_util/src/gfx_bb.vhd\
	../../../gfx_util/src/gfx_line.vhd\
	../../../vga_gfx_cntrl/src/frame_reader.vhd\
	../../../ram/src/fifo_1c1r1w.vhd\
	../../../ram/src/fifo_1c1r1w_fwft.vhd\
	../drawers/tetris_drawers_package.vhd\
	../drawers/block_drawer.vhd\
	../drawers/block_line_drawer.vhd\
	../drawers/block_matrix_drawer.vhd\
	./tetris_game_logic_pkg.vhd\
	./tb/rows_full_handler_tb.vhd\
	./rows_full_handler.vhd\
	./add_tetromino_handler.vhd\
	../../../tetris_game/src/drawers/tb/tetris_drawers_package_tb.vhd

TB_FILES = \
	./tb/rows_full_handler_tb.vhd\
	./tb/add_tetromino_handler_tb.vhd\
	./tb/tetris_game_logic_pkg_tb.vhd

TIME_RESOLUTION = 1ps
TB_ROWS_FULL = tb_rows_full_handler
TB_ADD_TETROMINO = tb_add_tetromino_handler
TB_GAME_LOGIC = tb_tetris_game_logic_pkg
SIM_TIME = 2663 us
WAVE_FILE = scripts/wave.do

compile: log

log: $(VHDL_FILES) $(TB_FILES)
	rm -f log
	vlib work | tee log
	for i in $(VHDL_FILES); do \
		vcom $(VCOM_ARGS) $$i | tee -a log;\
	done;
	for i in $(TB_FILES); do \
		vcom $(VCOM_ARGS) $$i | tee -a log;\
	done;
	@echo "--------------------------------------------------------------"
	@echo "--              Error and Warning Summary                   --"
	@echo "--------------------------------------------------------------"
	@cat log | grep 'Warning\|Error'
	@if [[ $$(grep "Error:" -m 1 log) ]]; then \
		echo "Compilation had errors!" \
		exit 1; \
	fi;

list_sources:
	@for i in $(VHDL_FILES) $(TB_FILES); do \
		echo $$i;\
	done;

sim_rows_full: compile
	vsim -c -do "vsim $(TB_ROWS_FULL) -t $(TIME_RESOLUTION) $(VSIM_ARGS); run $(SIM_TIME);quit"

sim_rows_full_gui: compile
	vsim -do "vsim $(TB_ROWS_FULL) -t $(TIME_RESOLUTION) $(VSIM_ARGS); do $(WAVE_FILE);run $(SIM_TIME)" 

sim_add_tetromino: compile
	vsim -c -do "vsim $(TB_ADD_TETROMINO) -t $(TIME_RESOLUTION) $(VSIM_ARGS); run $(SIM_TIME);quit"

sim_game_logic: compile 
	vsim -c -do "vsim $(TB_GAME_LOGIC) -t $(TIME_RESOLUTION) $(VSIM_ARGS); run $(SIM_TIME);quit"

clean:
	rm -f transcript
	rm -f vsim.wlf
	rm -f log
	rm -fr work

.PHONY: clean
.PHONY: compile
.PHONY: sim
.PHONY: sim_gui