onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MemoryManagerAddressing/wren_in
add wave -noupdate /MemoryManagerAddressing/reg_en
add wave -noupdate /MemoryManagerAddressing/core_en
add wave -noupdate /MemoryManagerAddressing/wren_out
add wave -noupdate /MemoryManagerAddressing/address
add wave -noupdate /MemoryManagerAddressing/core_address
add wave -noupdate /MemoryManagerAddressing/core_data
add wave -noupdate /MemoryManagerAddressing/data
add wave -noupdate /MemoryManagerAddressing/i
add wave -noupdate /MemoryManagerAddressing/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {607340 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 293
configure wave -valuecolwidth 449
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
WaveRestoreZoom {431640 ps} {515810 ps}
