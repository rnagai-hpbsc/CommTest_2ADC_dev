set_global_assignment -entity "ADCINCLKCTRL" -library "lib_ADCINCLKCTRL" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "ADCINCLKCTRL" -library "lib_ADCINCLKCTRL" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "ADCINCLKCTRL" -library "lib_ADCINCLKCTRL" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_ADCINCLKCTRL" -name SPD_FILE [file join $::quartus(sip_path) "../ADCINCLKCTRL.spd"]
set_global_assignment -library "lib_ADCINCLKCTRL" -name MISC_FILE [file join $::quartus(sip_path) "../../ADCINCLKCTRL.qsys"]

set_global_assignment -library "lib_ADCINCLKCTRL" -name MISC_FILE [file join $::quartus(sip_path) "ADCINCLKCTRL.v"]
set_global_assignment -library "lib_ADCINCLKCTRL" -name MISC_FILE [file join $::quartus(sip_path) "submodules/ADCINCLKCTRL_altclkctrl_0.v"]
