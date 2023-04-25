library ieee;
  use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for testbench
----------------------------------------------------------

entity tb_receiver is
  -- Entity of testbench is always empty
end entity tb_receiver;

----------------------------------------------------------
-- Architecture body for testbench
----------------------------------------------------------

architecture testbench of tb_receiver is

  -- Testbench local constants
  constant c_CLK_100MHZ_PERIOD : time := 10 ns;
  constant c_CLK_BAUD          : time := 104 us;

  -- Testench local signals
  signal sig_clk_100mhz : std_logic;
  signal sig_clk_baud   : std_logic;
  signal sig_rst        : std_logic;
  signal sig_Rx         : std_logic_vector (8 downto 0);
  signal sig_Rx_out     : std_logic_vector (7 downto 0);
  signal sig_par_bit    : std_logic;


begin

  -- Connecting testbench signals with Receiver
  -- entity (Unit Under Test)
  uut_Receiver : entity work.Receiver
    port map (
      clk_baud     => sig_clk_baud,
      rst          => sig_rst,
      Rx           => sig_Rx,
      Rx_out       => sig_Rx_out,
      par_bit      => sig_par_bit,
      par_error    => '0'

    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 20 ms loop -- 40 periods of 100MHz clock

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;
    wait;

  end process p_clk_gen;
  
 --------------------------------------------------------
 -- Clock generation process
 --------------------------------------------------------
  p_baud_gen : process is
  begin

    while now < 20 ms loop

      sig_clk_baud <= '0';
      wait for c_CLK_BAUD / 2;
      sig_clk_baud <= '1';
      wait for c_CLK_BAUD / 2;

    end loop;
    wait;

  end process p_baud_gen;

  --------------------------------------------------------
  -- Reset generation process
  --------------------------------------------------------
  p_reset_gen : process is
  begin

    sig_rst <= '1'; wait for 5 ms;
    sig_rst <= '0';

    wait;

  end process p_reset_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    report "Stimulus process started";

    sig_Rx   <= "100000000"; wait for 6 ms;
    sig_Rx   <= "010101110"; wait for c_CLK_BAUD;
    sig_Rx   <= "100000000";
    
    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;
