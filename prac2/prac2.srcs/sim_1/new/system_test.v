library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity system_test is
-- Testbench doesn't have ports
end system_test;

architecture behavior of system_test is
    -- Component Declaration for the Unit Under Test (UUT)
    component Header
        Port (
            CLK         : in std_logic; 
            RESET       : in std_logic;     
            BUTTON      : in std_logic_vector(3 downto 0);
            SW          : in std_logic_vector(3 downto 0);
            LED16       : out std_logic;
            LED1        : out std_logic;
            LED12       : out std_logic;
            LED13       : out std_logic;
            LED14       : out std_logic;
            LED15       : out std_logic
        );
    end component;

    -- Signals for connecting to UUT
    signal CLK         : std_logic := '0';
    signal RESET       : std_logic := '0';
    signal BUTTON      : std_logic_vector(3 downto 0) := (others => '0');
    signal SW          : std_logic_vector(3 downto 0) := (others => '0');
    signal LED16       : std_logic;
    signal LED1        : std_logic;
    signal LED12       : std_logic;
    signal LED13       : std_logic;
    signal LED14       : std_logic;
    signal LED15       : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Header
        Port map (
            CLK         => CLK,
            RESET       => RESET,
            BUTTON      => BUTTON,
            SW          => SW,
            LED16       => LED16,
            LED1        => LED1,
            LED12       => LED12,
            LED13       => LED13,
            LED14       => LED14,
            LED15       => LED15
        );

    -- Clock process
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
        -- Test case 1: Reset signal
        RESET <= '1';
        wait for clk_period;
        RESET <= '0';
        wait for clk_period;

        -- Test case 2: Set switches and buttons
        SW <= "1100";
        BUTTON <= "0001";
        wait for clk_period;

        -- Test case 3: Check outputs with various buttons
        BUTTON <= "0010";
        wait for clk_period;

        BUTTON <= "0100";
        wait for clk_period;

        BUTTON <= "1000";
        wait for clk_period;

        -- Test case 4: Turn off all buttons
        BUTTON <= "0000";
        wait for clk_period;

        -- Test case 5: Change switches
        SW <= "0011";
        wait for clk_period;

        -- Test case 6: Reset and check
        RESET <= '1';
        wait for clk_period;
        RESET <= '0';
        wait for clk_period;

        -- End simulation
        wait;
    end process;
end behavior;
