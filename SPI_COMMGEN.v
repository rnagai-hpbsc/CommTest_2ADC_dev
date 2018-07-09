module SPI_COMMGEN (
  input         clk, 
  input         rst_n,
  input         wren,
  input  [31:0] indata, 
  output        ctrlen,
  output  [3:0] addr,
  output [15:0] sdata
  );
  
  
  // temporary stored register
  reg        ctrl_tmp;
  reg  [3:0] addr_tmp;
  reg [15:0] sdat_tmp;
  reg [31:0] data_str;
  

  always @(negedge rst_n or posedge clk) begin 
    if (~rst_n) begin
	   addr_tmp <=  4'h0;
		sdat_tmp <= 16'h0000;
		data_str <= 32'h00000000;
	 end
	 else begin 
	   if (wren) begin  
	     if (data_str!=indata) begin 
		    data_str <= indata;
		    addr_tmp <= indata[19:16];
		    sdat_tmp <= indata[15:0];
			 ctrl_tmp <= 1'b1;
		  end
		  else begin
		    ctrl_tmp <= 1'b0; 
		  end
		end
	 end
  end
  
  assign ctrlen = ctrl_tmp;
  assign addr   = addr_tmp;
  assign sdata  = sdat_tmp;

endmodule 