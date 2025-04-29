library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lock_unlock_tb is
-- Testbench has no ports
end lock_unlock_tb;

architecture Behavioral of lock_unlock_tb is

    -- Component declaration for the Unit Under Test (UUT)
    component top_level
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

    -- Clock period definition
    constant clk_period : time := 10 ns;

    -- Signals to connect to UUT
    signal CLK         : std_logic := '0';
    signal RESET       : std_logic := '0';
    signal BUTTON      : std_logic_vector(3 downto 0) := (others => '0');
    signal SW          : std_logic_vector(3 downto 0) := (others => '0');
    signal seg         : std_logic_vector(7 downto 0);
    signal an          : std_logic_vector(3 downto 0);
    signal MUX_OUT     : std_logic_vector(3 downto 0);
    signal MATCH       : std_logic;
    signal LOCK_LED    : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
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

    -- Clock process
    clk_process :process
    begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin

        -- Apply reset
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Load correct student number "0110 1001 0101 0111" (6957)

        -- Load "0110" (6) into REG0
        SW <= "0110";
        BUTTON(0) <= '1';
        wait for clk_period;
        BUTTON(0) <= '0';
        wait for 40 ns;

        -- Load "1001" (9) into REG1
        SW <= "1001";
        BUTTON(1) <= '1';
        wait for clk_period;
        BUTTON(1) <= '0';
        wait for 40 ns;

        -- Load "0101" (5) into REG2
        SW <= "0101";
        BUTTON(2) <= '1';
        wait for clk_period;
        BUTTON(2) <= '0';
        wait for 40 ns;

        -- Load "0111" (7) into REG3
        SW <= "0111";
        BUTTON(3) <= '1';
        wait for clk_period;
        BUTTON(3) <= '0';
        wait for 40 ns;

        -- Wait for some time to observe the output
        wait for 100 ns;

        -- Check if MATCH is high and LOCK_LED is low (Unlocked)
        assert (MATCH = '1' and LOCK_LED = '0')
        report "Unlock Failed" severity error;

        -- Load an incorrect number "0000 0000 0000 0000"

        -- Load "0000" (0) into REG0
        SW <= "0000";
        BUTTON(0) <= '1';
        wait for clk_period;
        BUTTON(0) <= '0';
        wait for 40 ns;

        -- Load "0000" (0) into REG1
        SW <= "0000";
        BUTTON(1) <= '1';
        wait for clk_period;
        BUTTON(1) <= '0';
        wait for 40 ns;

        -- Load "0000" (0) into REG2
        SW <= "0000";
        BUTTON(2) <= '1';
        wait for clk_period;
        BUTTON(2) <= '0';
        wait for 40 ns;

        -- Load "0000" (0) into REG3
        SW <= "0000";
        BUTTON(3) <= '1';
        wait for clk_period;
        BUTTON(3) <= '0';
        wait for 40 ns;

        -- Wait for some time to observe the output
        wait for 100 ns;

        -- Check if MATCH is low and LOCK_LED is high (Locked)
        assert (MATCH = '0' and LOCK_LED = '1')
        report "Lock Failed" severity error;

        -- End simulation
        wait;

    end process;

end Behavioral;