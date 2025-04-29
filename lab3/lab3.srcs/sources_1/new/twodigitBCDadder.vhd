library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity twodigitBCDadder is
    port(
        A : in  unsigned(7 downto 0);  -- Two-digit BCD input A (8 bits)
        B : in  unsigned(7 downto 0);  -- Two-digit BCD input B (8 bits)
        carry_in : in  std_logic;      -- Carry input
        sum : out unsigned(7 downto 0);-- Two-digit BCD sum output (8 bits)
        carry_out : out std_logic      -- Final carry output
    );
end twodigitBCDadder;

architecture Behavioral of twodigitBCDadder is

    signal sum1, sum2 : unsigned(3 downto 0); -- Intermediate sum outputs
    signal carry_intermediate : std_logic;    -- Intermediate carry output

begin

    -- Instantiate onedigitBCDadder for the least significant digit
    adder_LSB: entity work.onedigitBCDadder
        port map(
            A1 => A(3 downto 0),  -- Least significant digit of A
            A2 => B(3 downto 0),  -- Least significant digit of B
            B1 => (others => '0'),-- Not used in this case
            B2 => (others => '0'),-- Not used in this case
            carry_in => carry_in, -- Input carry
            sum1 => sum(3 downto 0), -- Output for LSB sum
            sum2 => sum1,           -- Dummy connection
            carry_out_final => carry_intermediate -- Intermediate carry
        );

    -- Instantiate onedigitBCDadder for the most significant digit
    adder_MSB: entity work.onedigitBCDadder
        port map(
            A1 => A(7 downto 4),  -- Most significant digit of A
            A2 => B(7 downto 4),  -- Most significant digit of B
            B1 => (others => '0'),-- Not used in this case
            B2 => (others => '0'),-- Not used in this case
            carry_in => carry_intermediate, -- Carry from LSB addition
            sum1 => sum(7 downto 4), -- Output for MSB sum
            sum2 => sum2,            -- Dummy connection
            carry_out_final => carry_out -- Final carry output
        );

end Behavioral;
