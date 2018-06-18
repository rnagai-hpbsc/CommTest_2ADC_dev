	component TestRO is
		port (
			clk_clk                          : in  std_logic                     := 'X';             -- clk
			fifo_0_in_writedata              : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			fifo_0_in_write                  : in  std_logic                     := 'X';             -- write
			fifo_0_in_waitrequest            : out std_logic;                                        -- waitrequest
			fifo_1_in_writedata              : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			fifo_1_in_write                  : in  std_logic                     := 'X';             -- write
			fifo_1_in_waitrequest            : out std_logic;                                        -- waitrequest
			pio_0_external_connection_export : out std_logic;                                        -- export
			reset_reset_n                    : in  std_logic                     := 'X'              -- reset_n
		);
	end component TestRO;

	u0 : component TestRO
		port map (
			clk_clk                          => CONNECTED_TO_clk_clk,                          --                       clk.clk
			fifo_0_in_writedata              => CONNECTED_TO_fifo_0_in_writedata,              --                 fifo_0_in.writedata
			fifo_0_in_write                  => CONNECTED_TO_fifo_0_in_write,                  --                          .write
			fifo_0_in_waitrequest            => CONNECTED_TO_fifo_0_in_waitrequest,            --                          .waitrequest
			fifo_1_in_writedata              => CONNECTED_TO_fifo_1_in_writedata,              --                 fifo_1_in.writedata
			fifo_1_in_write                  => CONNECTED_TO_fifo_1_in_write,                  --                          .write
			fifo_1_in_waitrequest            => CONNECTED_TO_fifo_1_in_waitrequest,            --                          .waitrequest
			pio_0_external_connection_export => CONNECTED_TO_pio_0_external_connection_export, -- pio_0_external_connection.export
			reset_reset_n                    => CONNECTED_TO_reset_reset_n                     --                     reset.reset_n
		);

