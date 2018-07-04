## Generated SDC file "dmb1test.sdc"

## Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus Prime License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 16.0.0 Build 211 04/27/2016 SJ Lite Edition"

## DATE    "Wed Jul 04 12:05:23 2018"

##
## DEVICE  "5CEFA7F23I7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 33.333 -waveform { 0.000 16.666 } [get_ports {altera_reserved_tck}]
create_clock -name {sysclk} -period 50.000 -waveform { 0.000 25.000 } [get_ports {IF_SYS_CLK}]
create_clock -name {in_aclk1} -period 4.000 -waveform { 0.000 2.000 } [get_ports {IF_SAD_CKO1}]
create_clock -name {in_aclk2} -period 4.000 -waveform { 0.000 2.000 } [get_ports {IF_SAD_CKO2}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {gsysclk} -source [get_pins {A1|sys_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50/1 -multiply_by 50 -divide_by 2 -master_clock {sysclk} [get_pins {A1|sys_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {lgcclk} -source [get_pins {A1|sys_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 5 -master_clock {gsysclk} [get_pins {A1|sys_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 
create_generated_clock -name {fdclk} -source [get_pins {A1|sys_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 2 -master_clock {gsysclk} [get_pins {A1|sys_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] 

create_generated_clock -name {gaclk1} -source [get_pins {ADC_PLL1|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50/1 -multiply_by 1 -divide_by 1 -master_clock {in_aclk1} [get_pins {ADC_PLL1|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {aclk1} -source [get_pins {ADC_PLL1|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 2 -master_clock {gaclk1} [get_pins {ADC_PLL1|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 

create_generated_clock -name {gaclk2} -source [get_pins {ADC_PLL2|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50/1 -multiply_by 1 -divide_by 1 -master_clock {in_aclk2} [get_pins {ADC_PLL2|adc_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {aclk2} -source [get_pins {ADC_PLL2|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 2 -master_clock {gaclk2} [get_pins {ADC_PLL2|adc_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {in_aclk2}] -rise_to [get_clocks {in_aclk2}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {in_aclk2}] -rise_to [get_clocks {in_aclk2}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {in_aclk2}] -fall_to [get_clocks {in_aclk2}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {in_aclk2}] -fall_to [get_clocks {in_aclk2}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {in_aclk2}] -rise_to [get_clocks {in_aclk2}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {in_aclk2}] -rise_to [get_clocks {in_aclk2}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {in_aclk2}] -fall_to [get_clocks {in_aclk2}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {in_aclk2}] -fall_to [get_clocks {in_aclk2}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -rise_to [get_clocks {sysclk}]  0.130  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -fall_to [get_clocks {sysclk}]  0.130  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -rise_to [get_clocks {sysclk}]  0.130  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -fall_to [get_clocks {sysclk}]  0.130  
set_clock_uncertainty -rise_from [get_clocks {in_aclk1}] -rise_to [get_clocks {in_aclk1}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {in_aclk1}] -rise_to [get_clocks {in_aclk1}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {in_aclk1}] -fall_to [get_clocks {in_aclk1}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {in_aclk1}] -fall_to [get_clocks {in_aclk1}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {in_aclk1}] -rise_to [get_clocks {in_aclk1}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {in_aclk1}] -rise_to [get_clocks {in_aclk1}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {in_aclk1}] -fall_to [get_clocks {in_aclk1}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {in_aclk1}] -fall_to [get_clocks {in_aclk1}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {aclk2}] -rise_to [get_clocks {aclk2}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {aclk2}] -rise_to [get_clocks {aclk2}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {aclk2}] -fall_to [get_clocks {aclk2}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {aclk2}] -fall_to [get_clocks {aclk2}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {aclk2}] -rise_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {aclk2}] -fall_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {aclk2}] -rise_to [get_clocks {aclk2}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {aclk2}] -rise_to [get_clocks {aclk2}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {aclk2}] -fall_to [get_clocks {aclk2}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {aclk2}] -fall_to [get_clocks {aclk2}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {aclk2}] -rise_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {aclk2}] -fall_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {aclk1}] -rise_to [get_clocks {aclk1}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {aclk1}] -rise_to [get_clocks {aclk1}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {aclk1}] -fall_to [get_clocks {aclk1}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {aclk1}] -fall_to [get_clocks {aclk1}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {aclk1}] -rise_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {aclk1}] -fall_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {aclk1}] -rise_to [get_clocks {aclk1}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {aclk1}] -rise_to [get_clocks {aclk1}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {aclk1}] -fall_to [get_clocks {aclk1}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {aclk1}] -fall_to [get_clocks {aclk1}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {aclk1}] -rise_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {aclk1}] -fall_to [get_clocks {lgcclk}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -rise_to [get_clocks {aclk2}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -fall_to [get_clocks {aclk2}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -rise_to [get_clocks {aclk1}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -fall_to [get_clocks {aclk1}]  0.140  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -rise_to [get_clocks {lgcclk}] -setup 0.120  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -rise_to [get_clocks {lgcclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -fall_to [get_clocks {lgcclk}] -setup 0.120  
set_clock_uncertainty -rise_from [get_clocks {lgcclk}] -fall_to [get_clocks {lgcclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -rise_to [get_clocks {aclk2}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -fall_to [get_clocks {aclk2}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -rise_to [get_clocks {aclk1}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -fall_to [get_clocks {aclk1}]  0.140  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -rise_to [get_clocks {lgcclk}] -setup 0.120  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -rise_to [get_clocks {lgcclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -fall_to [get_clocks {lgcclk}] -setup 0.120  
set_clock_uncertainty -fall_from [get_clocks {lgcclk}] -fall_to [get_clocks {lgcclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -rise_to [get_clocks {aclk2}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -fall_to [get_clocks {aclk2}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -rise_to [get_clocks {aclk1}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -fall_to [get_clocks {aclk1}]  0.110  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -rise_to [get_clocks {lgcclk}]  0.130  
set_clock_uncertainty -rise_from [get_clocks {sysclk}] -fall_to [get_clocks {lgcclk}]  0.130  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -rise_to [get_clocks {aclk2}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -fall_to [get_clocks {aclk2}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -rise_to [get_clocks {aclk1}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -fall_to [get_clocks {aclk1}]  0.110  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -rise_to [get_clocks {lgcclk}]  0.130  
set_clock_uncertainty -fall_from [get_clocks {sysclk}] -fall_to [get_clocks {lgcclk}]  0.130  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] -group [get_clocks {sysclk}] -group [get_clocks {in_aclk1}] -group [get_clocks {in_aclk2}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {lgcclk}]  -to  [get_clocks {aclk1}]
set_false_path  -from  [get_clocks {lgcclk}]  -to  [get_clocks {aclk2}]
set_false_path  -from  [get_clocks {aclk1}]  -to  [get_clocks {lgcclk}]
set_false_path  -from  [get_clocks {aclk2}]  -to  [get_clocks {lgcclk}]
set_false_path  -from  [get_clocks {sysclk}] -to  [get_clocks {aclk1}]
set_false_path  -from  [get_clocks {sysclk}] -to  [get_clocks {aclk2}]
set_false_path  -from  [get_clocks {aclk1}]  -to  [get_clocks {sysclk}]
set_false_path  -from  [get_clocks {aclk2}]  -to  [get_clocks {sysclk}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_re9:dffpipe17|dffe18a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_qe9:dffpipe12|dffe13a*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read}] -to [get_registers {*|alt_jtag_atlantic:*|read1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|tck_t_dav}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [all_registers]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write}] -to [get_registers {*|alt_jtag_atlantic:*|write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_nios2_oci_break:the_TestRO_nios2_gen2_0_cpu_nios2_oci_break|break_readreg*}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_tck:the_TestRO_nios2_gen2_0_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_nios2_oci_debug:the_TestRO_nios2_gen2_0_cpu_nios2_oci_debug|*resetlatch}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_tck:the_TestRO_nios2_gen2_0_cpu_debug_slave_tck|*sr[33]}]
set_false_path -from [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_nios2_oci_debug:the_TestRO_nios2_gen2_0_cpu_nios2_oci_debug|monitor_ready}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_tck:the_TestRO_nios2_gen2_0_cpu_debug_slave_tck|*sr[0]}]
set_false_path -from [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_nios2_oci_debug:the_TestRO_nios2_gen2_0_cpu_nios2_oci_debug|monitor_error}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_tck:the_TestRO_nios2_gen2_0_cpu_debug_slave_tck|*sr[34]}]
set_false_path -from [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_nios2_ocimem:the_TestRO_nios2_gen2_0_cpu_nios2_ocimem|*MonDReg*}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_tck:the_TestRO_nios2_gen2_0_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_tck:the_TestRO_nios2_gen2_0_cpu_debug_slave_tck|*sr*}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_sysclk:the_TestRO_nios2_gen2_0_cpu_debug_slave_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_debug_slave_wrapper:the_TestRO_nios2_gen2_0_cpu_debug_slave_wrapper|TestRO_nios2_gen2_0_cpu_debug_slave_sysclk:the_TestRO_nios2_gen2_0_cpu_debug_slave_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*TestRO_nios2_gen2_0_cpu:*|TestRO_nios2_gen2_0_cpu_nios2_oci:the_TestRO_nios2_gen2_0_cpu_nios2_oci|TestRO_nios2_gen2_0_cpu_nios2_oci_debug:the_TestRO_nios2_gen2_0_cpu_nios2_oci_debug|monitor_go}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

