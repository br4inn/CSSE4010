library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux is
    Port (
        decoder_select: in  STD_LOGIC_VECTOR (1 downto 0); -- 2-bit select input
        decoder_in  : in  STD_LOGIC_VECTOR (1 downto 0);                   -- Enable input    
        decoder_out   : out STD_LOGIC_VECTOR (3 downto 0)  -- 4 output lines (active low)
    );
end demux;

architecture Behavioral of demux is
begin
    process(decoder_select, decoder_in)
    begin
--        if decoder_in = '1' then  -- Enable is active high
--            decoder_out <= "1111";  -- All outputs are high (inactive) when enable is not asserted
--        else
            case decoder_select is
                when "00" => decoder_out <= "1110"; -- Output 0 is selected (active low)
                when "01" => decoder_out <= "1101"; -- Output 1 is selected (active low)
                when "10" => decoder_out <= "1011"; -- Output 2 is selected (active low)
                when "11" => decoder_out <= "0111"; -- Output 3 is selected (active low)
                when others => decoder_out <= "1111"; -- Default case (all inactive)
            end case;
--        end if;
    end process;
end Behavioral;

