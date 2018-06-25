transcript on
if ![file isdirectory dmb1test_iputf_libs] {
	file mkdir dmb1test_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/SYS_PLL_sim/SYS_PLL.vo"
vlog "C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADC_PLL_sim/ADC_PLL.vo"

vlog -vlog01compat -work work +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/SYS_PLL.vo}
vlog -vlog01compat -work work +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADC_PLL.vo}
vlog -vlog01compat -work work +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/DAT_FIFO.v}
vlog -vlog01compat -work work +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/dac_spi.v}
vlib TestRO
vmap TestRO TestRO
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/TestRO.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_avalon_st_adapter_004.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_pio_0.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_onchip_memory2_0.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_nios2_gen2_0.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_nios2_gen2_0_cpu.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_nios2_gen2_0_cpu_debug_slave_sysclk.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_nios2_gen2_0_cpu_debug_slave_tck.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_nios2_gen2_0_cpu_debug_slave_wrapper.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_nios2_gen2_0_cpu_test_bench.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_jtag_uart_0.v}
vlog -vlog01compat -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_fifo_0.v}
vlib SYS_PLL
vmap SYS_PLL SYS_PLL
vlog -vlog01compat -work SYS_PLL +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/SYS_PLL {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/SYS_PLL/SYS_PLL_0002.v}
vlib ADC_PLL
vmap ADC_PLL ADC_PLL
vlog -vlog01compat -work ADC_PLL +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADC_PLL {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADC_PLL/ADC_PLL_0002.v}
vlib ADCINCLKCTRL
vmap ADCINCLKCTRL ADCINCLKCTRL
vlog -vlog01compat -work ADCINCLKCTRL +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADCINCLKCTRL/synthesis {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADCINCLKCTRL/synthesis/ADCINCLKCTRL.v}
vlog -vlog01compat -work ADCINCLKCTRL +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADCINCLKCTRL/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/ADCINCLKCTRL/synthesis/submodules/ADCINCLKCTRL_altclkctrl_0.v}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_irq_mapper.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_avalon_st_adapter_004_error_adapter_0.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_merlin_width_adapter.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_rsp_mux_001.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_rsp_demux_002.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_cmd_mux_002.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_cmd_demux_001.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_router_008.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_router_006.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_router_004.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_router_002.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_router_001.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/TestRO_mm_interconnect_0_router.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work TestRO +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/TestRO/synthesis/submodules/altera_merlin_master_translator.sv}

vlog -vlog01compat -work work +incdir+C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/simulation/modelsim {C:/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_2ADC_dev/simulation/modelsim/top.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L TestRO -L SYS_PLL -L ADC_PLL -L ADCINCLKCTRL -voptargs="+acc"  top_vlg_tst

add wave *
view structure
view signals
run -all
