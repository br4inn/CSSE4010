library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_tb is
end demux_tb;

architecture Behavioral of demux_tb is

    -- Component declaration of the demux to be tested
    component demux
        Port (
            demux_select: in  STD_LOGIC_VECTOR (1 downto 0); -- 2-bit select input
            demux_in  : in  STD_LOGIC;                     -- Enable input
            demux_out   : out STD_LOGIC_VECTOR (3 downto 0)  -- 4 output lines (active low)
        );
    end component;

    -- Testbench signals
    signal demux_select_tb : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal demux_in_tb : STD_LOGIC := '1';
    signal demux_out_tb : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: demux
        Port map (
            demux_select => demux_select_tb,
            demux_in => demux_in_tb,
            demux_out => demux_out_tb
        );

    -- Stimulus process to apply test vectors
    stim_process : process
    begin
        -- Test case 1: Enable is high, all outputs should be inactive (1111)
        demux_in_tb <= '1';
        demux_select_tb <= "00";
        wait for 10 ns;
        
        -- Test case 2: Enable is low, select "00" (demux_out should be 1110)
        demux_in_tb <= '0';
        demux_select_tb <= "00";
        wait for 10 ns;
        
        -- Test case 3: Select "01" (demux_out should be 1101)
        demux_select_tb <= "01";
        wait for 10 ns;
        
        -- Test case 4: Select "10" (demux_out should be 1011)
        demux_select_tb <= "10";
        wait for 10 ns;
        
        -- Test case 5: Select "11" (demux_out should be 0111)
        demux_select_tb <= "11";
        wait for 10 ns;
        
        -- Test case 6: Enable is high again, all outputs should be inactive (1111)
        demux_in_tb <= '1';
        wait for 10 ns;

        -- End the simulation
        wait;
    end process;

end Behavioral;
