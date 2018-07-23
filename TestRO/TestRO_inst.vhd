	component TestRO is
		port (
			bs1_export            : in  std_logic_vector(13 downto 0) := (others => 'X'); -- export
			clk_clk               : in  std_logic                     := 'X';             -- clk
			dacctrl_export        : out std_logic_vector(31 downto 0);                    -- export
			ext_rst_export        : out std_logic;                                        -- export
			exttrg_0_export       : out std_logic;                                        -- export
			fifo_0_in_writedata   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			fifo_0_in_write       : in  std_logic                     := 'X';             -- write
			fifo_0_in_waitrequest : out std_logic;                                        -- waitrequest
			fifo_1_in_writedata   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			fifo_1_in_write       : in  std_logic                     := 'X';             -- write
			fifo_1_in_waitrequest : out std_logic;                                        -- waitrequest
			reset_reset_n         : in  std_logic                     := 'X';             -- reset_n
			version_info_export   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			write_en_export       : out std_logic;                                        -- export
			bs2_export            : in  std_logic_vector(13 downto 0) := (others => 'X')  -- export
		);
	end component TestRO;

	u0 : component TestRO
		port map (
			bs1_export            => CONNECTED_TO_bs1_export,            --          bs1.export
			clk_clk               => CONNECTED_TO_clk_clk,               --          clk.clk
			dacctrl_export        => CONNECTED_TO_dacctrl_export,        --      dacctrl.export
			ext_rst_export        => CONNECTED_TO_ext_rst_export,        --      ext_rst.export
			exttrg_0_export       => CONNECTED_TO_exttrg_0_export,       --     exttrg_0.export
			fifo_0_in_writedata   => CONNECTED_TO_fifo_0_in_writedata,   --    fifo_0_in.writedata
			fifo_0_in_write       => CONNECTED_TO_fifo_0_in_write,       --             .write
			fifo_0_in_waitrequest => CONNECTED_TO_fifo_0_in_waitrequest, --             .waitrequest
			fifo_1_in_writedata   => CONNECTED_TO_fifo_1_in_writedata,   --    fifo_1_in.writedata
			fifo_1_in_write       => CONNECTED_TO_fifo_1_in_write,       --             .write
			fifo_1_in_waitrequest => CONNECTED_TO_fifo_1_in_waitrequest, --             .waitrequest
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --        reset.reset_n
			version_info_export   => CONNECTED_TO_version_info_export,   -- version_info.export
			write_en_export       => CONNECTED_TO_write_en_export,       --     write_en.export
			bs2_export            => CONNECTED_TO_bs2_export             --          bs2.export
		);

