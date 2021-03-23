onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider core
add wave -noupdate -radix binary /core_tb/core_inst/clk
add wave -noupdate -radix binary /core_tb/core_inst/response
add wave -noupdate -radix binary /core_tb/core_inst/instruction
add wave -noupdate -radix binary /core_tb/core_inst/wren
add wave -noupdate -radix binary /core_tb/core_inst/request
add wave -noupdate -radix unsigned /core_tb/core_inst/readdata
add wave -noupdate -radix unsigned /core_tb/core_inst/address
add wave -noupdate -radix unsigned /core_tb/core_inst/writedata
add wave -noupdate -radix unsigned /core_tb/core_inst/instr_addr
add wave -noupdate -radix unsigned /core_tb/core_inst/reg0
add wave -noupdate -radix unsigned /core_tb/core_inst/reg1
add wave -noupdate -radix unsigned /core_tb/core_inst/reg2
add wave -noupdate -radix unsigned /core_tb/core_inst/reg3
add wave -noupdate -radix unsigned /core_tb/core_inst/reg4
add wave -noupdate -radix unsigned /core_tb/core_inst/reg5
add wave -noupdate -radix unsigned /core_tb/core_inst/sp
add wave -noupdate -radix unsigned /core_tb/core_inst/ip
add wave -noupdate -radix binary /core_tb/core_inst/flags
add wave -noupdate -radix binary /core_tb/core_inst/state
add wave -noupdate -divider decoder
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/clk
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/en
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/long_instr
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/instr_choose
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/flags
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/alu_en
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/alu_opcode
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/mem_en
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/wren
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/move_en
add wave -noupdate -radix unsigned /core_tb/core_inst/instr_decoder_main/immediate
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/mov_type
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/op1
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/op2
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/suffix
add wave -noupdate -radix binary /core_tb/core_inst/instr_decoder_main/short_instr
add wave -noupdate -divider ALU
add wave -noupdate -radix binary /core_tb/core_inst/alu_main/clk
add wave -noupdate -radix binary /core_tb/core_inst/alu_main/en
add wave -noupdate -radix binary /core_tb/core_inst/alu_main/dest_in
add wave -noupdate -radix binary /core_tb/core_inst/alu_main/opcode
add wave -noupdate -radix unsigned /core_tb/core_inst/alu_main/op1
add wave -noupdate -radix unsigned /core_tb/core_inst/alu_main/op2
add wave -noupdate -radix binary /core_tb/core_inst/alu_main/cin
add wave -noupdate -radix binary /core_tb/core_inst/alu_main/flags
add wave -noupdate -radix binary /core_tb/core_inst/alu_main/dest_out
add wave -noupdate -radix unsigned /core_tb/core_inst/alu_main/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 353
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
WaveRestoreZoom {204130 ps} {420840 ps}
