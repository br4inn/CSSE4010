library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Subtractor8 is
    Port (
        A : in  std_logic_vector(7 downto 0);
        B : in  std_logic_vector(7 downto 0);
        Y : out std_logic_vector(7 downto 0)
    );
end Subtractor8;

architecture Behavioral of Subtractor8 is
begin
    Y <= std_logic_vector(unsigned(A) - unsigned(B));
end Behavioral;
