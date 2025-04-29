library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port (
        A : in STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Input A
        B : in STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit Input B
        S0 : in STD_LOGIC;  -- MUX select line 0
        S1 : in STD_LOGIC;  -- MUX select line 1
        Z : out STD_LOGIC_VECTOR(3 downto 0)  -- 4-bit MUX output
    );
end MUX;

architecture Behavioral of MUX is
begin
    process(S0, S1, A, B)
    begin
        if (S1 = '0' and S0 = '0') then
            Z <= A;  -- Output A when select line is 00
        elsif (S1 = '0' and S0 = '1') then
            Z <= B;  -- Output B when select line is 01
        else
            Z <= (others => '0');  -- Default case, handle other scenarios
        end if;
    end process;
end Behavioral;
