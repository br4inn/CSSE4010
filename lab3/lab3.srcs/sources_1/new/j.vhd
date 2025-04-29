library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity twodigitBCDadderandsubtract is
    port(
        A1, B1, A2, B2  : in  unsigned(3 downto 0);  -- BCD inputs
        carry_in        : in  std_logic;             -- Initial carry-in
        sub             : in  std_logic;             -- 0 for add, 1 for subtract
        sum1, sum2      : out unsigned(3 downto 0);  -- BCD outputs
        carry_out_final : out std_logic              -- Final carry-out
    );
end twodigitBCDadderandsubtract;

architecture Behavioral of twodigitBCDadderandsubtract is

    signal carry_intermediate : std_logic;  -- Intermediate carry

begin

    -- Instantiate first 1-digit BCD adder/subtractor
    bcd_adder1: entity work.onedigitaddandsubtract
        port map(
            A        => A1,
            B        => B1,
            carry_in => carry_in,
            sub      => sub,
            sum      => sum1,
            carry_out => carry_intermediate
        );

    -- Instantiate second 1-digit BCD adder/subtractor
    bcd_adder2: entity work.onedigitaddandsubtract
        port map(
            A        => A2,
            B        => B2,
            carry_in => carry_intermediate,
            sub      => sub,
            sum      => sum2,
            carry_out => carry_out_final
        );

end Behavioral;
