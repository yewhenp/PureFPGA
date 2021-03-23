transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/test_benches {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/test_benches/videocard_tb.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/core {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/core/instr_decoder.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/core {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/core/core.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/core {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/core/alu.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/memory {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/memory/RAM.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/memory {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/memory/arbiter.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/videocard {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/videocard/videocard.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/memory {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/memory/four_way_rom.v}
vlog -vlog01compat -work work +incdir+/home/pasha/Documents/poc_acs/PureFPGA/Reborn/videocard {/home/pasha/Documents/poc_acs/PureFPGA/Reborn/videocard/interrupt_controller.v}

