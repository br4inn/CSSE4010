library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_register_example is
end tb_register_example;

architecture Behavioral of tb_register_example is

    -- Component declaration of the Unit Under Test (UUT)
    component register_example
        port(
            d_in : in std_logic_vector(3 downto 0);
            clk_in : in std_logic;
            clk_en_in : in std_logic;
            reset_in : in std_logic;
            q_out : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Testbench signals
    signal d_in_tb : std_logic_vector(3 downto 0) := "0000";
    signal clk_in_tb : std_logic := '0';
    signal clk_en_in_tb : std_logic := '0';
    signal reset_in_tb : std_logic := '0';
    signal q_out_tb : std_logic_vector(3 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: register_example
        port map (
            d_in => d_in_tb,
            clk_in => clk_in_tb,
            clk_en_in => clk_en_in_tb,
            reset_in => reset_in_tb,
            q_out => q_out_tb
        );

    -- Clock generation process
    clk_process :process
    begin
        clk_in_tb <= '0';
        wait for clk_period/2;
        clk_in_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Test stimulus process
    stimulus: process
    begin
        -- No reset applied initially

        -- Apply input data "1111" with clock enable
        d_in_tb <= "1111";
        clk_en_in_tb <= '1';
        wait for clk_period;

        -- Disable clock enable
        clk_en_in_tb <= '0';
        wait for clk_period;

        -- Wait for a few clock cycles to observe the output
        wait for 40 ns;

        -- Check the output
        assert (q_out_tb = "1111") 
        report "Test failed: Output q_out_tb is not 1111" severity error;

        -- Now apply reset to clear the register
        reset_in_tb <= '1';
        wait for clk_period;
        reset_in_tb <= '0';
        wait for clk_period;

        -- Check if the output is reset correctly
        assert (q_out_tb = "1110") 
        report "Test failed: Output q_out_tb did not reset correctly" severity error;

        -- Simulation end
        wait;
    end process;

end Behavioral;
