library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Header_tb is
end Header_tb;

architecture Behavioral of Header_tb is

    -- Component Declaration
    component Header
        Port (
            CLK         : in std_logic;
            RESET       : in std_logic;
            BUTTON      : in std_logic_vector(3 downto 0);
            SW          : in std_logic_vector(3 downto 0);
            seg         : out std_logic_vector(7 downto 0);
            an          : out std_logic_vector(3 downto 0);
            MUX_OUT     : out std_logic_vector(3 downto 0);
            LED16       : out std_logic;
            LED1        : out std_logic;
 
            LED14       : out std_logic;
            LED15       : out std_logic
        );
    end component;

    -- Signals for the testbench
    signal CLK         : std_logic := '0';
    signal RESET       : std_logic := '0';
    signal BUTTON      : std_logic_vector(3 downto 0) := (others => '0');
    signal SW          : std_logic_vector(3 downto 0) := (others => '0');
    signal seg         : std_logic_vector(7 downto 0);
    signal an          : std_logic_vector(3 downto 0);
    signal MUX_OUT     : std_logic_vector(3 downto 0);
    signal LED16       : std_logic;
    signal LED14       : std_logic;
    signal LED15       : std_logic;

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Header
        Port map (
            CLK => CLK,
            RESET => RESET,
            BUTTON => BUTTON,
            SW => SW,
            seg => seg,
            an => an,
            MUX_OUT => MUX_OUT,
            LED16 => LED16,
 
   
            LED14 => LED14,
            LED15 => LED15
        );

    -- Clock process
    clk_process: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize
        RESET <= '1';
        wait for CLK_PERIOD * 2;
        RESET <= '0';
        wait for CLK_PERIOD * 2;
        
        -- Test Case 1: Default state
        SW <= (others => '0');
        BUTTON <= (others => '0');
        wait for CLK_PERIOD * 10;

        -- Test Case 2: Load student number (0110100101010111)
        -- Load REG0 (first 4 bits: 0111)
        SW <= "0111";
        BUTTON <= "0001";  -- Enable REG0
        wait for CLK_PERIOD * 10;

        -- Load REG1 (next 4 bits: 0101)
        SW <= "0101";
        BUTTON <= "0010";  -- Enable REG1
        wait for CLK_PERIOD * 10;

        -- Load REG2 (next 4 bits: 1001)
        SW <= "1001";
        BUTTON <= "0100";  -- Enable REG2
        wait for CLK_PERIOD * 10;

        -- Load REG3 (last 4 bits: 0110)
        SW <= "0110";
        BUTTON <= "1000";  -- Enable REG3
        wait for CLK_PERIOD * 10;

        -- Check unlock status
      
        assert (LED14 = '1' and LED15 = '0') report "Unlock functionality failed!" severity error;
        
        -- Test Case 3: Set SW to not match student number
        -- Load REG0 (first 4 bits: 0000)
        SW <= "0000";
        BUTTON <= "0001";  -- Enable REG0
        wait for CLK_PERIOD * 10;

        -- Load REG1 (next 4 bits: 0000)
        SW <= "0000";
        BUTTON <= "0010";  -- Enable REG1
        wait for CLK_PERIOD * 10;

        -- Load REG2 (next 4 bits: 0000)
        SW <= "0000";
        BUTTON <= "0100";  -- Enable REG2
        wait for CLK_PERIOD * 10;

        -- Load REG3 (last 4 bits: 0000)
        SW <= "0000";
        BUTTON <= "1000";  -- Enable REG3
        wait for CLK_PERIOD * 10;

        -- Check lock status
        assert (LED14 = '0' and LED15 = '1') report "Lock functionality failed!" severity error;
        
        -- Test Case 4: Reset functionality
        RESET <= '1';
        wait for CLK_PERIOD * 2;
        RESET <= '0';
        wait for CLK_PERIOD * 10;

        -- Finish simulation
        assert false report "Simulation complete." severity note;
        wait;
    end process;

end Behavioral;
