-- 2-to-1 Multiplexer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1_8 is
    Port (
        sel : in  std_logic;
        D0  : in  std_logic_vector(7 downto 0);
        D1  : in  std_logic_vector(7 downto 0);
        Y   : out std_logic_vector(7 downto 0)
    );
end Mux2to1_8;

architecture Behavioral of Mux2to1_8 is
begin
    Y <= D0 when sel = '0' else D1;
end Behavioral;
