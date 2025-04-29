library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    port(
        A, B, C    : in std_logic_vector(3 downto 0);
--        C       : in std_logic;
        S0, S1  : in std_logic;
        Z        : out std_logic_vector(3 downto 0)
    );
end MUX;

architecture bhv of MUX is
begin
    process (A, B, C, S0, S1) is
    begin
        if (S0 = '0' and S1 = '0') then
            Z <= A;                   -- select input A based on select lines
        elsif (S0 = '1' and S1 = '0') then
            Z <= B;                   -- select input B
        elsif (S0 = '0' and S1 = '1') then
            Z <= C;                   -- select input C
        else
            Z <= (others => '0');    -- default case
        end if;
    end process;
end bhv;