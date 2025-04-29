library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (
        clk : in std_logic;                           -- System clock input
        reset : in std_logic;                         -- Reset signal
        switches : in std_logic_vector(15 downto 0);  -- 16 slide switches
        an : out std_logic_vector(2 downto 0);        -- Anode control for 3 seven-segment displays
        cathode : out std_logic_vector(7 downto 0)    -- Cathode control for seven-segment display
    );
end top_level;

architecture Behavioral of top_level is

    -- Signal declarations
    signal A, B : unsigned(7 downto 0);           -- BCD inputs from switches
    signal BCD_sum : unsigned(11 downto 0);       -- 3-digit BCD sum (12 bits)
    signal carry_out : std_logic;                 -- Carry output from BCD addition
    signal clk_div : std_logic;                   -- Divided clock signal
    signal mux_sel : integer range 0 to 2;        -- Mux selector for display multiplexing
    signal hex_digit : std_logic_vector(3 downto 0); -- Current BCD digit for SSD
    signal decoded_digit : std_logic_vector(7 downto 0); -- Decoded digit for SSD
    signal COUNTER_OUT_VEC : std_logic_vector(1 downto 0); -- Counter output for demux

begin

    -- Map slide switches to BCD inputs
    A <= unsigned(switches(15 downto 8));  -- Most significant digit BCD input
    B <= unsigned(switches(7 downto 0));   -- Least significant digit BCD input

    -- Instantiate the 2-digit BCD adder
    bcd_adder: entity work.twodigitBCDadder
        port map(
            A => A,
            B => B,
            carry_in => '0',   -- Initial carry input is 0
            sum => BCD_sum(7 downto 0),
            carry_out => carry_out
        );

    -- Assign the carry out bit to the most significant digit of the sum
    BCD_sum(11 downto 8) <= "0000" & carry_out;  -- Corrected concatenation

    -- Instantiate the clock divider for display multiplexing
    clock_divider: entity work.Clock_Divider
        port map(
            clk => clk,
            reset => reset,
            clock_out => clk_div
        );

    -- Instantiate the counter to cycle through the 3 digits
    digit_counter: entity work.counter
        port map(
            clk_in => clk_div,
            q_out => mux_sel
        );

    -- Convert the counter output to a 2-bit vector for demux
    COUNTER_OUT_VEC <= std_logic_vector(to_unsigned(mux_sel, 2));

    -- Multiplexing between the 3 digits of the BCD sum
    MUX_inst: entity work.MUX
        port map(
            A => BCD_sum(3 downto 0),    -- Least significant digit
            B => BCD_sum(7 downto 4),    -- Middle digit
            C => BCD_sum(11 downto 8),   -- Most significant digit (carry digit)
            S0 => COUNTER_OUT_VEC(0),
            S1 => COUNTER_OUT_VEC(1),
            Z => hex_digit
        );

    -- Decode the current BCD digit to SSD segments
    hex_decoder: entity work.hex_to_ssd
        port map(
            hex_in => hex_digit,
            ssd_cathode_out => decoded_digit
        );

    -- Instantiate the demux to control the anode signals
    Decoder_Inst: entity work.demux
        port map(
            decoder_select => COUNTER_OUT_VEC,
            decoder_in => COUNTER_OUT_VEC,   -- Active high signal
            decoder_out => an
        );

    -- Assign the decoded digit to the cathode output
    cathode <= decoded_digit;

end Behavioral;
