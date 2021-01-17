onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MM_and_SM_tb/wren_in
add wave -noupdate /MM_and_SM_tb/address
add wave -noupdate /MM_and_SM_tb/data_tx
add wave -noupdate /MM_and_SM_tb/data_rx
add wave -noupdate /MM_and_SM_tb/i
add wave -noupdate /MM_and_SM_tb/clk
add wave -noupdate /MM_and_SM_tb/instruction
add wave -noupdate /MM_and_SM_tb/SM_inst/address
add wave -noupdate /MM_and_SM_tb/core_en
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/aluOut
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/aluA
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/aluB
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/reg0
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/reg1
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/reg2
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/reg3
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/core_input_data
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/core_output_data
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/core_address
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/address
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/out_data
add wave -noupdate /MM_and_SM_tb/SM_inst/data
add wave -noupdate /MM_and_SM_tb/SM_inst/core2/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2788210 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 268
configure wave -valuecolwidth 459
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
WaveRestoreZoom {2756590 ps} {2810610 ps}
