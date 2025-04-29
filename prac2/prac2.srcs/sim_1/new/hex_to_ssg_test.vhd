library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_hex_to_ssd is
end tb_hex_to_ssd;

architecture Behavioral of tb_hex_to_ssd is

    -- Component declaration of the Unit Under Test (UUT)
    component hex_to_ssd
        Port ( hex_in : in STD_LOGIC_VECTOR(3 downto 0);
               ssd_cathode_out : out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    -- Testbench signals
    signal hex_in_tb : std_logic_vector(3 downto 0) := "0000";
    signal ssd_cathode_out_tb : std_logic_vector(7 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: hex_to_ssd
        port map (
            hex_in => hex_in_tb,
            ssd_cathode_out => ssd_cathode_out_tb
        );

    -- Test stimulus process
    stimulus: process
    begin
        -- Apply each hex input and check the output
        
        hex_in_tb <= "0000";  -- 0
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1100_0000")
        report "Test failed for input 0" severity error;

        hex_in_tb <= "0001";  -- 1
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1111_1001")
        report "Test failed for input 1" severity error;

        hex_in_tb <= "0010";  -- 2
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1010_0100")
        report "Test failed for input 2" severity error;

        hex_in_tb <= "0011";  -- 3
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1011_0000")
        report "Test failed for input 3" severity error;

        hex_in_tb <= "0100";  -- 4
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1001_1001")
        report "Test failed for input 4" severity error;

        hex_in_tb <= "0101";  -- 5
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1001_0010")
        report "Test failed for input 5" severity error;

        hex_in_tb <= "0110";  -- 6
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1000_0010")
        report "Test failed for input 6" severity error;

        hex_in_tb <= "0111";  -- 7
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1111_1000")
        report "Test failed for input 7" severity error;

        hex_in_tb <= "1000";  -- 8
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1000_0000")
        report "Test failed for input 8" severity error;

        hex_in_tb <= "1001";  -- 9
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1001_1000")
        report "Test failed for input 9" severity error;

        hex_in_tb <= "1110";  -- E
        wait for 10 ns;
        assert (ssd_cathode_out_tb = B"1000_0110")
        report "Test failed for input E" severity error;

        -- Test complete, end simulation
        wait;
    end process;

end Behavioral;
