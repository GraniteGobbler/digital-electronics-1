------------------------------------------------------------
--
-- Testbench for 2-bit binary comparator.
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
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_mux is
    -- Entity of testbench is always empty
end entity tb_mux;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_mux is

    -- Local signals
    signal s_a           : std_logic_vector(2 downto 0);
    signal s_b           : std_logic_vector(2 downto 0);
    signal s_c           : std_logic_vector(2 downto 0);
    signal s_d           : std_logic_vector(2 downto 0);
    signal s_sel         : std_logic_vector(1 downto 0);
    signal s_f           : std_logic_vector(2 downto 0);

begin
    -- Connecting testbench signals with comparator_2bit
    -- entity (Unit Under Test)
    uut_mux : entity work.mux
        port map(
            a   => s_a,
            b   => s_b,
            c   => s_c,
            d   => s_d,
            sel => s_sel,
            f   => s_f
        );

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the beginning of stimulus process
        report "Stimulus process started" severity note;

        -- First test case
        s_a     <= "000";
        s_b     <= "001";        
        s_c     <= "010";
        s_d     <= "011";
        s_sel   <= "00";      
        wait for 100 ns;
        -- Expected output
        assert (s_f = "000")
        -- If false, then report an error
        report "Input combination invalid FAILED" severity error;

		--Test case 2
		s_a     <= "000";
        s_b     <= "001";        
        s_c     <= "010";
        s_d     <= "011";
        s_sel   <= "01";      
        wait for 100 ns;
        -- Expected output
        assert (s_f = "001")
        -- If false, then report an error
        report "Input combination invalid FAILED" severity error;
        
        --Test case 3
        s_a     <= "000";
        s_b     <= "001";        
        s_c     <= "010";
        s_d     <= "011";
        s_sel   <= "10";      
        wait for 100 ns;
        -- Expected output
        assert (s_f = "010")
        -- If false, then report an error
        report "Input combination invalid FAILED" severity error; 
        
        --Test case 3
        s_a     <= "000";
        s_b     <= "001";        
        s_c     <= "010";
        s_d     <= "111";
        s_sel   <= "11";      
        wait for 100 ns;
        -- Expected output
        assert (s_f = "111")
        -- If false, then report an error
        report "Input combination invalid FAILED" severity error;
             
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
