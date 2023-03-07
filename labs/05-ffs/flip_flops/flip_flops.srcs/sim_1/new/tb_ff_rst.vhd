library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_ff_rst is
  -- Entity of testbench is always empty
end entity tb_ff_rst;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_ff_rst is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal sig_clk_100MHz : std_logic;
    signal sig_rst        : std_logic;
    signal sig_data       : std_logic;
    signal sig_dq        : std_logic;
    signal sig_dq_bar    : std_logic;
    signal sig_tq        : std_logic;
    signal sig_tq_bar    : std_logic;
    
begin
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
    uut_d_ff_rst : entity work.d_ff_rst
        port map (
            clk   => sig_clk_100MHz,
            rst   => sig_rst,
            d     => sig_data,
            q     => sig_dq,
            q_bar => sig_dq_bar
        );

    uut_t_ff_rst : entity work.t_ff_rst
        port map (
            clk   => sig_clk_100MHz,
            rst   => sig_rst,
            t     => sig_data,
            q     => sig_tq,
            q_bar => sig_tq_bar
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
        sig_rst <= '0'; wait for 20 ns;
        sig_rst <= '1'; wait for 15 ns;
        sig_rst <= '0'; wait for 50 ns;
        sig_rst <= '1'; wait for 15 ns;
        sig_rst <= '0';

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