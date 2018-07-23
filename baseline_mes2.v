module baseline_mes2 #(parameter LNCLK=2)
(
  input         clk, 
  input         rst_n, 
  input         dacset,
  input  [13:0] indata, 
  output [13:0] baseline, 
  output        done,
  // monitor
  output        flgmon,
  output [14:0] intreg
);
  
  reg        sttmp;
  reg [13:0] dtmp;
  reg [14:0] dinner;
  reg [LNCLK:0] cnt; 
  
  always @(negedge rst_n or posedge clk) begin 
    if (~rst_n) begin
	   sttmp   <= 1'b0; 
		dtmp    <= 14'd0;
		dinner  <= 15'd0;
		cnt     <= {(LNCLK+1){1'b0}};
	 end
	 else begin 
	   sttmp <= dacset; 
		if ( ~dacset & sttmp) begin
		  cnt <= {(LNCLK+1){1'b0}};
		  dtmp <= 14'd0;
		  dinner <= 15'd0;
	   end	
	   if (cnt[LNCLK]==1'b0) begin 
		  cnt <= cnt + 1'b1;
		  dinner <= dinner[14:1] + indata;
		  dtmp <= dinner[14:1]; 
		end
	 end
  end
  
  assign baseline = dtmp; 
  
  assign done = (cnt[LNCLK]==1'b1);
  
  // monitor
  assign flgmon = (cnt[1]==1'b1);
  assign intreg = dinner;
  
  
endmodule 