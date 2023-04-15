----------------------------------------------------------
--
-- Template for 4-digit 7-segment display driver testbench.
-- Nexys A7-50T, xc7a50ticsg324-1L
-- TerosHDL, Vivado v2020.2, EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for testbench
----------------------------------------------------------

entity tb_baud is
  -- Entity of testbench is always empty
end entity tb_baud;

----------------------------------------------------------
-- Architecture body for testbench
----------------------------------------------------------

architecture testbench of tb_baud is

  -- Testbench local constants
  constant c_CLK_100MHZ_PERIOD : time := 10 ns;

  -- Testench local signals
  signal sig_clk_100mhz : std_logic;
  signal sig_rst        : std_logic;
  signal sig_baud_sw    : STD_LOGIC_VECTOR(2 downto 0);
  signal sig_clk_baud   : STD_LOGIC;

begin

  -- Connecting testbench signals with driver_7seg_4digits
  -- entity (Unit Under Test)
  uut_baud : entity work.baud
    port map (
      clk     => sig_clk_100mhz,
      rst     => sig_rst,
      baud_sw => sig_baud_sw,
      clk_baud => sig_clk_baud
    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 1000000 ns loop -- 40 periods of 100MHz clock

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;
    wait;

  end process p_clk_gen;

  --------------------------------------------------------
  -- Reset generation process
  --------------------------------------------------------
  p_reset_gen : process is
  begin

    sig_rst <= '0'; wait for 2 ns;
    sig_rst <= '1'; wait for 20 ns;
    sig_rst <= '0';

    wait;

  end process p_reset_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    report "Stimulus process started";

    sig_baud_sw   <= "111"; wait for 500us;
    sig_baud_sw   <= "100";
        
    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;
