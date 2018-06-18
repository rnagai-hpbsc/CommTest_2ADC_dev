
module TestRO (
	clk_clk,
	fifo_0_in_writedata,
	fifo_0_in_write,
	fifo_0_in_waitrequest,
	fifo_1_in_writedata,
	fifo_1_in_write,
	fifo_1_in_waitrequest,
	pio_0_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	input	[31:0]	fifo_0_in_writedata;
	input		fifo_0_in_write;
	output		fifo_0_in_waitrequest;
	input	[31:0]	fifo_1_in_writedata;
	input		fifo_1_in_write;
	output		fifo_1_in_waitrequest;
	output		pio_0_external_connection_export;
	input		reset_reset_n;
endmodule
