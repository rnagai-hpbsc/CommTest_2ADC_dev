module baseline_mes #(parameter TIMEKEEP=100, parameter INITWAIT=1000000) 
(
  input         clk,
  input         rst_n, 
  input  [13:0] indata,
  output [13:0] baseline,
  output        done
); 

  reg  donereg; 
  reg [23:0] dinner;
  reg [23:0] counter;  
  reg [23:0] dtmp; 
  
  always @(negedge rst_n or posedge clk) begin 
    if (~rst_n) begin 
	   donereg <= 1'b0;
	   dinner  <= 24'd0;
	   counter <= 24'd0; 
	   dtmp    <= 24'd0;	
	 end
	 else begin 
	   counter <= counter + 1'b1;
		if (counter < INITWAIT + TIMEKEEP) begin 
		  if (counter > INITWAIT)
		    dinner <= dinner + indata;
		end
      else begin 
        donereg <= 1'b1;
		  dtmp    <= (dinner==24'd0) ? dtmp : dinner ; 
		  dinner  <= 24'd0;
		end  
	 end
  end
  
  assign done = donereg; 
  
  wire [23:0] bstmp = (dtmp / (TIMEKEEP-1));
  
  assign baseline = bstmp[13:0];
  

endmodule 