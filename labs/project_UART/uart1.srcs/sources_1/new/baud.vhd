-- This block uses code from clock_enable as a pulse generator for other blocks (RX/TX).
-- It sends out a pulse every //baud_gen// clock pulses. 

-- Example: baud_gen = 4800 ? p_clk_enable rises sig_cnt every cycle until sig_cnt >= baud_gen - 1
-- Then it sends out a pulse that is one clock long and resets sig_cnt to 0. 
-- That output pulse is fed into RX/TX blocks and tells those blocks to receive/transmit.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; -- Package for arithmetic operations
library fphdl;
use fphdl.float_pkg_c.all;

entity baud is

    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           baud_sw : in STD_LOGIC_VECTOR(2 downto 0);
           clk_baud : out STD_LOGIC --Output baud clock for RX/TX, using code from clock_enable
           );
end baud;

architecture behavioral of baud is
   --Local signal for storing baud rate
  signal baud_gen : integer;
   -- Local counter
  signal sig_cnt : natural;
  
begin

    baud_solve : process(baud_sw) is
    begin
        case baud_sw is
            when "000" =>
                baud_gen <= 4800;
            when "001" =>
                baud_gen <= 9600;
            when "010" =>
                baud_gen <= 14400;
            when "011" =>
                baud_gen <= 19200;
            when "100" =>
                baud_gen <= 28800;
            when "101" =>
                baud_gen <= 38400;
            when "110" =>
                baud_gen <= 57600;
            when "111" =>
                baud_gen <= 115200;
            when others =>
                baud_gen <= 4800;            
            end case;
     end process baud_solve;
        
  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal. By default, enable signal
  -- is low and generated pulse is always one clock long.
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while true loop -- 40 periods of 100MHz clock

      clk_baud <= '0';
      wait for (1/baud_gen) / 2;
      clk_baud <= '1';
      wait for (1/baud_gen) / 2;

    end loop;
    wait;

  end process p_clk_gen;
  
end Behavioral;
