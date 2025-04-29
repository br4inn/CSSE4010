
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_level is
end tb_top_level;

architecture behavior of tb_top_level is

    -- Component declaration for the Unit Under Test (UUT)
    component top_level
        Port (
            CLK        : in STD_LOGIC;
            RESET      : in STD_LOGIC;
            sw         : in STD_LOGIC_VECTOR(15 downto 0);
            BUTTON     : in STD_LOGIC;
            seg        : out STD_LOGIC_VECTOR(7 downto 0);
            an         : out STD_LOGIC_VECTOR(3 downto 0);
            cn         : out STD_LOGIC_VECTOR(3 downto 0);
            MUX_OUT    : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal CLK     : STD_LOGIC := '0';
    signal RESET   : STD_LOGIC := '0';
    signal sw      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal BUTTON  : STD_LOGIC := '0';
    signal seg     : STD_LOGIC_VECTOR(7 downto 0);
    signal an      : STD_LOGIC_VECTOR(3 downto 0);
    signal cn      : STD_LOGIC_VECTOR(3 downto 0);
    signal MUX_OUT : STD_LOGIC_VECTOR(1 downto 0);

    -- Clock period for 100 MHz
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: top_level
        Port map (
            CLK     => CLK,
            RESET   => RESET,
            sw      => sw,
            BUTTON  => BUTTON,
            seg     => seg,
            an      => an,
            cn      => cn,
            MUX_OUT => MUX_OUT
        );

    -- Clock generation process
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
        -- Apply reset and initialize input signals
        RESET <= '1';
        wait for 50 ns;  -- Wait for some time
        RESET <= '0';
        wait for 50 ns;

        -- Apply test patterns
          sw <= "1001010000000000";  -- Test another pattern
        BUTTON <= '1';
        wait for 50 ns;
        BUTTON <= '0';
        wait for 200 ns;

        -- Apply reset to check reset functionality
        RESET <= '1';
        wait for 50 ns;
        RESET <= '0';
        wait for 50 ns;

        --test overlap
        sw <= "0011001010010100";  -- Test another pattern
        BUTTON <= '1';
        wait for 50 ns;
        BUTTON <= '0';
        -- End the simulation
        wait;
    end process;

  

end behavior;
