	TestRO u0 (
		.clk_clk               (<connected-to-clk_clk>),               //       clk.clk
		.fifo_0_in_writedata   (<connected-to-fifo_0_in_writedata>),   // fifo_0_in.writedata
		.fifo_0_in_write       (<connected-to-fifo_0_in_write>),       //          .write
		.fifo_0_in_waitrequest (<connected-to-fifo_0_in_waitrequest>), //          .waitrequest
		.fifo_1_in_writedata   (<connected-to-fifo_1_in_writedata>),   // fifo_1_in.writedata
		.fifo_1_in_write       (<connected-to-fifo_1_in_write>),       //          .write
		.fifo_1_in_waitrequest (<connected-to-fifo_1_in_waitrequest>), //          .waitrequest
		.reset_reset_n         (<connected-to-reset_reset_n>),         //     reset.reset_n
		.write_en_export       (<connected-to-write_en_export>),       //  write_en.export
		.exttrg_0_export       (<connected-to-exttrg_0_export>)        //  exttrg_0.export
	);

