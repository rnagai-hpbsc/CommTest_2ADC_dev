module IntTrig #(parameter THRES = 32768, parameter TRGTIME = 10)  
(
  input         clk,
  input         rst_n,
  input  [13:0] tdat,
  output        tsig
);
  
  reg        trg_src; 
  reg [15:0] waitcnt; 
  
  always @(negedge rst_n or posedge clk) 
  begin 
    if (~rst_n) 
	 begin 
	   trg_src <=  1'b0;
	   waitcnt <= 16'd0;	
	 end 
	 else 
	 begin 
	   waitcnt <= waitcnt + 1'b1;
		if (waitcnt>=TRGTIME) 
		begin 
	     if (tdat>=THRES) 
		  begin 
		    trg_src <=  1'b1;
		    waitcnt <= 16'd0;
		  end
		end 
	   else 
		begin 
	     trg_src <= 1'b0;
		end  
    end 
  end
  
  assign tsig = trg_src; 
  

endmodule 