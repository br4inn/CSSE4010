library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity onedigitBCDadder is
    port(
        A1, A2, B1, B2 : in  unsigned(3 downto 0);
        carry_in       : in  std_logic;
        sum1, sum2     : out unsigned(3 downto 0);
        carry_out_final: out std_logic
    );
end onedigitBCDadder;

architecture Behavioral of onedigitBCDadder is

    signal carry_intermediate : std_logic;

begin

    bcd_adder1: entity work.BCDadder
        port map(
            A        => A1,
            B        => B1,
            carry_in => carry_in,
            sum      => sum1,
            carry_out => carry_intermediate
        );

    bcd_adder2: entity work.BCDadder
        port map(
            A        => A2,
            B        => B2,
            carry_in => carry_intermediate,
            sum      => sum2,
            carry_out => carry_out_final
        );

end Behavioral;
