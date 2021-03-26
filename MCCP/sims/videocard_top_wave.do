onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider videocard_top
add wave -noupdate /videocard_tb/clk
add wave -noupdate -radix unsigned /videocard_tb/address
add wave -noupdate -radix unsigned /videocard_tb/data_in
add wave -noupdate -radix unsigned /videocard_tb/data_out
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/data_out_control
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/data_in_control
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/read_control
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/write_control
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/address_control
add wave -noupdate -divider videocard
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/clk
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/data_in
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/data_out
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/address
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/wren
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/interrupt_start
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/interrupt_finish
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/write
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/read
add wave -noupdate -divider core
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/data_in_core0
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/data_out_core0
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/address_core0
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/instruction_core0
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/address_instr_core0
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/reg0
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/reg1
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/reg2
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/reg3
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/reg4
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/reg5
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/sp
add wave -noupdate -radix decimal /videocard_tb/videocard_top_inst/videocard_inst/core0/ip
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/flags
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/state
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/perform
add wave -noupdate -divider decoder
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/clk
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/en
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/long_instr
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/instr_choose
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/flags
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/core_index
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/alu_en
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/alu_opcode
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/mem_en
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/wren
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/move_en
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/immediate
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/mov_type
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/op1
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/op2
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/suffix
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/core0/instr_decoder_main/interrupt
add wave -noupdate -divider mm_control
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/mm_control/clk
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/mm_control/interrupt
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/mm_control/address
add wave -noupdate -divider arbiter
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/request
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/response
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/data_write
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/data_read
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/address
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/wren_core
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/wren
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/clk
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/current_state
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/wait_memory
add wave -noupdate -radix unsigned /videocard_tb/videocard_top_inst/videocard_inst/arbiter_inst/time_spent
add wave -noupdate -divider interrupt_ctrl
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/inter_controller/clk
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/inter_controller/core_interrupts
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/inter_controller/interrupt
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/inter_controller/internal_interrupt
add wave -noupdate -divider rom
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/address_a
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/address_b
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/clock_a
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/clock_b
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/data_a
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/data_b
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/wren_a
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/wren_b
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/q_a
add wave -noupdate -radix binary /videocard_tb/videocard_top_inst/videocard_inst/rom/rom0/q_b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {507959 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 553
configure wave -valuecolwidth 40
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {170961 ps}
