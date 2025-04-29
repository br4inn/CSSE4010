library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity tb_Clock_Divider is
-- Testbench does not have ports
end tb_Clock_Divider;

architecture Behavioral of tb_Clock_Divider is

    -- Component declaration of the Unit Under Test (UUT)
    component Clock_Divider
        port (
            clk : in std_logic;
            reset : in std_logic;
            clock_out : inout std_logic
        );
    end component;

    -- Testbench signals
    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal clock_out_tb : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Clock_Divider
        port map (
            clk => clk_tb,
            reset => reset_tb,
            clock_out => clock_out_tb
        );

    -- Clock generation process
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Test stimulus process
    stimulus: process
    begin
        -- Apply reset
        reset_tb <= '1';
        wait for 20 ns;
        reset_tb <= '0';

        -- Allow the clock to run and observe the output
        wait for 900000 * clk_period; -- Wait to observe several clock_out toggles

        -- End simulation
        wait;
    end process;

end Behavioral;
