library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity tb_system is
    -- Testbench does not have ports
end tb_system;

architecture behavior of tb_system is
    -- Signals to connect to the DUT (Device Under Test)
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal slide_sw    : std_logic_vector(3 downto 0) := "0000";
    signal btns        : std_logic_vector(3 downto 0) := "0000";
    signal ssd_segments: std_logic_vector(7 downto 0);
    signal ssd_digit   : std_logic_vector(3 downto 0);
    signal lock        : std_logic;
    signal unlock      : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.system
        port map (
            clk         => clk,
            reset       => reset,
            slide_sw    => slide_sw,
            btns        => btns,
            ssd_segments => ssd_segments,
            ssd_digit   => ssd_digit,
            lock        => lock,
            unlock      => unlock
        );

begin
    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize inputs
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';

        -- Apply test vectors
        slide_sw <= "0001"; -- Example value
        btns <= "0001";     -- Apply push button 1
        wait for clk_period * 2;

        btns <= "0010";     -- Apply push button 2
        wait for clk_period * 2;

        btns <= "0100";     -- Apply push button 3
        wait for clk_period * 2;

        btns <= "1000";     -- Apply push button 4
        wait for clk_period * 2;

        -- Finish simulation
        wait;
    end process;
end behavior;
