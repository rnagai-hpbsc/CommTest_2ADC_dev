	TestRO u0 (
		.bs1_export            (<connected-to-bs1_export>),            //          bs1.export
		.bs2_export            (<connected-to-bs2_export>),            //          bs2.export
		.clk_clk               (<connected-to-clk_clk>),               //          clk.clk
		.dacctrl_export        (<connected-to-dacctrl_export>),        //      dacctrl.export
		.ext_rst_export        (<connected-to-ext_rst_export>),        //      ext_rst.export
		.exttrg_0_export       (<connected-to-exttrg_0_export>),       //     exttrg_0.export
		.fifo_0_in_writedata   (<connected-to-fifo_0_in_writedata>),   //    fifo_0_in.writedata
		.fifo_0_in_write       (<connected-to-fifo_0_in_write>),       //             .write
		.fifo_0_in_waitrequest (<connected-to-fifo_0_in_waitrequest>), //             .waitrequest
		.fifo_1_in_writedata   (<connected-to-fifo_1_in_writedata>),   //    fifo_1_in.writedata
		.fifo_1_in_write       (<connected-to-fifo_1_in_write>),       //             .write
		.fifo_1_in_waitrequest (<connected-to-fifo_1_in_waitrequest>), //             .waitrequest
		.reset_reset_n         (<connected-to-reset_reset_n>),         //        reset.reset_n
		.version_info_export   (<connected-to-version_info_export>),   // version_info.export
		.write_en_export       (<connected-to-write_en_export>)        //     write_en.export
	);

