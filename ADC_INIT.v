module ADC_INIT #(
  parameter p1 = 16'h00FF,
  parameter p2 = 16'h0001,
  parameter p3 = 16'h3FFF
)
(
  input  clk,
  input  rst_n,
  output sen,
  output sclk,
  output sdata,
  output reset
);

  reg [15:0] cnt;
  reg        sta;
  reg        sts;
  reg        clr;
  reg  [7:0] addr;
  reg  [7:0] data;
  reg        din;
  reg        rst_sig;
  
  wire       int_sig;
  reg [23:0] int_cnt;
  reg        int_sts;
  reg  [1:0] int_d;  
  
  // **************************************************************************************
  // Initial Set  SEQUENCE
  // **************************************************************************************

  wire int_flg = (int_cnt == 24'hFFFFFF); //167msec

  always @(negedge rst_n or posedge clk) 
  begin
    if(~rst_n) begin 
	   int_cnt <= 24'h000000;
		int_sts <=  1'b0;
		int_d   <=  2'b00;
	 end
	 else begin
	   int_sts  <= int_flg ;
		int_cnt  <= int_flg ? int_cnt : int_cnt + 1'b1;
		int_d[0] <= int_sts ;
      int_d[1] <= int_d[0];
    end
  end

  assign int_sig = int_d[0] &  ~int_d[1];

  
  // **************************************************************************************
  // DA1 HV & DISCRI Controle
  // **************************************************************************************

  wire flg  = (cnt == p3);//16'h3FFF);
  wire flg1 = (cnt == p2);//16'h0001); 
  wire flg2 = (cnt == p1);//16'h00FF); //256*50nsec = 12.8usec
  
  always @(negedge rst_n or posedge clk) 
  begin
    if(~rst_n) begin
	   sta   <=  1'b0;
      sts   <=  1'b0;
		cnt   <= 16'h0000;
		clr   <=  1'b0;
		addr  <=  8'hFF;
		data  <=  8'hFF;
		din   <=  1'b0;
		rst_sig <=  1'b0;
    end 
	 else begin
	   sta <= int_sig;
		sts <= sta | (~clr & sts);
		cnt <= sts ? cnt + 1'b1 : 16'h0000;
		clr <= (sts & flg);
      if(sts) begin
        case(cnt[13:11])
			  3'b001 : begin
							 addr <= 8'h00;
							 data <= 8'b00000010;
						  end
			  3'b010 : begin
							 addr <= 8'h3D;
							 data <= 8'b11100000;
						  end
			  3'b011 : begin
							 addr <= 8'h41;
							 data <= 8'b11000000;
						  end
			  3'b100 : begin
							 addr <= 8'h25;
							 data <= 8'b00000011;
						  end
			  default : begin
							 addr <= 8'h41;
							 data <= 8'b11000000;
						  end
        endcase
        case(cnt[9:6])
			  4'h0 : din <= addr[7];
			  4'h1 : din <= addr[6];
			  4'h2 : din <= addr[5];
			  4'h3 : din <= addr[4];
			  4'h4 : din <= addr[3];
			  4'h5 : din <= addr[2];
			  4'h6 : din <= addr[1];
			  4'h7 : din <= addr[0];
			  4'h8 : din <= data[7];
			  4'h9 : din <= data[6];
			  4'hA : din <= data[5];
			  4'hB : din <= data[4];
			  4'hC : din <= data[3];
			  4'hD : din <= data[2];
			  4'hE : din <= data[1];
			  4'hF : din <= data[0];
			  default : begin end
        endcase
		  rst_sig <= flg1 | (~flg2 & rst_sig);
      end
      else begin
		  addr <= 8'hFF;
		  data <= 8'hFF;
        din <= 1'b0;
		  rst_sig <= 1'b0;
      end
    end
  end
  
  wire drive = sts & cnt[10];
  
  assign sen   =  ~(drive);
  assign sclk  =  ~(drive & cnt[5]);
  assign sdata =    drive & din;
  assign reset =    rst_sig;
  
  
endmodule 
