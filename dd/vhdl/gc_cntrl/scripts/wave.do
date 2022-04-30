onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Generics
add wave -noupdate /tb_gc_cntrl/CLK_SIGNAL
add wave -noupdate /tb_gc_cntrl/DATA_SIGNAL
add wave -noupdate /tb_gc_cntrl/state
add wave -noupdate -divider Signals
add wave -noupdate /tb_gc_cntrl/I_GC_CNTRL/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16197 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {752483 ps}
