onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MM_and_SM_tb/wren_in
add wave -noupdate -radix unsigned /MM_and_SM_tb/address
add wave -noupdate -radix unsigned /MM_and_SM_tb/data_tx
add wave -noupdate -radix unsigned /MM_and_SM_tb/data_rx
add wave -noupdate /MM_and_SM_tb/i
add wave -noupdate /MM_and_SM_tb/clk
add wave -noupdate /MM_and_SM_tb/instruction
add wave -noupdate /MM_and_SM_tb/SM_inst/address
add wave -noupdate /MM_and_SM_tb/core_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2406960 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 268
configure wave -valuecolwidth 132
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {103240 ps}
