	TestRO u0 (
		.clk_clk                          (<connected-to-clk_clk>),                          //                       clk.clk
		.fifo_0_in_writedata              (<connected-to-fifo_0_in_writedata>),              //                 fifo_0_in.writedata
		.fifo_0_in_write                  (<connected-to-fifo_0_in_write>),                  //                          .write
		.fifo_0_in_waitrequest            (<connected-to-fifo_0_in_waitrequest>),            //                          .waitrequest
		.fifo_1_in_writedata              (<connected-to-fifo_1_in_writedata>),              //                 fifo_1_in.writedata
		.fifo_1_in_write                  (<connected-to-fifo_1_in_write>),                  //                          .write
		.fifo_1_in_waitrequest            (<connected-to-fifo_1_in_waitrequest>),            //                          .waitrequest
		.pio_0_external_connection_export (<connected-to-pio_0_external_connection_export>), // pio_0_external_connection.export
		.reset_reset_n                    (<connected-to-reset_reset_n>)                     //                     reset.reset_n
	);

