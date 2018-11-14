set_global_assignment -entity "ADC_PLL" -library "lib_ADC_PLL" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "ADC_PLL" -library "lib_ADC_PLL" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "ADC_PLL" -library "lib_ADC_PLL" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_ADC_PLL" -name SPD_FILE [file join $::quartus(sip_path) "ADC_PLL.spd"]

set_global_assignment -library "lib_ADC_PLL" -name MISC_FILE [file join $::quartus(sip_path) "ADC_PLL_sim/ADC_PLL.vo"]
