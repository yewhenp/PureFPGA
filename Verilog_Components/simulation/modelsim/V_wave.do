onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Videocard
add wave -noupdate /Videocard_test/wren
add wave -noupdate /Videocard_test/clk
add wave -noupdate -radix unsigned /Videocard_test/address
add wave -noupdate -radix unsigned /Videocard_test/data
add wave -noupdate -radix unsigned /Videocard_test/data_tx
add wave -noupdate -radix unsigned /Videocard_test/data_rx
add wave -noupdate /Videocard_test/i
add wave -noupdate -divider SM
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/data
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/address
add wave -noupdate /Videocard_test/videocard/b2v_inst3/instruction
add wave -noupdate -divider MemoryManager
add wave -noupdate /Videocard_test/videocard/b2v_inst/reg_en
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst/core_en
add wave -noupdate -divider Core
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/aluOut
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/aluA
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/aluB
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/reg0
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/reg1
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/reg2
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/reg3
add wave -noupdate /Videocard_test/videocard/b2v_inst3/core10/flags
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/core_input_data
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/core_output_data
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst3/core10/core_address
add wave -noupdate -divider {Instruction Processor}
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst8/regData
add wave -noupdate /Videocard_test/videocard/b2v_inst8/regChoose
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst8/ROMData
add wave -noupdate /Videocard_test/videocard/b2v_inst8/instructionOut
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst8/reg0
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst8/reg3
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst8/ip
add wave -noupdate -divider ROM
add wave -noupdate -radix unsigned /Videocard_test/videocard/b2v_inst9/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {39454490 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 412
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
WaveRestoreZoom {26676953 ps} {26764153 ps}
