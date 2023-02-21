------------------------------------------------------------
--
-- Example of 3-bit 4:1 mux
-- 
-- EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for 3-bit 4:1 mux
------------------------------------------------------------
entity mux is
    port(
        a           : in  std_logic_vector(2 downto 0);
        b           : in  std_logic_vector(2 downto 0);
        c           : in  std_logic_vector(2 downto 0);
        d           : in  std_logic_vector(2 downto 0);
        sel         : in  std_logic_vector(1 downto 0); --Selector input
        
        f           : out std_logic_vector(2 downto 0) --Mux output
    );
end entity mux;

------------------------------------------------------------
-- Architecture body for 3-bit 4:1 mux
------------------------------------------------------------
architecture Behavioral of mux is
begin
    f <= a when sel = "00" else
         b when sel = "01" else
         c when sel = "10" else
         d;

end architecture Behavioral;
