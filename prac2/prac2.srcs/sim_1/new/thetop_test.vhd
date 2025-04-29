library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity thetop_test is
end thetop_test;

architecture Behavioral of thetop_test is
    component thetop
        port(
            d_in : in std_logic_vector(15 downto 0);
            clk_in : in std_logic;
            clk_en_in : in std_logic_vector(3 downto 0);
            q_out : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Signals to connect to the top-level ports
    signal d_in_tb : std_logic_vector(15 downto 0) := (others => '0');
    signal clk_in_tb : std_logic := '0';
    signal clk_en_in_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal q_out_tb : std_logic_vector(15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;
begin
    -- Instantiate the top-level entity
    uut: thetop
        port map (
            d_in => d_in_tb,
            clk_in => clk_in_tb,
            clk_en_in => clk_en_in_tb,
            q_out => q_out_tb
        );

    -- Clock generation process
    clk_process : process
    begin
        while True loop
            clk_in_tb <= '0';
            wait for clk_period / 2;
            clk_in_tb <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process to test the design
    stim_process : process
    begin
        -- Test case 1: Load register 0
        d_in_tb(3 downto 0) <= "0001";  -- Set lower 4 bits of d_in_tb for reg0
        clk_en_in_tb <= "0001";  -- Enable reg0 only
        wait for clk_period;

        -- Test case 2: Load register 1
        d_in_tb(7 downto 4) <= "0010";  -- Set bits [7:4] of d_in_tb for reg1
        clk_en_in_tb <= "0010";  -- Enable reg1 only
        wait for clk_period;

        -- Test case 3: Load register 2
        d_in_tb(11 downto 8) <= "0011";  -- Set bits [11:8] of d_in_tb for reg2
        clk_en_in_tb <= "0100";  -- Enable reg2 only
        wait for clk_period;

        -- Test case 4: Load register 3
        d_in_tb(15 downto 12) <= "0100";  -- Set bits [15:12] of d_in_tb for reg3
        clk_en_in_tb <= "1000";  -- Enable reg3 only
        wait for clk_period;

        -- Test case 5: Check that all registers hold their values
        clk_en_in_tb <= "0000";  -- Disable all registers
        wait for clk_period;

        -- End the simulation
        wait;
    end process;

end Behavioral;
