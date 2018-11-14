
module TestRO (
	bs1_export,
	bs2_export,
	clk_clk,
	dacctrl_export,
	ext_rst_export,
	exttrg_0_export,
	fifo_0_in_writedata,
	fifo_0_in_write,
	fifo_0_in_waitrequest,
	fifo_1_in_writedata,
	fifo_1_in_write,
	fifo_1_in_waitrequest,
	reset_reset_n,
	version_info_export,
	write_en_export,
	tp1_export);	

	input	[13:0]	bs1_export;
	input	[13:0]	bs2_export;
	input		clk_clk;
	output	[31:0]	dacctrl_export;
	output		ext_rst_export;
	output		exttrg_0_export;
	input	[31:0]	fifo_0_in_writedata;
	input		fifo_0_in_write;
	output		fifo_0_in_waitrequest;
	input	[31:0]	fifo_1_in_writedata;
	input		fifo_1_in_write;
	output		fifo_1_in_waitrequest;
	input		reset_reset_n;
	input	[31:0]	version_info_export;
	output		write_en_export;
	input	[13:0]	tp1_export;
endmodule
