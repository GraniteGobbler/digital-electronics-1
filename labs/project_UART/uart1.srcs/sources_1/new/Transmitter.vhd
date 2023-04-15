--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

entity Transmitter is
    Port ( Txd_in : in STD_LOGIC_VECTOR (7 downto 0);
           par_bit : in STD_LOGIC;
           clk_baud : in STD_LOGIC;
           Tx : out STD_LOGIC_VECTOR (7 downto 0);
           par_error : out STD_LOGIC);

end Transmitter;


architecture Behavioral of Transmitter is

begin


end Behavioral;
