onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Instruction_Processor_tb/clk
add wave -noupdate /Instruction_Processor_tb/regChoose
add wave -noupdate /Instruction_Processor_tb/ROMData
add wave -noupdate -radix decimal /Instruction_Processor_tb/regData
add wave -noupdate /Instruction_Processor_tb/instructionOut
add wave -noupdate -radix decimal /Instruction_Processor_tb/ROMAddress
add wave -noupdate /Instruction_Processor_tb/IP/saveRes
add wave -noupdate /Instruction_Processor_tb/IP/makeJump
add wave -noupdate -divider Inside_IP
add wave -noupdate -divider Registers
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/reg0
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/reg1
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/reg2
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/reg3
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/reg4
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/reg5
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/sp
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/ip
add wave -noupdate /Instruction_Processor_tb/IP/flags
add wave -noupdate -divider ALU
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/firstOperand
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/secondOperand
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/ALURes
add wave -noupdate -divider Memory
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/RAMOutData
add wave -noupdate -radix unsigned /Instruction_Processor_tb/IP/RAMAddress
add wave -noupdate -radix decimal /Instruction_Processor_tb/IP/RAMData
add wave -noupdate /Instruction_Processor_tb/IP/wren
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {103570 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 284
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
WaveRestoreZoom {134470 ps} {161350 ps}
