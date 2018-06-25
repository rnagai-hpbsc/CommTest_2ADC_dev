
module TestRO (
	clk_clk,
	fifo_0_in_writedata,
	fifo_0_in_write,
	fifo_0_in_waitrequest,
	fifo_1_in_writedata,
	fifo_1_in_write,
	fifo_1_in_waitrequest,
	reset_reset_n,
	write_en_export,
	exttrg_0_export);	

	input		clk_clk;
	input	[31:0]	fifo_0_in_writedata;
	input		fifo_0_in_write;
	output		fifo_0_in_waitrequest;
	input	[31:0]	fifo_1_in_writedata;
	input		fifo_1_in_write;
	output		fifo_1_in_waitrequest;
	input		reset_reset_n;
	output		write_en_export;
	output		exttrg_0_export;
endmodule
