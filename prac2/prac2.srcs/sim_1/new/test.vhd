library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity top_level_tb is
end top_level_tb;

architecture sim of top_level_tb is

    -- Component declaration for the top level design
    component top_level is
        Port (
            CLK         : in std_logic; 
            RESET       : in std_logic;
            BUTTON      : in std_logic_vector(3 downto 0);
            SW          : in std_logic_vector(3 downto 0);
            seg         : out std_logic_vector(7 downto 0);
            an          : out std_logic_vector(3 downto 0);
            MUX_OUT     : out std_logic_vector(3 downto 0);
            MATCH       : out std_logic;
            LOCK_LED    : out std_logic
        );
    end component;

    -- Signals for connecting to the DUT (Device Under Test)
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
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the top level design
    uut: top_level
        Port map (
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
    clk_process :process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        -- Reset the system
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';

        -- Load the first digit '6'
        SW <= "0110";   -- SW set to 6
        BUTTON(0) <= '1';
        wait for CLK_PERIOD;
        BUTTON(0) <= '0';

        -- Load the second digit '9'
        SW <= "1001";   -- SW set to 9
        BUTTON(1) <= '1';
        wait for CLK_PERIOD;
        BUTTON(1) <= '0';

        -- Load the third digit '5'
        SW <= "0101";   -- SW set to 5
        BUTTON(2) <= '1';
        wait for CLK_PERIOD;
        BUTTON(2) <= '0';

        -- Load the fourth digit '7'
        SW <= "0111";   -- SW set to 7
        BUTTON(3) <= '1';
        wait for CLK_PERIOD;
        BUTTON(3) <= '0';

        -- Check MATCH and LOCK_LED signals
        wait for 100 ns;  -- Allow some time for processing

        -- Here, we expect the MATCH signal to be '1' (indicating a match)
        -- and LOCK_LED to be '0' (indicating that the lock is off).
        assert (MATCH = '1' and LOCK_LED = '0')
        report "Test failed: MATCH or LOCK_LED signal did not behave as expected."
        severity error;

        -- Test completed successfully
        report "Test passed: MATCH and LOCK_LED signals are as expected."
        severity note;

        wait;
    end process;

end sim;