library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Receiver is
    Port ( clk_baud : in STD_LOGIC; 
           rst : in STD_LOGIC;
           Rx : in STD_LOGIC_VECTOR (8 downto 0); -- Data input packet
           par_error : in STD_LOGIC;
           Rx_out : out STD_LOGIC_VECTOR (7 downto 0);
           par_bit : out STD_LOGIC
           );
end Receiver;


architecture Behavioral of Receiver is

signal par_buffer : std_logic_vector(2 downto 0);
signal Rx_buffer : STD_LOGIC_VECTOR(8 downto 0);
--signal i_cnt : natural:= 0; -- internal loop counter vaiable

begin
    rx_reset : process (clk_baud) is
    begin
        
        if (rising_edge(clk_baud)) then
          if (rst = '1') then
            Rx_out <= "00000000";
            Rx_buffer <= "000000000";
            par_bit <= '0';
            par_buffer <= "000";
          end if;
        end if;
        
    end process rx_reset;


--    data_read : process (clk_baud) is
--    begin
--        if (falling_edge(Rx(8))) then
--            if (rising_edge(clk_baud)) then
--                Rx_buffer <= Rx;
--                --Rx_out <= Rx(7 downto 0);
--            end if;
--            Rx_out <= Rx_buffer(7 downto 0);
--            Rx_buffer <= "000000000";    
--        end if;     

--    end process data_read;
    
    
    parity_look : process (clk_baud) is
    begin
        par_bit <= '0';
        for bit in Rx_buffer(0) to Rx_buffer(7) loop
            if (bit = '1') then
                par_buffer <= par_buffer + 1;
            end if;
            par_bit <= par_buffer(0);
         end loop;
        
    end process parity_look;

end Behavioral;
