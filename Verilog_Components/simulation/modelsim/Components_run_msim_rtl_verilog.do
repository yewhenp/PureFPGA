transcript on
if ![file isdirectory Components_iputf_libs] {
	file mkdir Components_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components/Clock_sim/Clock.vo"

vlog -vlog01compat -work work +incdir+C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components {C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components/Instruction_Processor_tb.v}
vlog -vlog01compat -work work +incdir+C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components {C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components/OnePortRAM.v}
vlog -vlog01compat -work work +incdir+C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components {C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components/Instruction_Processor.v}
vlog -vlog01compat -work work +incdir+C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components {C:/msys64/home/Win10/poc/project/PureFPGA/Verilog_Components/ALU.v}

