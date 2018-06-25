module SPI_CMDGEN 
(
  input        clk,
  input        rst_n, 
  input        out_en,
  input  [3:0] incmd,
  output [3:0] outcmd
);

  wire empty, full; 

  SPICMD_FIFO 
  spicmdgen_inst 
  (
    .clock (clk),
	 .data  (incmd), 
	 .rdreq (out_en & ~empty),
	 .wrreq (~full & rst_n),
	 .empty (empty),
	 .full  (full),
	 .q     (outcmd)
  );	 

endmodule 