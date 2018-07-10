module dac_spi2 #(
  parameter DWIDTH = 24,
  parameter WTIME1 = 32'd10000000,
  parameter WTIME2 = 32'd30000000
)
(
  input         clk, 
  input         rst_n,
  input   [3:0] comm,
  input   [3:0] addr,
  input  [15:0] data,
  input         ext_ctrl,
  output        spi_data,
  output        spi_sclk,
  output        spi_sync,
  output        spi_enable,
  output        init_done
  // for monitoring --- to be removed
  /*output        starts_mon,
  output        enable_mon,
  output        loaded_mon,
  output  [5:0] sndcnt_mon,
  output  [5:0] enbcnt_mon,
  output  [2:0] st_cnt_mon,
  output [DWIDTH:0] senddt_mon*/
);
   
  // flags
  wire starts; // start signal 
  wire enable; // send enable flag
  wire enable2; // twice faster enable signal
 
  // internal registers
  reg  loaded; // data loaded
  reg  sending; 
  reg  sclksrc;
  
  // counters
  reg  [5:0] sndcnt;
  reg  [4:0] enbcnt;
  reg  [2:0] st_cnt;
  
  reg  [31:0] init_cnt; 
  
  // shift registers 
  reg [DWIDTH:0] senddata;
  reg [DWIDTH:0] fixsendd;

  // flag assignment 
  assign starts  = (init_cnt==WTIME1) | (init_cnt==WTIME2) | ext_ctrl; 
  assign enable  = &enbcnt; 
  assign enable2 = &enbcnt[3:0]; 
  
  assign init_done = (init_cnt > WTIME2);
  
  // init counter
  always @(negedge rst_n or posedge clk) begin
    if (~rst_n) begin 
	   init_cnt <= 32'd0;
	 end
	 else begin 
	   if (init_cnt[31]==1'b0) begin 
		  init_cnt <= init_cnt + 1'b1;
		end
	 end
  end
 
  always @(negedge rst_n or posedge enable2) begin 
    if (~rst_n) begin 
	   sclksrc <= 1'b1;
	 end 
	 else begin 
	   sclksrc <= ~sclksrc & sending;
	 end	
  end 
  
  
  always @(negedge rst_n or posedge clk) begin 
    if (~rst_n) begin 
		senddata <= {DWIDTH+1{1'b0}};
		fixsendd <= {DWIDTH+1{1'b0}};
		sndcnt   <= {6{1'b0}};
		enbcnt   <=  5'b00000;
		sending  <=  1'b0;
		loaded   <=  1'b0;
	 end
	 else begin
	   enbcnt <= enbcnt + 1'b1;
	   if (starts) begin 
		  senddata <= {1'b0, comm, addr, data};
		  fixsendd <= {1'b0, comm, addr, data};
		  loaded   <= 1'b1;
	   end
	   else begin
	     if (enable & loaded) begin 
		    st_cnt   <= 3'b000;
		    senddata <= {senddata[DWIDTH-1:0],1'b0};
			 sending  <= 1'b1; 
			 sndcnt   <= sndcnt + 1'b1; 
			 if (sndcnt==DWIDTH) begin 
			   sending <= 1'b0;
				sndcnt  <= {6{1'b0}};
				loaded  <= 1'b0;
			 end
		  end
		end 
	 end
  end
  
  assign spi_data = senddata[DWIDTH];
  assign spi_sync = ~sending;
  assign spi_sclk = sclksrc; 
  assign spi_enable = sending;

  // monitoring 
  /*assign starts_mon = starts;
  assign sndcnt_mon = sndcnt;
  assign enbcnt_mon = enbcnt;
  assign senddt_mon = fixsendd;
  assign enable_mon = enable;
  assign st_cnt_mon = st_cnt;
  assign loaded_mon = loaded;*/

endmodule
  