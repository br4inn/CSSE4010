----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2024 17:31:30
-- Design Name: 
-- Module Name: reset_decoder - Behavioral
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
-- 8-to-4 decoder for controlling 4 SSDs  
entity demux is
    Port (
        decoder_select : in std_logic_vector(2 downto 0);  -- 3-bit counter for selecting among 8 digits
        decoder_out    : out std_logic_vector(3 downto 0)  -- Outputs to the 4 SSD anodes
    );
end demux;

architecture Behavioral of demux is
begin
    process(decoder_select)
    begin
        case decoder_select is
            -- First 4 digits (first cycle)
            when "000" => decoder_out <= "1110";   
            when "001" => decoder_out <= "1101";  
            when "010" => decoder_out <= "1011"; 
            when "011" => decoder_out <= "0111"; 
            
            -- Second 4 digits (second cycle)
            when "100" => decoder_out <= "1110"; 
            when "101" => decoder_out <= "1101"; 
            when "110" => decoder_out <= "1011";  
            when "111" => decoder_out <= "0111"; 
            
            when others => decoder_out <= "1111"; 
        end case;
    end process;

end Behavioral;
