set_global_assignment -entity "PLL_Clock" -library "lib_PLL_Clock" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_Clock" -library "lib_PLL_Clock" -name IP_TOOL_VERSION "19.1"
set_global_assignment -entity "PLL_Clock" -library "lib_PLL_Clock" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_Clock" -name SPD_FILE [file join $::quartus(sip_path) "PLL_Clock.spd"]

set_global_assignment -library "lib_PLL_Clock" -name MISC_FILE [file join $::quartus(sip_path) "PLL_Clock_sim/PLL_Clock.vo"]
