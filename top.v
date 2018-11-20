// 

// First version was based on /mnt/c/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_Fujii_edit/ICE_CUBE/hdl/top_edit.vhd translated with vhd2vl v2.4 VHDL to Verilog RTL translator
// But now the project is almost completely replaced to my own logic or modules. 

module top
(
  // SYS
  input          IF_SYS_CLK, // 20 MHz
  
  // USB-UART part 
  input          IF_RX, // receiver
  output         IF_TX, // transmitter 
  
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
  input          SLO_DAC1_MISO,
  
  // Ext Trig in 
  input          EXT_TRIG_IN1,
  input          EXT_TRIG_IN2 
);

  // 

  // ***********************************************************************************************************
  // ***********************************************************************************************************
  parameter VERSION = 32'h18112004;
    
  reg [31:0] vreg;
  
  // ***********************************************************************************************************  


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
    
  // Clock
  wire CLKB;
  wire CLK_250M; // clock feed to ADCs 
  

  // **************************************************************************************
  // SYS
  // **************************************************************************************

  assign IF_TEST      = IF_SAD_SDOUT2;
  assign IF_SAD_CLK1  = CLK_250M;
  assign IF_SAD_CLK2  = CLK_250M;
  assign IF_IND_FPGA1 = IF_SAD_SDOUT1;
  assign IF_IND_FPGA2 = FIFO_FF;
  
  
  // INPUT CLOCK from ADC1
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
  // RESET module
  // **************************************************************************************
  
  RST_GEN rst_inst (
    .clk   (CLK),
	 .rst_n (RESET)
  );
  
  
  // **************************************************************************************
  // Initial setting for ADCs to enable CMOS mode
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
  // External Triger 
  // **************************************************************************************
  
  reg ext_trig1, ext_trig2;
  reg orexttrg1, orexttrg2;
  
  wire orexttrg = ext_trig1 | ext_trig2; 
  //assign IF_TEST = orexttrg; 

  always @(negedge RESET or posedge clk_adc) begin 
    if (~RESET) begin 
	   ext_trig1 <= 1'b0;
		orexttrg1 <= 1'b0;
	 end
	 else begin 
	   ext_trig1 <= EXT_TRIG_IN1;
		orexttrg1 <= orexttrg;
	 end
  end
  
  always @(negedge RESET or posedge clk_adc2) begin 
    if (~RESET) begin 
	   ext_trig2 <= 1'b0;
		orexttrg2 <= 1'b0;
	 end
	 else begin 
	   ext_trig2 <= EXT_TRIG_IN2;
		orexttrg2 <= orexttrg;
	 end
  end
  
  
  // **************************************************************************************
  // Data taking 
  // **************************************************************************************
 
  assign FIFO_DAT_IN1 = IF_SAD_D1;
  assign FIFO_DAT_IN2 = IF_SAD_D2;
 
  wire FIFO_WR_EN_RO;
  
  reg FIFO_WR_EN_RO_1, FIFO_WR_EN_RO_2;
  
  always @(posedge clk_adc) begin 
    FIFO_WR_EN_RO_1 <= FIFO_WR_EN_RO;
  end
    
  always @(posedge clk_adc2) begin
    FIFO_WR_EN_RO_2 <= FIFO_WR_EN_RO;
  end
 
 
  wire spi_sending; 
  wire ext_rst;
  
  wire [13:0] FIFO_DAT_IN1_PL;
  wire [13:0] FIFO_DAT_IN2_PL;
  
  pline #(.P_WIDTH(14),.P_DEPTH(80)) 
  pl_1 
  (
    .clk   (clk_adc),
	 .rst_n (RESET),
	 .a     (FIFO_DAT_IN1),
	 .y     (FIFO_DAT_IN1_PL)
  );
  
  pline #(.P_WIDTH(14),.P_DEPTH(80))
  pl_2
  (
    .clk   (clk_adc2),
	 .rst_n (RESET),
	 .a     (FIFO_DAT_IN2),
	 .y     (FIFO_DAT_IN2_PL)
  );
  
  wire intrig1, intrig2;
  wire [13:0] baseline_1;
  wire [13:0] baseline_2;
  reg  [13:0] baseline_1_intr;
  reg  [13:0] baseline_2_intr;
  
  always @(negedge RESET or posedge clk_adc) 
  begin 
    if (~RESET) begin 
	   baseline_1_intr <= 14'd0;
	 end
	 else begin 
	   baseline_1_intr <= baseline_1;
	 end
  end
  
  always @(negedge RESET or posedge clk_adc2) 
  begin 
    if (~RESET) begin 
	   baseline_2_intr <= 14'd0;
	 end
	 else begin 
	   baseline_2_intr <= baseline_2;
	 end
  end
  
  IntTrig #(.THRES(80),.TRGTIME(70))
  InT_1 
  (
    .clk      (clk_adc),
	 .rst_n    (RESET),
	 .baseline (baseline_1),
	 .tdat     (FIFO_DAT_IN1),
	 .otrig    (intrig1)
  );
  
  IntTrig #(.THRES(80),.TRGTIME(70))
  InT_2 
  (
    .clk      (clk_adc2),
	 .rst_n    (RESET),
	 .baseline (baseline_2),
	 .tdat     (FIFO_DAT_IN2),
	 .otrig    (intrig2)
  );
  
  wire done_1, done_2; 
  
  baseline_mes2 #(.LNCLK(6))
  bs_1 
  (
    .clk      (clk_adc), 
	 .rst_n    (RESET), 
	 .dacset   (spi_sending),
	 .indata   (FIFO_DAT_IN1), 
	 .baseline (baseline_1),
	 .done     (done_1)
  );
  
  baseline_mes2 #(.LNCLK(6))
  bs_2
  (
    .clk      (clk_adc2),
	 .rst_n    (RESET),
	 .dacset   (spi_sending),
	 .indata   (FIFO_DAT_IN2),
	 .baseline (baseline_2),
	 .done     (done_2)
  );
  
  wire ortrig = 1'b1;//intrig1 | intrig2; 
  
  reg rdenable;
   
  DAT_FIFO A1_3 
  (	
    .data    (FIFO_DAT_IN1_PL),
	 .rdclk   (CLKB),
	 .rdreq   (FIFO_RD_ENA),
	 .wrclk   (clk_adc),
	 .wrreq   (FIFO_WR_EN_RO_1 & ~FIFO_FF & orexttrg),
	 .q       (FIFO_DAT_OUT1),
	 .rdempty (FIFO_EF),
	 .wrfull  (FIFO_FF),
	 .aclr    (~RESET)
  );
  
  DAT_FIFO A2_3
  (
    .data    (FIFO_DAT_IN2_PL),
	 .rdclk   (CLKB),
	 .rdreq   (rdenable & ~FIFO_EF2),//FIFO_RD_ENA),
	 .wrclk   (clk_adc2),
	 .wrreq   (orexttrg),//FIFO_WR_EN_RO_2 & ~FIFO_FF2 & orexttrg),
	 .q       (FIFO_DAT_OUT2),
	 .rdempty (FIFO_EF2),
	 .wrfull  (FIFO_FF2),
	 .aclr    (~RESET)
  );


  wire [13:0] FIFO_UART_OUT2;
  wire FIFO_UART_EF2, FIFO_UART_FF2;
  DAT_FIFO A2_uart 
  (
    .data    (FIFO_DAT_IN2_PL),
	 .rdclk   (txclk),
	 .rdreq   (rdenable & ~FIFO_UART_EF2),//FIFO_RD_ENA),
	 .wrclk   (clk_adc2),
	 .wrreq   (orexttrg),//FIFO_WR_EN_RO_2 & ~FIFO_FF2 & orexttrg),
	 .q       (FIFO_UART_OUT2),
	 .rdempty (FIFO_UART_EF2),
	 .wrfull  (FIFO_UART_FF2),
	 .aclr    (~RESET)
  );
  
  wire exttrg; 
  wire [31:0] dacctrl;
  
  reg [13:0] baseline_1_pl, baseline_2_pl; 
  always @(negedge RESET or posedge CLKB) 
  begin 
    if (~RESET) begin 
	   baseline_1_pl <= 14'd0; 
		baseline_2_pl <= 14'd0;
	 end
	 else begin 
	   baseline_1_pl <= baseline_1;
		baseline_2_pl <= baseline_2;
	 end
  end
  
  
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
		.version_info_export   (vreg),
		.ext_rst_export        (ext_rst),
		.bs1_export            (baseline_1_pl),
		.bs2_export            (baseline_2_pl),
		.tp1_export            (FIFO_DAT_OUT1)
  );
  
  wire ext_ctrl;
  
  reg [15:0] ofstreg; 

  
  assign FIFO_RD_ENA = 1'b1;//~FIFO_EF & ~FIFO_EF2;

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
  
  wire [3:0] cmd = 4'h3;
  wire [3:0] addr; 
  
  reg  [3:0] addr_ctrl;
  reg [31:0] addr_cnt; 
  
  wire [3:0] addr_ext;
  
  parameter InitBS = 16'd32768;
  
  
  // initial addr
  always @(negedge RESET or posedge CLKB) 
  begin 
    if (~RESET) begin 
	   addr_ctrl <=  4'h0;
	   addr_cnt  <= 32'd0;
		ofstreg   <= InitBS;
    end
	 else begin 
		if (addr_cnt[31]==1'b0) begin
		  addr_cnt  <= addr_cnt + 1'b1;
		end
		if (addr_cnt==32'd20000000) begin 
		  addr_ctrl <=  4'b0100;
		  ofstreg   <=  InitBS;
		end
	 end
  end
  
  wire init_done;
  wire [15:0] sdata_ext;

  reg [15:0] sdata_tmp;
  always @(negedge RESET or posedge CLKB) 
  begin 
    if (~RESET) begin 
	   sdata_tmp <= 16'h0000;
	 end
	 else begin 
	   sdata_tmp <= init_done ? sdata_ext : ofstreg; 
	 end 
  end

  
  assign addr = init_done ? addr_ext : addr_ctrl;
  assign offset_wire = sdata_tmp;

  SPI_COMMGEN spi_gen_inst 
  (
    .clk (CLKB),
	 .rst_n (RESET),
	 .wren (~spi_sending),
	 .indata (dacctrl),
	 .ctrlen (ext_ctrl),
	 .addr (addr_ext),
	 .sdata (sdata_ext),
	 .cntmon ()
  );
  
  
  dac_spi2 spi2_inst
  (
    .clk    (CLKB),
	 .rst_n  (RESET),
	 .comm   (cmd),
	 .addr   (addr),
	 .data   (offset_wire),
	 .ext_ctrl (ext_ctrl),
	 .spi_data (SLO_DAC1_MOSI),
	 .spi_sync (SLO_DAC1_CS),
	 .spi_sclk (SLO_DAC1_SCLK),
	 .spi_enable(spi_sending),
	 .init_done (init_done)
  );
  
  
  // USB-UART controlling 
  wire txclk; 
  reg  [7:0] txdata;
  wire [7:0] fifo8_out;
  reg rxflag; 
  wire endsending;
  wire txfifo1_full, txfifo1_empty;
  
  RS232C_TX uart_tx_inst (
    .clk (CLKB),
    .rstn (RESET),
	 .tx_en (1'b1),
	 .txdata (txdata),//FIFO_DAT_OUT2[9:2]),
	 .uart_txd (IF_TX),
	 .LED (),
	 .oclk (txclk),
	 .endsending (endsending)
  );
  
  initial begin 
    rxflag = 1'b0;
  end
  
  always @(posedge txclk) begin 
    if (rxflag) begin 
	   txdata <= FIFO_UART_OUT2[7:0]; 
	 end 
	 else begin
	   txdata <= {2'b00, FIFO_UART_OUT2[13:8]};
	 end
	 if (endsending) begin 
	   rxflag <= ~rxflag; 
		if (rxflag) rdenable <= 1'b1;
		else rdenable <= 1'b0;
	 end
	 else rdenable <= 1'b0;
  end 
  
  /*TX_FIFO tx_fifo_1 (
    .data   ({2'b00,FIFO_DAT_IN1_PL}),
    .rdclk  (txclk),
    .rdreq  (1'b1),//rdenable),
    .wrclk  (clk_adc1),
    .wrreq  (1'b1),//orexttrg & ~txfifo1_full),
    .q      (fifo8_out),
    .rdempty(txfifo1_empty),
    .wrfull (txfifo1_full)
  );*/

  
  
  // version information
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
