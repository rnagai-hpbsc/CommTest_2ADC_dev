// 

// First version was based on /mnt/c/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_Fujii_edit/ICE_CUBE/hdl/top_edit.vhd translated with vhd2vl v2.4 VHDL to Verilog RTL translator
// But now the project is almost completely replaced to my own logic or modules. 

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
  parameter VERSION = 32'h18070900;
    
  reg [31:0] vreg;

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
  
  wire        IN_TRIG1_START;
  
  // Initial commands
  reg        TRIG_SEQ_STS;
  reg        TRIG_SEQ_CLR;
  reg [11:0] TRIG_SEQ_CNT;
  
  // Clock
  wire CLKB;
  wire CLK_250M; // clock feed to ADCs 
  

  // **************************************************************************************
  // SYS
  // **************************************************************************************
  // SYS
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
  wire adc_pll_locked;
  ADC_PLL ADC_PLL1 
  (
    .refclk   (clka_out),
	 .rst      (1'b0),
	 .outclk_0 (clk_adc), // same frequency as CLK_250M. 
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
  wire adc_pll_locked2;
  ADC_PLL ADC_PLL2 
  (
    .refclk   (clka_out2),
	 .rst      (1'b0),
	 .outclk_0 (clk_adc2),
	 .locked   (adc_pll_locked2)
  );
  

  // **************************************************************************************
  // RESET
  // **************************************************************************************
  
  RST_GEN rst_inst (
    .clk   (CLK),
	 .rst_n (RESET)
  );
  

  // **************************************************************************************
  // TIME Controle
  // **************************************************************************************

  wire uSEC_SIG_FLG = (uSEC_SIG_CNT ==  8'h13 ); // 20MHz 20 14(H)
  wire mSEC_SIG_FLG = (mSEC_SIG_CNT == 12'h3E7); // 1msec 1usec*1000 3E8(H)
  wire hSEC_SIG_FLG = (hSEC_SIG_CNT ==  8'h63 ); // 0.1sec 1msec*100 64
  wire  SEC_SIG_FLG = ( SEC_SIG_CNT ==  4'h9  ); // 1sec 0.1sec*10

  always @(negedge RESET or posedge CLKB) 
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

  wire sen, sclk, sdata, reset;
  
  ADC_INIT init_inst (
    .clk (CLK),
	 .rst_n (RESET),
    .sen (sen),
    .sclk (sclk),
    .sdata (sdata),
    .reset (reset)
  );
  
  assign IF_SAD_SEN1 = sen;
  assign IF_SAD_SCLK1 = sclk;
  assign IF_SAD_SDAT1 = sdata;
  assign IF_SAD_RESET1 = reset;
  
  assign IF_SAD_SEN2 = sen;
  assign IF_SAD_SCLK2 = sclk;
  assign IF_SAD_SDAT2 = sdata;
  assign IF_SAD_RESET2 = reset; 
  
  // **************************************************************************************
  // DATA AQUISITION  Controle
  // **************************************************************************************

  assign IN_TRIG1_START = SEC_SIG;

  wire TRIG_SEQ_FLG = (TRIG_SEQ_CNT == 12'h3FF);

  always @(negedge RESET or posedge CLKB) 
  begin
    if(~RESET) begin
      TRIG_SEQ_STS <= 1'b0;
		TRIG_SEQ_CNT <= 12'h000;
		TRIG_SEQ_CLR <= 1'b0;
    end
	 else begin
      if(TRIG_SEQ_CLR) begin
        TRIG_SEQ_STS <= 1'b0;
      end
      else if(IN_TRIG1_START) begin
        TRIG_SEQ_STS <= 1'b1;
      end
		if(TRIG_SEQ_STS) begin
		  TRIG_SEQ_CNT <= FIFO_WR_ENA ? TRIG_SEQ_CNT + 1'b1 : TRIG_SEQ_CNT;
      end
      else begin
        TRIG_SEQ_CNT <= 12'h000;
      end
		TRIG_SEQ_CLR <= (TRIG_SEQ_STS & TRIG_SEQ_FLG);
    end
  end

 
  assign FIFO_DAT_IN1 = IF_SAD_D1;
  assign FIFO_DAT_IN2 = IF_SAD_D2;
 
  wire FIFO_WR_EN_RO;
  
  reg FIFO_WR_EN_RO_1;
  reg TRIG_SEQ_STS_1; 
  
  always @(posedge clk_adc) begin 
    FIFO_WR_EN_RO_1 <= FIFO_WR_EN_RO;
	 TRIG_SEQ_STS_1  <= TRIG_SEQ_STS;
  end
  
  reg FIFO_WR_EN_RO_2;
  reg TRIG_SEQ_STS_2;
  
  always @(posedge clk_adc2) begin
    FIFO_WR_EN_RO_2 <= FIFO_WR_EN_RO;
	 TRIG_SEQ_STS_2  <= TRIG_SEQ_STS;
  end
 
 
  wire spi_sending; 
  
  wire [13:0] FIFO_DAT_IN1_PL;
  wire [13:0] FIFO_DAT_IN2_PL;
  
  /*pline #(.P_WIDTH(14),.P_DEPTH(10)) 
  pl_1 
  (
    .clk   (CLKB),
	 .rst_n (RESET),
	 .a     (FIFO_DAT_IN1),
	 .y     (FIFO_DAT_IN1_PL)
  );*/
 
  DAT_FIFO A1_3 
  (	
    .data    (FIFO_DAT_IN1),
	 .rdclk   (CLKB),
	 .rdreq   (FIFO_RD_ENA),
	 .wrclk   (clk_adc),
	 .wrreq   (FIFO_WR_ENA & TRIG_SEQ_STS_1 & FIFO_WR_EN_RO_1),
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
	 .wrreq   (FIFO_WR_ENA & TRIG_SEQ_STS_2 & FIFO_WR_EN_RO_2),
	 .q       (FIFO_DAT_OUT2),
	 .rdempty (FIFO_EF2),
	 .wrfull  (FIFO_FF2),
	 .aclr    (~RESET)
  );
  
  wire exttrg; 
  wire [31:0] dacctrl;
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
		.exttrg_0_export       (exttrg),
		.dacctrl_export        (dacctrl),
		.version_info_export   (vreg)
  );
  
  wire ext_ctrl;
  reg  ext_ctrl_src;
  
  assign ext_ctrl = ext_ctrl_src;
  
  reg [31:0] dacctrl_reg; 
  reg flg; 
  reg [31:0] cntflg;
  reg [15:0] ofstreg; 

  
  assign FIFO_RD_ENA = ~FIFO_EF & ~FIFO_EF2;

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
   
  
  assign offset_wire = ofstreg;
  
  
  wire [3:0] cmd = 4'h3;
  wire [3:0] addr; 
  
  reg  [3:0] addr_ctrl;
  reg [31:0] addr_cnt; 
  
  parameter InitBS = 16'd32768;//16'd32768;
  
  
  // initial addr
  always @(negedge RESET or posedge CLKB) 
  begin 
    if (~RESET) begin 
	   addr_ctrl <=  4'h0;
	   addr_cnt  <= 32'd0;
		ofstreg   <= InitBS;
		dacctrl_reg <= 32'd0;
		flg <= 1'b0;
		cntflg <= 32'd0;
    end
	 else begin 
		if (~addr_cnt[31]) begin
		  addr_cnt  <= addr_cnt + 1'b1;
		end
		if (addr_cnt==32'd20000000) begin 
		  addr_ctrl <=  4'b0100;
		  ofstreg   <=  InitBS;
		end
		if (dacctrl[31]) begin 
		  dacctrl_reg <= dacctrl;
		  flg <= 1'b1;
		end
		if (flg) begin 
		  cntflg <= cntflg + 1'b1;
		  ext_ctrl_src <= 1'b1;
		  addr_ctrl <= dacctrl[19:16];
		  ofstreg <= dacctrl[15:0];
		  if (cntflg==32'd10) begin
		    flg <= 1'b0;
			 ext_ctrl_src <= 1'b0;
			 addr_ctrl <= 4'h0;
			 ofstreg <= 16'h0000;
		  end
		end
	 end
  end
  
  assign addr = addr_ctrl;
 
  
  dac_spi2 spi2_inst
  (
    .clk    (CLKB),
	 .rst_n  (RESET),
	 .comm   (4'h3),
	 .addr   (addr),
	 .data   (offset_wire),
	 .ext_ctrl (ext_ctrl),
	 .spi_data (SLO_DAC1_MOSI),
	 .spi_sync (SLO_DAC1_CS),
	 .spi_sclk (SLO_DAC1_SCLK),
	 .spi_enable(spi_sending)
  );
  
  // version 
  always @(negedge RESET or posedge CLKB) 
  begin 
    if (~RESET) begin 
	   vreg <= 32'd0;
    end 
	 else begin 
	   vreg <= VERSION; 
    end
  end

endmodule
