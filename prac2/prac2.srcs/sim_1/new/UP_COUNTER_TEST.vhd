library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is
    signal clk_in_tb : std_logic := '0';
    signal q_out_tb : integer range 0 to 3;

     
    component counter is
        port (
            clk_in : in std_logic;
            q_out : out integer range 0 to 3
        );
    end component;
    constant clk_period : time := 10 ns;

begin
     
    uut: counter
        port map (
            clk_in => clk_in_tb,
            q_out => q_out_tb
        );

    clk_process : process
    begin
        while true loop
            clk_in_tb <= '0';
            wait for clk_period/2;
            clk_in_tb <= '1';
            wait for clk_period/2;
        end loop;
    end process;
    stim_proc: process
    begin
        -- Wait
        wait for 100 ns;

        -- Check output value
        assert (q_out_tb = 0) report "Test failed for q_out = 0" severity error;

        -- Wait for next clock cycles
        wait for clk_period;

        -- Check output 
        assert (q_out_tb = 1) report "Test failed for q_out = 1" severity error;

        -- Wait remaining clock cycles
        wait for 4 * clk_period;

        -- Final check (should be 5)
        assert (q_out_tb = 5) report "Test failed for q_out = 5" severity error;

        -- Stop the simulation
        wait;
    end process;

end Behavioral;
