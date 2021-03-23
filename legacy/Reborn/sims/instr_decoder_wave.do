onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instruction_decoder_tb/clk
add wave -noupdate /instruction_decoder_tb/en
add wave -noupdate -radix hexadecimal /instruction_decoder_tb/instruction
add wave -noupdate /instruction_decoder_tb/instr_choose
add wave -noupdate /instruction_decoder_tb/flags
add wave -noupdate -radix binary /instruction_decoder_tb/alu_en
add wave -noupdate -radix binary /instruction_decoder_tb/alu_opcode
add wave -noupdate -radix binary /instruction_decoder_tb/mem_en
add wave -noupdate -radix binary /instruction_decoder_tb/wren
add wave -noupdate -radix binary /instruction_decoder_tb/move_en
add wave -noupdate -radix decimal /instruction_decoder_tb/immediate
add wave -noupdate -radix binary /instruction_decoder_tb/mov_type
add wave -noupdate -radix decimal /instruction_decoder_tb/op1
add wave -noupdate -radix decimal /instruction_decoder_tb/op2
add wave -noupdate -radix binary /instruction_decoder_tb/suffix
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {220 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 253
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
WaveRestoreZoom {15930 ps} {38510 ps}
