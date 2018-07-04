module RST_GEN #(parameter RST_TIME = 16'hFFFE) //  20MHz *256*256 = 3.28msec
(
  input  clk,
  output rst_n
);

  reg [15:0] reset_cnt; 
  reg        reset_sig;
  
  assign rst_n = reset_sig;
  
  wire reset_flag = (reset_cnt == RST_TIME);
  
  always @(posedge clk) begin 
    reset_sig <= reset_flag; 
	 reset_cnt <= reset_flag ? reset_cnt : reset_cnt + 1'b1; 
  end
  
  initial begin 
    reset_cnt <= 16'h0000;
  end

endmodule 
