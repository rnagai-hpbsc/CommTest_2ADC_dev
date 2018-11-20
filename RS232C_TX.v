`timescale 1ns / 1ps

module RS232C_TX (
  input        clk, 
  input        rstn,
  input        tx_en,
  input  [7:0] txdata,
  output       uart_txd,
  output [7:0] LED,
  output       oclk,
  output       endsending
  );
  
  
  reg txd_out;
  assign uart_txd = txd_out;

  reg [15:0] clock_count;
  reg serclk;

  reg [3:0] ch;

  reg [9:0] buffer;
  reg [3:0] sendcnt;
  assign LED[7:0] = buffer[7:0];

  always @(posedge clk) begin
    if (clock_count < 868) begin // counts = 868 -- 115200bps, with SYSCLK = 100MHz
      serclk <= 1'b0;
      clock_count <= clock_count + 1'b1;
    end
    else begin
      serclk <= 1'b1;
      clock_count <= 0;
    end
  end

  always @(posedge serclk) begin
    txd_out <= buffer[0];
    if (tx_en & rstn & (sendcnt == 0)) begin
	   buffer  <= {1'b1,txdata,1'b0};
		sendcnt <= 1;
    end
    else begin
      if (sendcnt != 0)  
        sendcnt <= sendcnt + 1'b1;
      buffer[8:0] <= buffer[9:1];
      buffer[9]   <= 1'b1;
    end
  end
  
  assign oclk = serclk;
  assign endsending = (sendcnt==4'b1111);
  
  initial begin 
    buffer = {10{1'b1}};
  end 

endmodule
