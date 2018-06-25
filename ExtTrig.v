module EXT_TRIG 
(
  input  clk,
  input  rst_n,
  input  trigdat,
  output trigsig
);
  
  reg triggeron; 
  
  always @(negedge rst_n or posedge clk) 
  begin  
    if (~rst_n) 
	 begin 
	   triggeron <= 1'b0; 
    end 
	 else 
	 begin 
	   triggeron <= trigdat;
	 end
  end

  assign trigsig = triggeron;

endmodule 