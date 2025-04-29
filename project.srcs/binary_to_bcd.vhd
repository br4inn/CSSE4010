library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Binary_to_BCD is
    Port (
        binary_in  : in  std_logic_vector(7 downto 0);
        bcd_out    : out std_logic_vector(7 downto 0)
    );
end Binary_to_BCD;

architecture Behavioral of Binary_to_BCD is
    signal bin : unsigned(7 downto 0);
    signal bcd : unsigned(7 downto 0);
    
begin

    process(binary_in)
    begin
        bin <= unsigned(binary_in);
        bcd <= (others => '0'); 
        bcd(3 downto 0) <= resize(bin mod 10, 4);
        bcd(7 downto 4) <= resize((bin / 10) mod 10, 4);
    end process;
    
    bcd_out <= std_logic_vector(bcd);
end Behavioral;
