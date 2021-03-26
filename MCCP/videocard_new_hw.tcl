# TCL File Generated by Component Editor 20.1
# Fri Mar 26 14:27:04 EET 2021
# DO NOT MODIFY


# 
# videocard_new "videocard_new" v1.0
#  2021.03.26.14:27:04
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module videocard_new
# 
set_module_property DESCRIPTION ""
set_module_property NAME videocard_new
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME videocard_new
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL videocard_top
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file videocard_top.v VERILOG PATH videocard/videocard_top.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter WIDTH INTEGER 32
set_parameter_property WIDTH DEFAULT_VALUE 32
set_parameter_property WIDTH DISPLAY_NAME WIDTH
set_parameter_property WIDTH TYPE INTEGER
set_parameter_property WIDTH UNITS None
set_parameter_property WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property WIDTH HDL_PARAMETER true
add_parameter WIDTH_CTRL INTEGER 8
set_parameter_property WIDTH_CTRL DEFAULT_VALUE 8
set_parameter_property WIDTH_CTRL DISPLAY_NAME WIDTH_CTRL
set_parameter_property WIDTH_CTRL TYPE INTEGER
set_parameter_property WIDTH_CTRL UNITS None
set_parameter_property WIDTH_CTRL ALLOWED_RANGES -2147483648:2147483647
set_parameter_property WIDTH_CTRL HDL_PARAMETER true
add_parameter BYTES INTEGER 4
set_parameter_property BYTES DEFAULT_VALUE 4
set_parameter_property BYTES DISPLAY_NAME BYTES
set_parameter_property BYTES TYPE INTEGER
set_parameter_property BYTES UNITS None
set_parameter_property BYTES ALLOWED_RANGES -2147483648:2147483647
set_parameter_property BYTES HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point memory_main
# 
add_interface memory_main avalon end
set_interface_property memory_main addressUnits WORDS
set_interface_property memory_main associatedClock clock
set_interface_property memory_main associatedReset reset_sink
set_interface_property memory_main bitsPerSymbol 8
set_interface_property memory_main burstOnBurstBoundariesOnly false
set_interface_property memory_main burstcountUnits WORDS
set_interface_property memory_main explicitAddressSpan 0
set_interface_property memory_main holdTime 0
set_interface_property memory_main linewrapBursts false
set_interface_property memory_main maximumPendingReadTransactions 0
set_interface_property memory_main maximumPendingWriteTransactions 0
set_interface_property memory_main readLatency 0
set_interface_property memory_main readWaitTime 1
set_interface_property memory_main setupTime 0
set_interface_property memory_main timingUnits Cycles
set_interface_property memory_main writeWaitTime 0
set_interface_property memory_main ENABLED true
set_interface_property memory_main EXPORT_OF ""
set_interface_property memory_main PORT_NAME_MAP ""
set_interface_property memory_main CMSIS_SVD_VARIABLES ""
set_interface_property memory_main SVD_ADDRESS_GROUP ""

add_interface_port memory_main data_in writedata Input WIDTH
add_interface_port memory_main data_out readdata Output WIDTH
add_interface_port memory_main address address Input "(WIDTH/2) - (0) + 1"
add_interface_port memory_main byteenable byteenable Input BYTES
add_interface_port memory_main write write Input 1
add_interface_port memory_main read read Input 1
set_interface_assignment memory_main embeddedsw.configuration.isFlash 0
set_interface_assignment memory_main embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment memory_main embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment memory_main embeddedsw.configuration.isPrintableDevice 0


# 
# connection point memory_control
# 
add_interface memory_control avalon end
set_interface_property memory_control addressUnits WORDS
set_interface_property memory_control associatedClock clock
set_interface_property memory_control associatedReset reset_sink
set_interface_property memory_control bitsPerSymbol 8
set_interface_property memory_control burstOnBurstBoundariesOnly false
set_interface_property memory_control burstcountUnits WORDS
set_interface_property memory_control explicitAddressSpan 0
set_interface_property memory_control holdTime 0
set_interface_property memory_control linewrapBursts false
set_interface_property memory_control maximumPendingReadTransactions 0
set_interface_property memory_control maximumPendingWriteTransactions 0
set_interface_property memory_control readLatency 0
set_interface_property memory_control readWaitTime 1
set_interface_property memory_control setupTime 0
set_interface_property memory_control timingUnits Cycles
set_interface_property memory_control writeWaitTime 0
set_interface_property memory_control ENABLED true
set_interface_property memory_control EXPORT_OF ""
set_interface_property memory_control PORT_NAME_MAP ""
set_interface_property memory_control CMSIS_SVD_VARIABLES ""
set_interface_property memory_control SVD_ADDRESS_GROUP ""

add_interface_port memory_control read_control read Input 1
add_interface_port memory_control write_control write Input 1
add_interface_port memory_control address_control address Input 1
add_interface_port memory_control data_out_control readdata Output WIDTH_CTRL
add_interface_port memory_control data_in_control writedata Input WIDTH_CTRL
set_interface_assignment memory_control embeddedsw.configuration.isFlash 0
set_interface_assignment memory_control embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment memory_control embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment memory_control embeddedsw.configuration.isPrintableDevice 0


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink reset_sink_reset reset Input 1


# 
# connection point clock_hps
# 
add_interface clock_hps clock end
set_interface_property clock_hps clockRate 0
set_interface_property clock_hps ENABLED true
set_interface_property clock_hps EXPORT_OF ""
set_interface_property clock_hps PORT_NAME_MAP ""
set_interface_property clock_hps CMSIS_SVD_VARIABLES ""
set_interface_property clock_hps SVD_ADDRESS_GROUP ""

add_interface_port clock_hps clk_hps clk Input 1

