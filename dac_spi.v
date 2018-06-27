module DAC_SPI (
  input        clk, 
  input        rst_n, 
  input [15:0] data, 
  input  [3:0] comm,
  input  [3:0] addr,
  input        ext_ctrl,
  output       spi_data,
  output       spi_sync,
  output       spi_sclk,
  output       spi_enable
  );
      
  reg nite_cnt; 
  
  reg        starts;
  reg [15:0] counts;
  reg        datain;
  reg [15:0] senddata;
  
  reg  [3:0] comm_i;
  reg  [3:0] addr_i;
    
  always @(negedge rst_n or posedge clk) begin 
    if (~rst_n) begin 
	   starts   <=  1'b0;
		counts   <= 16'h0000;
		datain   <=  1'b0;
		senddata <= 16'h0000;
		nite_cnt <=  1'b0;
		comm_i   <=  4'h0;
		addr_i   <=  4'h0;
    end
	 else begin 
	   starts   <= nite_cnt ? starts : ext_ctrl;
		if (~starts) begin 
		  comm_i   <= comm;
		  addr_i   <= addr;
		  senddata <= data;
		  datain   <= 1'b0;
		  counts   <= 16'h0000;
		end
		else begin 
		  counts   <= counts + 1'b1;
		  nite_cnt <= (counts[9:0]<{5'd23,5'b11100}); 
		  case (counts[9:5]) 
		    5'd0  : datain <= comm_i[3];
		    5'd1  : datain <= comm_i[2]; 
		    5'd2  : datain <= comm_i[1];
		    5'd3  : datain <= comm_i[0];
		    5'd4  : datain <= addr_i[3];
		    5'd5  : datain <= addr_i[2];
		    5'd6  : datain <= addr_i[1];
		    5'd7  : datain <= addr_i[0];
		    5'd8  : datain <= senddata[15];
		    5'd9  : datain <= senddata[14];
		    5'd10 : datain <= senddata[13];
		    5'd11 : datain <= senddata[12];
		    5'd12 : datain <= senddata[11];
		    5'd13 : datain <= senddata[10];
		    5'd14 : datain <= senddata[9];
		    5'd15 : datain <= senddata[8];
		    5'd16 : datain <= senddata[7];
		    5'd17 : datain <= senddata[6];
		    5'd18 : datain <= senddata[5]; 
		    5'd19 : datain <= senddata[4];
		    5'd20 : datain <= senddata[3];
		    5'd21 : datain <= senddata[2];
		    5'd22 : datain <= senddata[1];
		    5'd23 : datain <= senddata[0];
		    default : datain <= 1'b0;
		  endcase
		end 
    end
  end
  
  
  assign spi_enable = starts & counts[10]; // active high
  
  assign spi_sync =  ~spi_enable;
  assign spi_sclk = ~(spi_enable & counts[4]);
  assign spi_data =   spi_enable & datain; 
 
endmodule 