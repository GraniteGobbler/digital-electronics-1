----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2023 01:16:41 PM
-- Design Name: 
-- Module Name: Nexys_FPGA - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Nexys_FPGA is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           par_bit_in : in STD_LOGIC;
           par_bit_out : out STD_LOGIC;
           par_error_out : out STD_LOGIC;
           par_error_in : in STD_LOGIC;
           start_bit : in STD_LOGIC;
           stop_bit : in STD_LOGIC;
           data_bits : in STD_LOGIC_VECTOR (7 downto 0));
end Nexys_FPGA;

architecture Behavioral of Nexys_FPGA is

begin


end Behavioral;
