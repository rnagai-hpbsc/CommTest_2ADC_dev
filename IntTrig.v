module IntTrig #(parameter THRES = 100, parameter TRGTIME = 100)  
(
  input         clk,
  input         rst_n,
  input  [13:0] baseline,
  input  [13:0] tdat,
  output        otrig
);
  
  reg        trg_src; 
  reg [15:0] waitcnt; 
  
  reg [13:0] dstore; 
  reg [13:0] athres;
  
  always @(negedge rst_n or posedge clk) 
  begin 
    if (~rst_n) begin 
	   trg_src <=  1'b0;
		waitcnt <= 16'h0000;
		dstore  <= 14'd0;
		athres  <= 14'd0;
	 end 
	 else begin 
	   dstore <= tdat; 
		athres <= THRES + baseline; 
		if (trg_src) begin
		  waitcnt <= waitcnt + 1'b1;
		  if (waitcnt >= TRGTIME) begin
		    waitcnt <= 16'h0000;
			 trg_src <= 1'b0;
		  end
		end 
		else if (dstore > athres) begin 
		  trg_src <= 1'b1;
		end
		else begin
		  waitcnt <= 16'h0000;
		end
	 end
  end
  
  assign otrig = trg_src; 
  

endmodule 