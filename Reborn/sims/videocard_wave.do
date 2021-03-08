onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider videocard
add wave -noupdate -radix binary /videocard_tb/videocard_main/clk
add wave -noupdate -radix decimal /videocard_tb/videocard_main/data_in
add wave -noupdate -radix decimal /videocard_tb/videocard_main/data_out
add wave -noupdate -radix decimal /videocard_tb/videocard_main/address
add wave -noupdate -radix binary /videocard_tb/videocard_main/wren
add wave -noupdate -radix binary /videocard_tb/videocard_main/interrupt_start
add wave -noupdate -radix binary /videocard_tb/videocard_main/interrupt_finish
add wave -noupdate -divider core0
add wave -noupdate -radix binary /videocard_tb/videocard_main/core0/clk
add wave -noupdate -radix binary /videocard_tb/videocard_main/core0/response
add wave -noupdate -radix binary /videocard_tb/videocard_main/core0/instruction
add wave -noupdate -radix binary /videocard_tb/videocard_main/core0/wren
add wave -noupdate -radix binary /videocard_tb/videocard_main/core0/request
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/readdata
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/address
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/writedata
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/instr_addr
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/reg0
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/reg1
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/reg2
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/reg3
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/reg4
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/reg5
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/sp
add wave -noupdate -radix decimal /videocard_tb/videocard_main/core0/ip
add wave -noupdate -divider arbiter
add wave -noupdate -radix decimal /videocard_tb/videocard_main/arbiter_inst/data_in_core0
add wave -noupdate -radix decimal /videocard_tb/videocard_main/arbiter_inst/data_out_core0
add wave -noupdate -radix decimal /videocard_tb/videocard_main/arbiter_inst/address_in_core0
add wave -noupdate -radix binary /videocard_tb/videocard_main/arbiter_inst/request
add wave -noupdate -radix binary /videocard_tb/videocard_main/arbiter_inst/response
add wave -noupdate -radix binary /videocard_tb/videocard_main/arbiter_inst/wren_core
add wave -noupdate -radix binary /videocard_tb/videocard_main/arbiter_inst/current_state
add wave -noupdate -radix binary /videocard_tb/videocard_main/arbiter_inst/wait_memory
add wave -noupdate -radix decimal /videocard_tb/videocard_main/arbiter_inst/last_res
add wave -noupdate -radix decimal /videocard_tb/videocard_main/arbiter_inst/time_spent
add wave -noupdate -divider rom
add wave -noupdate -radix binary /videocard_tb/videocard_main/rom/clk
add wave -noupdate -radix decimal /videocard_tb/videocard_main/rom/address_core0
add wave -noupdate -radix binary /videocard_tb/videocard_main/rom/data_core0
add wave -noupdate -divider interrupt_controller
add wave -noupdate -radix binary /videocard_tb/videocard_main/inter_controller/clk
add wave -noupdate -radix binary /videocard_tb/videocard_main/inter_controller/core_interrupts
add wave -noupdate -radix binary /videocard_tb/videocard_main/inter_controller/interrupt
add wave -noupdate -radix binary /videocard_tb/videocard_main/inter_controller/internal_interrupt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {322639 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 364
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
WaveRestoreZoom {0 ps} {456658 ps}
