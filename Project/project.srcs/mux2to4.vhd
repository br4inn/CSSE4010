library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1_4 is
    Port (
        sel : in  std_logic;                     
        D0  : in  std_logic_vector(3 downto 0);  --1 BCD digit 
        D1  : in  std_logic_vector(3 downto 0);  -- 2nd BCD digit 
        Y   : out std_logic_vector(3 downto 0)   -- Out
    );
end Mux2to1_4;

architecture Behavioral of Mux2to1_4 is
begin
    process(sel, D0, D1)
    begin
        if sel = '0' then
            Y <= D0;
        else
            Y <= D1;
        end if;
    end process;
end Behavioral;
