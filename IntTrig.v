module IntTrig #(parameter THRES = 100, parameter TRGTIME = 100)  
(
  input         clk,
  input         rst_n,
  input  [13:0] tdat,
  output        otrig
);
  
  reg        trg_src; 
  reg [15:0] waitcnt; 
  
  always @(negedge rst_n or posedge clk) 
  begin 
    if (~rst_n) begin 
	   trg_src <=  1'b0;
		waitcnt <= 16'h0000;
	 end 
	 else begin 
	   if (tdat>=THRES) begin
		  trg_src <= 1'b1;
		end
		if (trg_src) begin
		  waitcnt <= waitcnt + 1'b1;
		  if (waitcnt >= TRGTIME) begin
		    waitcnt <= 16'h0000;
			 trg_src <= 1'b0;
		  end
		end 
		else begin
		  waitcnt <= 16'h0000;
		end
	 end
  end
  
  assign otrig = trg_src; 
  

endmodule 