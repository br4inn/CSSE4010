--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity fourdigitBCDadder is
--    port(
--        A1, A2, B1, B2 : in  unsigned(3 downto 0);  -- BCD inputs for each digit
--        carry_in       : in  std_logic;             -- Initial carry-in
--        sum1, sum2, sum3, sum4 : out unsigned(3 downto 0);  -- BCD sum outputs
--        carry_out_final: out std_logic              -- Final carry-out
--    );
--end fourdigitBCDadder;

--architecture Behavioral of fourdigitBCDadder is

--    signal carry_intermediate1, carry_intermediate2, carry_intermediate3 : std_logic;

--begin

--    -- First BCD adder
--    bcd_adder1: entity work.onedigitBCDadder
--        port map(
--            A        => A1,
--            B        => B1,
--            carry_in => carry_in,
--            sum      => sum1,
--            carry_out => carry_intermediate1
--        );

--    -- Second BCD adder
--    bcd_adder2: entity work.onedigitBCDadder
--        port map(
--            A        => A2,
--            B        => B2,
--            carry_in => carry_intermediate1,
--            sum      => sum2,
--            carry_out => carry_intermediate2
--        );

--    -- Third BCD adder
--    bcd_adder3: entity work.onedigitBCDadder
--        port map(
--            A        => A3,
--            B        => B3,
--            carry_in => carry_intermediate2,
--            sum      => sum3,
--            carry_out => carry_intermediate3
--        );

--    -- Fourth BCD adder
--    bcd_adder4: entity work.onedigitBCDadder
--        port map(
--            A        => A4,
--            B        => B4,
--            carry_in => carry_intermediate3,
--            sum      => sum4,
--            carry_out => carry_out_final
--        );

--end Behavioral;
