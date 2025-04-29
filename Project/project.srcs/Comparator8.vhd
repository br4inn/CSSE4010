library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparator8 is
    Port (
        A     : in  std_logic_vector(7 downto 0);
        B     : in  std_logic_vector(7 downto 0);
        A_eq_B: out std_logic;
        A_gt_B: out std_logic;
        A_lt_B: out std_logic
    );
end Comparator8;

architecture Behavioral of Comparator8 is
begin
    A_eq_B <= '1' when A = B else '0';
    A_gt_B <= '1' when unsigned(A) > unsigned(B) else '0';
    A_lt_B <= '1' when unsigned(A) < unsigned(B) else '0';
end Behavioral;
