onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /interrupt_controller_tb/clk
add wave -noupdate -radix binary /interrupt_controller_tb/core_interrupts
add wave -noupdate -radix binary /interrupt_controller_tb/interrupt_finish
add wave -noupdate /interrupt_controller_tb/inter_controller/internal_interrupt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34030 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 252
configure wave -valuecolwidth 100
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
WaveRestoreZoom {8460 ps} {170290 ps}
