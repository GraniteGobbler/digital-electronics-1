library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_top is
  -- Entity of testbench is always empty
end entity tb_top;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_top is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal sig_clk_100MHz : std_logic;
    signal sig_BTNC       : std_logic;
    signal sig_data       : std_logic;
    signal sig_q          : std_logic_vector(3 downto 0);

    
begin
    -- Connecting testbench signals with top entity
    -- (Unit Under Test)
    uut_top : entity work.top
        port map (
            CLK100MHZ   => sig_clk_100MHz,
            BTNC        => sig_BTNC,
            SW(0)       => sig_data,
            LED(3)      => sig_q(3),
            LED(2)      => sig_q(2),
            LED(1)      => sig_q(1),
            LED(0)      => sig_q(0)
            
        );


    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 300 ns loop -- 30 periods of 100MHz clock
            sig_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            sig_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        sig_BTNC <= '0'; wait for 20 ns;
        sig_BTNC <= '1'; wait for 15 ns;
        sig_BTNC <= '0'; wait for 50 ns;
        sig_BTNC <= '1'; wait for 15 ns;
        sig_BTNC <= '0';

        -- ACTIVATE AND DEACTIVATE RESET HERE
        -- wait for XXX ns;
        -- sig_rst <= XXX;
        -- wait for XXX ns;
        -- sig_rst <= XXX;

        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started";
        -- DEFINE YOUR INPUT DATA HERE
        sig_data <='0'; wait for 10 ns;
        sig_data <='1'; wait for 15 ns;
        sig_data <='0'; wait for 5 ns;
        sig_data <='1'; wait for 10 ns;
        sig_data <='0'; wait for 10 ns;
        sig_data <='1'; wait for 20 ns;
        sig_data <='0'; wait for 20 ns;
        sig_data <='1'; wait for 10 ns;
        sig_data <='0'; wait for 10 ns;
        sig_data <='1'; wait for 15 ns;
        sig_data <='0'; wait for 5 ns;    
        

        report "Stimulus process finished";
        wait;
    end process p_stimulus;

end architecture testbench;