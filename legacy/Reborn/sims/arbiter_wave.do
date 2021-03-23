onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_in_core0
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_in_core1
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_in_core2
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_in_core3
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_out_core0
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_out_core1
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_out_core2
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_out_core3
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/address_in_core0
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/address_in_core1
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/address_in_core2
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/address_in_core3
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_write
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/data_read
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/address
add wave -noupdate -radix binary /arbiter_tb/arbiter_inst/request
add wave -noupdate -radix binary /arbiter_tb/arbiter_inst/response
add wave -noupdate -radix binary /arbiter_tb/arbiter_inst/wren_core
add wave -noupdate -radix binary /arbiter_tb/arbiter_inst/wren
add wave -noupdate -radix binary /arbiter_tb/arbiter_inst/clk
add wave -noupdate -radix binary /arbiter_tb/arbiter_inst/current_state
add wave -noupdate -radix binary /arbiter_tb/arbiter_inst/wait_memory
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/last_res
add wave -noupdate -radix unsigned /arbiter_tb/arbiter_inst/time_spent
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 267
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
WaveRestoreZoom {0 ps} {365038 ps}
