-- 8-bit Register with Enable
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register8 is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        en    : in  std_logic;
        D     : in  std_logic_vector(7 downto 0);
        Q     : out std_logic_vector(7 downto 0)
    );
end Register8;

architecture Behavioral of Register8 is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            Q <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
