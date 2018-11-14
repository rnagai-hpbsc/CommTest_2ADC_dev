set_global_assignment -entity "SYS_GCLK" -library "lib_SYS_GCLK" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "SYS_GCLK" -library "lib_SYS_GCLK" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "SYS_GCLK" -library "lib_SYS_GCLK" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_SYS_GCLK" -name SPD_FILE [file join $::quartus(sip_path) "../SYS_GCLK.spd"]
set_global_assignment -library "lib_SYS_GCLK" -name MISC_FILE [file join $::quartus(sip_path) "../../SYS_GCLK.qsys"]

set_global_assignment -library "lib_SYS_GCLK" -name MISC_FILE [file join $::quartus(sip_path) "SYS_GCLK.v"]
set_global_assignment -library "lib_SYS_GCLK" -name MISC_FILE [file join $::quartus(sip_path) "submodules/SYS_GCLK_altclkctrl_0.v"]
