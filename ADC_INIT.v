module ADC_INIT #(
  parameter p1 = 16'h00FF,
  parameter p2 = 16'h0001,
  parameter p3 = 16'h3FFF
)
(
  input  CLK,
  input  RESET,
  output IF_SAD_SEN1,
  output IF_SAD_SCLK1,
  output IF_SAD_SDAT1,
  output IF_SAD_RESET1,
  output IF_SAD_SEN2,
  output IF_SAD_SCLK2,
  output IF_SAD_SDAT2,
  output IF_SAD_RESET2
);

  reg [15:0] SAD_INI_SEQ_CNT;
  reg        SAD_INI_SEQ_STA;
  reg        SAD_INI_SEQ_STS;
  reg        SAD_INI_SEQ_CLR;
  reg  [7:0] SAD_INI_ADD;
  reg  [7:0] SAD_INI_DAT;
  reg        SAD_INI_SEQ_DIN;
  reg        SAD_INI_RESET_SIG;
  
  wire       INT_SEQ_SIG;
  reg [23:0] INT_SEQ_CNT;
  reg        INT_SEQ_STS;
  reg  [1:0] INT_SEQ_D;  
  
  // **************************************************************************************
  // Initial Set  SEQUENCE
  // **************************************************************************************

  wire INT_SEQ_FLG = (INT_SEQ_CNT == 24'hFFFFFF); //167msec

  always @(negedge RESET or posedge CLK) 
  begin
    if(~RESET) 
	 begin 
	   INT_SEQ_CNT <= 24'h000000;
		INT_SEQ_STS <=  1'b0;
		INT_SEQ_D   <=  2'b00;
	 end
	 else 
	 begin
	   INT_SEQ_STS  <= INT_SEQ_FLG ;
		INT_SEQ_CNT  <= INT_SEQ_FLG ? INT_SEQ_CNT : INT_SEQ_CNT + 1'b1;
		INT_SEQ_D[0] <= INT_SEQ_STS ;
      INT_SEQ_D[1] <= INT_SEQ_D[0];
    end
  end

  assign INT_SEQ_SIG = INT_SEQ_D[0] &  ~INT_SEQ_D[1];

  
  // **************************************************************************************
  // DA1 HV & DISCRI Controle
  // **************************************************************************************

  wire SAD_INI_SEQ_FLG   = (SAD_INI_SEQ_CNT == p3);//16'h3FFF);
  wire SAD_INI_SEQ_FLG_1 = (SAD_INI_SEQ_CNT == p2);//16'h0001); 
  wire SAD_INI_SEQ_FLG_2 = (SAD_INI_SEQ_CNT == p1);//16'h00FF); //256*50nsec = 12.8usec
  
  always @(negedge RESET or posedge CLK) 
  begin
    if(~RESET) 
	 begin
	   SAD_INI_SEQ_STA   <=  1'b0;
      SAD_INI_SEQ_STS   <=  1'b0;
		SAD_INI_SEQ_CNT   <= 16'h0000;
		SAD_INI_SEQ_CLR   <=  1'b0;
		SAD_INI_ADD       <=  8'hFF;
		SAD_INI_DAT       <=  8'hFF;
		SAD_INI_SEQ_DIN   <=  1'b0;
		SAD_INI_RESET_SIG <=  1'b0;
    end 
	 else 
	 begin
	   SAD_INI_SEQ_STA <= INT_SEQ_SIG;
		SAD_INI_SEQ_STS <= SAD_INI_SEQ_STA ? 1'b1 : 
		                   SAD_INI_SEQ_CLR ? 1'b0 :
								                   SAD_INI_SEQ_STS;
		SAD_INI_SEQ_CNT <= SAD_INI_SEQ_STS ? SAD_INI_SEQ_CNT + 1'b1 : 
		                                     16'h0000;
		SAD_INI_SEQ_CLR <= (SAD_INI_SEQ_STS & SAD_INI_SEQ_FLG);
      if(SAD_INI_SEQ_STS) 
		begin
        case(SAD_INI_SEQ_CNT[13:11])
        3'b001 : begin
                   SAD_INI_ADD <= 8'h00;
                   SAD_INI_DAT <= 8'b00000010;
                 end
        3'b010 : begin
                   SAD_INI_ADD <= 8'h3D;
                   SAD_INI_DAT <= 8'b11100000;
                 end
        3'b011 : begin
                   SAD_INI_ADD <= 8'h41;
                   SAD_INI_DAT <= 8'b11000000;
                 end
        3'b100 : begin
                   SAD_INI_ADD <= 8'h25;
                   SAD_INI_DAT <= 8'b00000011;
                 end
        default : begin
                   SAD_INI_ADD <= 8'h41;
                   SAD_INI_DAT <= 8'b11000000;
                 end
        endcase
        case(SAD_INI_SEQ_CNT[9:6])
        4'h0 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[7];
        4'h1 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[6];
        4'h2 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[5];
        4'h3 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[4];
        4'h4 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[3];
        4'h5 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[2];
        4'h6 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[1];
        4'h7 : SAD_INI_SEQ_DIN <= SAD_INI_ADD[0];
        4'h8 : SAD_INI_SEQ_DIN <= SAD_INI_DAT[7];
        4'h9 : SAD_INI_SEQ_DIN <= SAD_INI_DAT[6];
        4'hA : SAD_INI_SEQ_DIN <= SAD_INI_DAT[5];
        4'hB : SAD_INI_SEQ_DIN <= SAD_INI_DAT[4];
        4'hC : SAD_INI_SEQ_DIN <= SAD_INI_DAT[3];
        4'hD : SAD_INI_SEQ_DIN <= SAD_INI_DAT[2];
        4'hE : SAD_INI_SEQ_DIN <= SAD_INI_DAT[1];
        4'hF : SAD_INI_SEQ_DIN <= SAD_INI_DAT[0];
        default : begin end
        endcase
		  SAD_INI_RESET_SIG <= SAD_INI_SEQ_FLG_1 ? 1'b1 :
		                       SAD_INI_SEQ_FLG_2 ? 1'b0 : 
									                      SAD_INI_RESET_SIG;
      end
      else 
		begin
		  SAD_INI_ADD <= 8'hFF;
		  SAD_INI_DAT <= 8'hFF;
        SAD_INI_SEQ_DIN <= 1'b0;
		  SAD_INI_RESET_SIG <= 1'b0;
      end
    end
  end
  
  
  assign IF_SAD_SEN1   =  ~((SAD_INI_SEQ_STS & SAD_INI_SEQ_CNT[10]));
  assign IF_SAD_SCLK1  =  ~((SAD_INI_SEQ_STS & SAD_INI_SEQ_CNT[10] & SAD_INI_SEQ_CNT[5]));
  assign IF_SAD_SDAT1  =     SAD_INI_SEQ_STS & SAD_INI_SEQ_CNT[10] & SAD_INI_SEQ_DIN;
  assign IF_SAD_RESET1 =     SAD_INI_RESET_SIG;
  //13usec
  assign IF_SAD_SEN2   =  ~((SAD_INI_SEQ_STS & SAD_INI_SEQ_CNT[10]));
  assign IF_SAD_SCLK2  =  ~((SAD_INI_SEQ_STS & SAD_INI_SEQ_CNT[10] & SAD_INI_SEQ_CNT[5]));
  assign IF_SAD_SDAT2  =     SAD_INI_SEQ_STS & SAD_INI_SEQ_CNT[10] & SAD_INI_SEQ_DIN;
  assign IF_SAD_RESET2 =     SAD_INI_RESET_SIG;
  
  
endmodule 
