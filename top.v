// File /mnt/c/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_Fujii_edit/ICE_CUBE/hdl/top_edit.vhd translated with vhd2vl v2.4 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 1995

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002, 2005, 2008-2010 Larry Doolittle - LBNL
//     http://doolittle.icarus.com/~larry/vhd2vl/
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

//use synplify.attributes.all;		--spase synplifty library
//library Axcelerator;
//use Axcelerator.all;
//library WORK;
//use work.def_pack.all;
//use work.ver_pack.all;
// no timescale needed

module top
(
  // SYS
  input          IF_SYS_CLK, // 20 MHz
  input          IF_RX,
  
  // ADC1
  output         IF_SAD_CLK1, // LVDS
  input  [13:0]  IF_SAD_D1,
  input          IF_SAD_CKO1,
  output         IF_SAD_RESET1,
  output         IF_SAD_SCLK1,
  output         IF_SAD_SDAT1,
  output         IF_SAD_SEN1,
  input          IF_SAD_SDOUT1,
  
  // ADC2
  output         IF_SAD_CLK2, // LVDS
  input  [13:0]  IF_SAD_D2,
  input          IF_SAD_CKO2,
  output         IF_SAD_RESET2,
  output         IF_SAD_SCLK2,
  output         IF_SAD_SDAT2,
  output         IF_SAD_SEN2,
  input          IF_SAD_SDOUT2,
  
  // Test output ports
  output         IF_IND_FPGA1,
  output         IF_IND_FPGA2,
  output         IF_TEST,
  
  // Slow DAC
  output         SLO_DAC1_CS, 
  output         SLO_DAC1_SCLK, 
  output         SLO_DAC1_MOSI, 
  input          SLO_DAC1_MISO 
);

  // 

  // ***********************************************************************************************************
  // ***********************************************************************************************************
  parameter AA = 1023;  //511; --512;

  // basic wires
  wire CLK; 
  wire RESET;  

  // FIFO control
  wire [13:0] FIFO_DAT_IN1;
  wire [13:0] FIFO_DAT_IN2;
  wire [13:0] FIFO_DAT_OUT1;
  wire [13:0] FIFO_DAT_OUT2;
  
  //reg  FIFO_WR_ENA;
  wire FIFO_WR_ENA = 1'b1;
  wire FIFO_RD_ENA;
  wire FIFO_FF;
  wire FIFO_EF;
  
  wire FIFO_FF2;
  wire FIFO_EF2;
    
  
  reg  [3:0] IN_AD_CLK_CNT;
  
  // counters
  reg  [7:0] uSEC_SIG_CNT; 
  reg [11:0] mSEC_SIG_CNT;
  reg  [7:0] hSEC_SIG_CNT;
  reg  [7:0]  SEC_SIG_CNT;
  reg  uSEC_SIG;
  reg  mSEC_SIG;
  reg  hSEC_SIG;
  reg   SEC_SIG;
  
  reg [39:0] IN_TIME;  
  
  wire        IN_CMD_CAL;
  wire  [7:0] IN_CMD_DISC;
  wire        IN_SET_DAC;
  wire [31:0] IN_TOTAL_CNT;
  wire        IN_TRIG1_START;
  wire  [3:0] IN_TRIG1_CNT;
  wire        IN_SET_ADC_INI;
  wire  [3:0] IN_CMD_AD_FREQ;
  wire  [7:0] IN_CAL_CLK_CNT;
  wire        IN_CAL_CLK_PLS;
  wire        DA1_SEQ_STS;
  wire        DA1_SEQ_CLR;
  wire [11:0] DA1_SEQ_CNT;
  wire        DA1_DIN;
  wire        DA1_SEQ_STA;
  wire  [1:0] DA1_SEL_CH;
  
  // Initial commands
  wire       INT_SEQ_SIG;  
  reg        INT_SEQ_STS;  
  reg [23:0] INT_SEQ_CNT;
  reg  [1:0] INT_SEQ_D;
  reg        SAD_INI_SEQ_STS;
  reg        SAD_INI_SEQ_CLR;
  reg [15:0] SAD_INI_SEQ_CNT;
  reg        SAD_INI_SEQ_DIN;
  reg        SAD_INI_SEQ_STA;
  reg  [7:0] SAD_INI_ADD;
  reg  [7:0] SAD_INI_DAT;
  reg        SAD_INI_RESET_SIG;
  reg        TRIG_SEQ_STS;
  reg        TRIG_SEQ_CLR;
  reg [11:0] TRIG_SEQ_CNT;
  
  // Clock
  wire CLKB;
  wire CLK_250M; // clock feed to ADCs 
  
  // Reset 
  reg [15:0] RESET_COUNT;
  reg        RESET_SIG;  //   attribute syn_radhardlevel of sftbuf1: signal is "cc"; 


  // **************************************************************************************
  // SYS
  // **************************************************************************************
  // SYS
  //assign CLKB         = CLK_250M;
  assign IF_TEST      = IF_SAD_SDOUT1;
  assign IF_SAD_CLK1  = CLK_250M;
  assign IF_SAD_CLK2  = CLK_250M;
  assign IF_IND_FPGA1 = IF_SAD_SDOUT1;
  assign IF_IND_FPGA2 = FIFO_FF;
  
  
  // INPUT CLOCK 
  wire clka_out;
  ADCINCLKCTRL ADC1_CLKCTRL
  (
    .inclk  (IF_SAD_CKO1),
	 .outclk (clka_out)
  );
  
  wire clk_adc;
  wire clk_ro;
  wire adc_pll_locked;
  ADC_PLL ADC_PLL1 
  (
    .refclk   (clka_out),
	 .rst      (1'b0),
	 .outclk_0 (clk_adc), // same frequency as CLK_250M. 
	 .outclk_1 (clk_ro),
	 .locked   (adc_pll_locked)
  );

  
  // INPUT CLOCK from ADC2
  wire clka_out2;
  ADCINCLKCTRL ADC2_CLKCTRL
  (
    .inclk  (IF_SAD_CKO2),
	 .outclk (clka_out2)
  );
  
  wire clk_adc2;
  wire clk_ro2;
  wire adc_pll_locked2;
  ADC_PLL ADC_PLL2 
  (
    .refclk   (clka_out2),
	 .rst      (1'b0),
	 .outclk_0 (clk_adc2),
	 .outclk_1 (clk_ro2),
	 .locked   (adc_pll_locked2)
  );
  

  // **************************************************************************************
  // RESET
  // **************************************************************************************

  wire RST_FLG = (RESET_COUNT == 16'hFFFE); // 20MHz *256*256 = 3.28msec
  
  always @(posedge CLK) 
  begin
    RESET_SIG   <= RST_FLG;
	 RESET_COUNT <= RST_FLG ? RESET_COUNT : RESET_COUNT + 1'b1;
  end

  assign RESET = RESET_SIG;
  

  // **************************************************************************************
  // TIME Controle
  // **************************************************************************************

  wire uSEC_SIG_FLG = (uSEC_SIG_CNT ==  8'h13 ); // 20MHz 20 14(H)
  wire mSEC_SIG_FLG = (mSEC_SIG_CNT == 12'h3E7); // 1msec 1usec*1000 3E8(H)
  wire hSEC_SIG_FLG = (hSEC_SIG_CNT ==  8'h63 ); // 0.1sec 1msec*100 64
  wire  SEC_SIG_FLG = ( SEC_SIG_CNT ==  4'h9  ); // 1sec 0.1sec*10

  always @(negedge RESET or posedge clk_adc) 
  begin
	 if(~RESET) 
	 begin 
	   uSEC_SIG_CNT <=  8'h00;
		uSEC_SIG     <=  1'b0;
	   mSEC_SIG_CNT <= 12'h000;
		mSEC_SIG     <=  1'b0;
      hSEC_SIG_CNT <=  8'h00;
      hSEC_SIG     <=  1'b0;
	    SEC_SIG_CNT <=  8'h00;
		 SEC_SIG     <=  1'b0;
		 IN_TIME     <= 40'd0;
    end
	 else 
	 begin
	   uSEC_SIG     <= uSEC_SIG_FLG ;
		mSEC_SIG     <= uSEC_SIG ? mSEC_SIG_FLG : 1'b0;
		hSEC_SIG     <= mSEC_SIG ? hSEC_SIG_FLG : 1'b0;
		SEC_SIG      <= hSEC_SIG ?  SEC_SIG_FLG : 1'b0;
		uSEC_SIG_CNT <= uSEC_SIG_FLG ? 8'h00 : 
		                               uSEC_SIG_CNT + 1'b1;
		mSEC_SIG_CNT <=    ~uSEC_SIG ? mSEC_SIG_CNT : 
		                mSEC_SIG_FLG ? 12'h000 : 
								             mSEC_SIG_CNT + 1'b1;
		hSEC_SIG_CNT <=    ~mSEC_SIG ? hSEC_SIG_CNT : 
		                hSEC_SIG_FLG ? 8'h00 : 
							                hSEC_SIG_CNT + 1'b1;
		SEC_SIG_CNT  <=    ~hSEC_SIG ? SEC_SIG_CNT : 
		                 SEC_SIG_FLG ? 8'h00 : 
							                SEC_SIG_CNT + 1'b1;
      IN_TIME <= SEC_SIG ? IN_TIME + 1'b1 : IN_TIME;

    end
  end


  //----------------------------------------- ADC CLK Controle

  always @(negedge RESET or posedge CLK) 
  begin
    if(~RESET) 
	 begin 
	   IN_AD_CLK_CNT <= 4'h0;
	 end
	 else 
	 begin
      IN_AD_CLK_CNT <= IN_AD_CLK_CNT + 1'b1;
    end
  end

  //always @(CLK or IN_AD_CLK_CNT) begin
  //  FIFO_WR_ENA <= 1'b1;
  //end


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

  wire SAD_INI_SEQ_FLG   = (SAD_INI_SEQ_CNT == 16'h3FFF);
  wire SAD_INI_SEQ_FLG_1 = (SAD_INI_SEQ_CNT == 16'h0001); 
  wire SAD_INI_SEQ_FLG_2 = (SAD_INI_SEQ_CNT == 16'h00FF); //256*50nsec = 12.8usec
  
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


  // **************************************************************************************
  // DATA AQUISITION  Controle
  // **************************************************************************************

  assign IN_TRIG1_START = SEC_SIG;

  wire TRIG_SEQ_FLG = (TRIG_SEQ_CNT == 12'h3FF);

  always @(negedge RESET or posedge clk_adc) 
  begin
    if(~RESET) 
	 begin
      TRIG_SEQ_STS <= 1'b0;
		TRIG_SEQ_CNT <= 12'h000;
		TRIG_SEQ_CLR <= 1'b0;
    end
	 else 
	 begin
      if(TRIG_SEQ_CLR) 
		begin
        TRIG_SEQ_STS <= 1'b0;
      end
      else if(IN_TRIG1_START) 
		begin
        TRIG_SEQ_STS <= 1'b1;
      end
		if(TRIG_SEQ_STS) 
		begin
		  TRIG_SEQ_CNT <= FIFO_WR_ENA ? TRIG_SEQ_CNT + 1'b1 : TRIG_SEQ_CNT;
      end
      else 
		begin
        TRIG_SEQ_CNT <= 12'h000;
      end
		TRIG_SEQ_CLR <= (TRIG_SEQ_STS & TRIG_SEQ_FLG);
    end
  end

 
  assign FIFO_DAT_IN1 = IF_SAD_D1[13:0];
  assign FIFO_DAT_IN2 = IF_SAD_D2[13:0];
 
  wire FIFO_WR_EN_RO;
  
  reg FIFO_WR_EN_RO_1;
  
  always @(clk_adc) 
  begin 
    FIFO_WR_EN_RO_1 <= FIFO_WR_EN_RO;
  end
  
  reg FIFO_WR_EN_RO_2;
  
  always @(clk_adc2) 
  begin
    FIFO_WR_EN_RO_2 <= FIFO_WR_EN_RO;
  end
 
 
  wire spi_sending; 
  
  wire [13:0] FIFO_DAT_IN1_PL;
  wire [13:0] FIFO_DAT_IN2_PL;
  
  pline #(.P_WIDTH(14),.P_DEPTH(10)) 
  pl_1 
  (
    .clk   (CLKB),
	 .rst_n (RESET),
	 .a     (FIFO_DAT_IN1),
	 .y     (FIFO_DAT_IN1_PL)
  );
 
  DAT_FIFO A1_3 
  (	
    .data    (FIFO_DAT_IN1_PL),
	 .rdclk   (CLKB),
	 .rdreq   (FIFO_RD_ENA),
	 .wrclk   (clk_adc),
	 .wrreq   (FIFO_WR_ENA & TRIG_SEQ_STS & FIFO_WR_EN_RO_1 & ~spi_sending),
	 .q       (FIFO_DAT_OUT1),
	 .rdempty (FIFO_EF),
	 .wrfull  (FIFO_FF),
	 .aclr    (~RESET)
  );
  
  DAT_FIFO A2_3 
  (
    .data    (FIFO_DAT_IN2),
	 .rdclk   (CLKB),
	 .rdreq   (FIFO_RD_ENA),
	 .wrclk   (clk_adc2),
	 .wrreq   (FIFO_WR_ENA & TRIG_SEQ_STS & FIFO_WR_EN_RO_2 & ~spi_sending),
	 .q       (FIFO_DAT_OUT2),
	 .rdempty (FIFO_EF2),
	 .wrfull  (FIFO_FF2),
	 .aclr    (~RESET)
  );
  
  TestRO test_A1 
  (
  		.clk_clk               (CLKB),               //       clk.clk
		.fifo_0_in_writedata   (FIFO_DAT_OUT1),   // fifo_0_in.writedata
		.fifo_0_in_write       (FIFO_RD_ENA),       //          .write
		.fifo_0_in_waitrequest (1'b0), //          .waitrequest
		.fifo_1_in_writedata   (FIFO_DAT_OUT2),   // fifo_0_in.writedata
		.fifo_1_in_write       (FIFO_RD_ENA),       //          .write
		.fifo_1_in_waitrequest (1'b0), //          .waitrequest
		.reset_reset_n         (RESET),          //     reset.reset_n
		.write_en_export       (FIFO_WR_EN_RO),
		.exttrg_0_export       ()
  );
  
  assign FIFO_RD_ENA = ~FIFO_EF;

  SYS_GCLK A0 
  (
    .inclk  (IF_SYS_CLK),
	 .outclk (CLK)
  );

  SYS_PLL A1 
  (
    .refclk   (CLK),
	 .rst      (1'b0),
	 .outclk_0 (CLKB),
	 .outclk_1 (CLK_250M)
  );

  wire [15:0] offset_wire;
  
  wire ext_ctrl;
  reg ext_ctrl_src;
  reg [31:0] test_counter;
  wire eotest = (test_counter == 32'hFFFFFFFF);
 
  always @(negedge RESET or posedge CLKB) 
  begin 
    if (~RESET) 
	 begin 
	   ext_ctrl_src <=  1'b0;
		test_counter <= 32'd0;
	 end 
	 else 
	 begin 
	   ext_ctrl_src <= eotest ? 1'b0 : 1'b1;
	   test_counter <= eotest ? test_counter : test_counter + 1'b1;
	 end
  end 
  
  
  assign ext_ctrl = ext_ctrl_src;
  
  assign offset_wire = 16'd32768;
  
  
  wire [3:0] cmd = 4'h3;
  wire [3:0] addr; 
  
  reg  [3:0] addr_ctrl;
  reg        addr_cnt; 
  
  always @(negedge RESET or posedge CLKB) 
  begin 
    if (~RESET) 
	 begin 
	   addr_ctrl <= 4'h0;
	   addr_cnt  <= 1'b0;	
    end
	 else 
	 begin 
	   addr_ctrl <= addr_cnt ? 4'h4 : 4'h0;
		addr_cnt  <= 1'b1;
	 end
  end
  
  DAC_SPI spi_inst 
  (
    .clk    (CLKB),
	 .rst_n  (RESET),
	 .data   (offset_wire),
	 .comm   (4'h3),
	 .addr   (4'hF),
	 .ext_ctrl(ext_ctrl),
	 .spi_data(SLO_DAC1_MOSI),
	 .spi_sync(SLO_DAC1_CS),
	 .spi_sclk(SLO_DAC1_SCLK),
	 .spi_enable(spi_sending)
  );
  
  SPI_CMDGEN spi_addrgen_inst 
  (
    .clk    (CLKB),
	 .rst_n  (RESET),
	 .out_en (~spi_sending),
	 .incmd  (addr_ctrl),
	 .outcmd (addr)
  );
  
  
  
 

endmodule
