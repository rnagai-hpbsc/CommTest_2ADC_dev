// File /mnt/c/Users/icecube/WorkSpace/Altera/D-Egg_fw/CommTest_Fujii_edit/ICE_CUBE/hdl/Cmd_dec.vhd translated with vhd2vl v2.4 VHDL to Verilog RTL translator
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

// cmd_dec
//library synplify; 
//  use synplify.attributes.all;
// no timescale needed

module CMD_DEC(
  input  wire      CLK,
  input  wire      RESET,
  input  wire      IF_RX,
  input  wire      SEC_SIG,
  output reg       IN_CMD_CAL,
  output reg [7:0] IN_CMD_DISC,
  output reg [3:0] IN_CMD_AD_FREQ,
  output reg       IN_SET_DAC,
  output reg       IN_SET_ADC_INI,
  output reg [3:0] IN_CMD_AD_CTRL
);


  //attribute syn_radhardlevel : string;
  //attribute syn_radhardlevel of DEC:architecture is "tmr_cc";
  //constant SEN_ID : Bit_Vector := "0001";
  wire IN_USB_RX;
  reg CMD_CLK_UP2;
  reg CMD_EXE_SIG;
  reg [1:0] CMD_COUNT;
  reg [7:0] IN_CMD_DAT1; reg [7:0] IN_CMD_DAT2;
  reg [7:0] IN_CMD_DAT3; reg [7:0] IN_CMD_DAT4;
  reg [7:0] COM_DATA;
  wire IN_RX;
  reg [2:0] RX_D;
  reg COM_SEQ_STS;
  reg COM_SEQ_CLR;
  reg COM_SEQ_STS1;
  reg COM_SEQ_CLR1;
  reg [11:0] COM_SEQ_CLK_CNT;
  reg COM_SEQ_CLK;
  reg [3:0] COM_SEQ_ID;
  reg [7:0] COM_SEQ_TIME_OUT;
  reg COM_SEQ_TIME_OUT_SIG;

  assign IN_USB_RX = IF_RX;
  //------------------------------------------------------------------------------------------
  // COMMAND DECCODE LEVEL COMMAND
  //------------------------------------------------------------------------------------------
  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      RX_D <= {3{1'b0}};
    end
	 else begin
      RX_D[0] <= IN_USB_RX;
      RX_D[2:1] <= RX_D[1:0];
    end
	 
  end

  assign IN_RX = RX_D[2] & RX_D[1] &  ~RX_D[0];
  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      COM_SEQ_STS <= 1'b0;
    end
	 else begin
      if(COM_SEQ_CLR) begin
        COM_SEQ_STS <= 1'b0;
      end
      else if(IN_RX) begin
        COM_SEQ_STS <= 1'b1;
      end
    end
	
  end

  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      COM_SEQ_STS1 <= 1'b0;
    end
	 else begin
      if(COM_SEQ_CLR1) begin
        COM_SEQ_STS1 <= 1'b0;
      end
      else if(IN_RX) begin
        COM_SEQ_STS1 <= 1'b1;
      end
    end
	 
  end

  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      COM_SEQ_CLK_CNT <= {12{1'b0}};
      COM_SEQ_CLK <= 1'b0;
    end
	 else begin
      if(COM_SEQ_STS1) begin
        if((COM_SEQ_CLK_CNT[11:0] == 12'h0AD)) begin
          //115200bps 20MHz 868(D) 0AD(H)
          COM_SEQ_CLK_CNT <= {12{1'b0}};
          COM_SEQ_CLK <= 1'b 0;
        end
        else if((COM_SEQ_CLK_CNT[11:0] == 12'h056)) begin
          COM_SEQ_CLK_CNT <= COM_SEQ_CLK_CNT + 1'b1;
          COM_SEQ_CLK <= 1'b1;
        end
        else begin
          COM_SEQ_CLK_CNT <= COM_SEQ_CLK_CNT + 1'b1;
          COM_SEQ_CLK <= 1'b0;
        end
      end
      else begin
        COM_SEQ_CLK_CNT <= {12{1'b0}};
        COM_SEQ_CLK <= 1'b0;
      end
    end
	 
  end

  //-- TIMER for RX TIME OUT 
  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      COM_SEQ_TIME_OUT <= {8{1'b0}};
      COM_SEQ_TIME_OUT_SIG <= 1'b0;
    end 
	 else begin
      if(COM_SEQ_STS) begin
        if(SEC_SIG) begin
          if(COM_SEQ_CLR1) begin
            COM_SEQ_TIME_OUT <= {8{1'b0}};
            COM_SEQ_TIME_OUT_SIG <= 1'b0;
          end
          else if((COM_SEQ_TIME_OUT == 8'h03)) begin
            //4sec
            COM_SEQ_TIME_OUT_SIG <= 1'b1;
          end
          else begin
            COM_SEQ_TIME_OUT <= COM_SEQ_TIME_OUT + 1'b1;
            COM_SEQ_TIME_OUT_SIG <= 1'b0;
          end
        end
        else begin
          COM_SEQ_TIME_OUT_SIG <= 1'b0;
        end
      end
      else begin
        COM_SEQ_TIME_OUT <= {8{1'b0}};
        COM_SEQ_TIME_OUT_SIG <= 1'b0;
      end
    end
	 
  end

  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      COM_DATA <= {8{1'b0}};
    end 
	 else begin
      if(COM_SEQ_STS1) begin
        if(COM_SEQ_CLK) begin
          COM_DATA <= {IN_USB_RX,COM_DATA[7:1]};
        end
      end
    end
	 
  end

  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      COM_SEQ_ID <= {4{1'b0}};
      CMD_COUNT <= {2{1'b0}};
      COM_SEQ_CLR <= 1'b0;
      COM_SEQ_CLR1 <= 1'b0;
      CMD_CLK_UP2 <= 1'b0;
      CMD_EXE_SIG <= 1'b0;
    end 
	 else begin
      if(COM_SEQ_STS) begin
        if(COM_SEQ_CLK) begin
          if((COM_SEQ_ID == 4'h9)) begin
            COM_SEQ_ID <= {4{1'b0}};
            COM_SEQ_CLR1 <= 1'b1;
            if((CMD_COUNT == 2'b11)) begin
              CMD_EXE_SIG <= 1'b1;
              COM_SEQ_CLR <= 1'b1;
            end
            else begin
              CMD_COUNT <= CMD_COUNT + 1'b 1;
            end
          end
          else if((COM_SEQ_ID == 4'h8)) begin
            CMD_CLK_UP2 <= 1'b1;
            COM_SEQ_ID <= COM_SEQ_ID + 1'b1;
          end
          else begin
            COM_SEQ_ID <= COM_SEQ_ID + 1'b1;
          end
        end
        else if((COM_SEQ_TIME_OUT_SIG == 1'b1)) begin
          COM_SEQ_CLR <= 1'b1;
          COM_SEQ_CLR1 <= 1'b1;
        end
        else begin
          CMD_CLK_UP2 <= 1'b0;
          COM_SEQ_CLR <= 1'b0;
          COM_SEQ_CLR1 <= 1'b0;
          CMD_EXE_SIG <= 1'b0;
        end
      end
      else begin
        COM_SEQ_ID <= {4{1'b0}};
        CMD_COUNT <= {2{1'b0}};
        COM_SEQ_CLR <= 1'b0;
        COM_SEQ_CLR1 <= 1'b0;
        CMD_CLK_UP2 <= 1'b0;
        CMD_EXE_SIG <= 1'b0;
      end
    end
	 
  end

  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      IN_CMD_DAT1 <= {8{1'b0}};
      IN_CMD_DAT2 <= {8{1'b0}};
      IN_CMD_DAT3 <= {8{1'b0}};
      IN_CMD_DAT4 <= {8{1'b0}};
    end 
	 else begin
      if(CMD_CLK_UP2) begin
        case(CMD_COUNT)
        2'b00 : IN_CMD_DAT1 <= COM_DATA;
        2'b01 : IN_CMD_DAT2 <= COM_DATA;
        2'b10 : IN_CMD_DAT3 <= COM_DATA;
        2'b11 : IN_CMD_DAT4 <= COM_DATA;
        default : begin
        end
        endcase
      end
    end
	 
  end

  always @(negedge RESET or posedge CLK) begin
    if(~RESET) begin
      IN_CMD_AD_CTRL <= 4'b0000;
      IN_CMD_CAL <= 1'b1;
      IN_CMD_DISC <= 8'h30;
      IN_SET_DAC <= 1'b0;
      IN_SET_ADC_INI <= 1'b0;
      IN_CMD_AD_FREQ <= 4'h0;
    end 
	 else begin
      if(CMD_EXE_SIG) begin
        if((IN_CMD_DAT1[7:0] == 8'h55)) begin
		    case (IN_CMD_DAT2)
			 8'h30 : IN_CMD_AD_CTRL[3:0] <= IN_CMD_DAT3[3:0];
			 8'h31 : begin
			           IN_CMD_DISC <= IN_CMD_DAT3[7:0];
						  IN_SET_DAC  <= 1'b1;
						end
			 8'h32 : IN_CMD_CAL <= IN_CMD_DAT3[0];
			 8'h33 : IN_SET_ADC_INI <= 1'b1;
			 8'h34 : IN_CMD_AD_FREQ <= IN_CMD_DAT3[3:0];
			 default : begin 
			           IN_SET_DAC <= 1'b0;
						  IN_SET_ADC_INI <= 1'b0;
						end
			 endcase
		  end
      end
      else begin
        IN_SET_DAC <= 1'b0;
        IN_SET_ADC_INI <= 1'b0;
      end
    end
	 
  end


endmodule
