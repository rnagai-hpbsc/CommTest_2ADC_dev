// SYS_GCLK.v

// Generated using ACDS version 16.0 211

`timescale 1 ps / 1 ps
module SYS_GCLK (
		input  wire  inclk,  //  altclkctrl_input.inclk
		output wire  outclk  // altclkctrl_output.outclk
	);

	SYS_GCLK_altclkctrl_0 altclkctrl_0 (
		.inclk  (inclk),  //  altclkctrl_input.inclk
		.outclk (outclk)  // altclkctrl_output.outclk
	);

endmodule
