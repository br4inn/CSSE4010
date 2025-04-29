library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity top_level_tb is
end top_level_tb;

architecture sim of top_level_tb is
    -- Signals to connect with the top-level entity
    signal CLK         : std_logic := '0';
    signal RESET       : std_logic := '0';
    signal BUTTON      : std_logic_vector(3 downto 0) := (others => '0');
    signal SW          : std_logic_vector(3 downto 0) := (others => '0');
    signal seg         : std_logic_vector(7 downto 0);
    signal an          : std_logic_vector(3 downto 0);
    signal MUX_OUT     : std_logic_vector(3 downto 0);
    signal MATCH       : std_logic;
    signal LOCK_LED    : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the top-level entity
    UUT: entity work.top_level
        port map (
            CLK         => CLK,
            RESET       => RESET,
            BUTTON      => BUTTON,
            SW          => SW,
            seg         => seg,
            an          => an,
            MUX_OUT     => MUX_OUT,
            MATCH       => MATCH,
            LOCK_LED    => LOCK_LED
        );

    -- Clock generation
    clk_process : process
    begin
        CLK <= '0';
        wait for clk_period / 2;
        CLK <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Load register values to match the student number "6957" (0110 1001 0101 0111)
        -- Loading REG0 (0111)
        SW <= "0111";  -- SW0-SW3 inputs
        BUTTON(0) <= '1';  -- Load REG0
        wait for 20 ns;
        BUTTON(0) <= '0';

        -- Loading REG1 (0101)
        SW <= "0101";  -- SW0-SW3 inputs
        BUTTON(1) <= '1';  -- Load REG1
        wait for 20 ns;
        BUTTON(1) <= '0';

        -- Loading REG2 (1001)
        SW <= "1001";  -- SW0-SW3 inputs
        BUTTON(2) <= '1';  -- Load REG2
        wait for 20 ns;
        BUTTON(2) <= '0';

        -- Loading REG3 (0110)
        SW <= "0110";  -- SW0-SW3 inputs
        BUTTON(3) <= '1';  -- Load REG3
        wait for 20 ns;
        BUTTON(3) <= '0';

        -- Wait for processing and observe outputs
        wait for 100 ns;

        -- Check MATCH signal (should be '1' for unlock)
        assert MATCH = '1' report "Unlock Failed!" severity error;

        -- Output seg for the corresponding HEX_OUT should be displayed on the seven-segment
        -- You can observe seg and an signals here to verify the seven-segment display output
        wait;

    end process;

end sim;
