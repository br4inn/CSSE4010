library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux is
    Port (
        decoder_select: in  STD_LOGIC_VECTOR (1 downto 0);  
        decoder_in  : in  STD_LOGIC_VECTOR (1 downto 0);                       
        decoder_out   : out STD_LOGIC_VECTOR (3 downto 0)  
    );
end demux;

architecture Behavioral of demux is
begin
    process(decoder_select, decoder_in)
    begin 
            case decoder_select is
                when "00" => decoder_out <= "1110"; 
                when "01" => decoder_out <= "1101";  
                when "10" => decoder_out <= "1111";  
                when "11" => decoder_out <= "1111";  
                when others => decoder_out <= "1111"; 
            end case;

    end process;
end Behavioral;

