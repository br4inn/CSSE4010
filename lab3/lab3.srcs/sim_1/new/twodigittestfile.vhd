library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_twodigitBCDadder is
    -- Testbench entity does not have any ports
end tb_twodigitBCDadder;

architecture behavior of tb_twodigitBCDadder is
    -- Component Declaration for the Unit Under Test (UUT)
    component twodigitBCDadder
        port(
            A1, B1, A2, B2 : in  unsigned(3 downto 0);
            carry_in       : in  std_logic;
            sum1, sum2     : out unsigned(3 downto 0);
            carry_out_final: out std_logic              -- Ensure std_logic type
        );
    end component;

    -- Inputs
    signal A1, B1, A2, B2 : unsigned(3 downto 0);
    signal carry_in       : std_logic;
    
    -- Outputs
    signal sum1, sum2     : unsigned(3 downto 0);
    signal carry_out_final: std_logic;

    -- Clock and Reset
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    
    -- Clock Period
    constant clk_period : time := 10 ns;
    
begin
    -- Clock Generation
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Instantiate the Unit Under Test (UUT)
    uut: twodigitBCDadder
        port map (
            A1 => A1,
            B1 => B1,
            A2 => A2,
            B2 => B2,
            carry_in => carry_in,
            sum1 => sum1,
            sum2 => sum2,
            carry_out_final => carry_out_final
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Test Case 1: No carry propagation
        A1 <= "0001";  -- 1 in decimal
        B1 <= "0010";  -- 2 in decimal
        A2 <= "0011";  -- 3 in decimal
        B2 <= "0100";  -- 4 in decimal
        carry_in <= '0';
        wait for 20 ns;  -- Wait for the result
        
        assert (sum1 = "0011" and sum2 = "0111" and carry_out_final = '0')
            report "Test Case 1 Failed: Expected sum1 = 3, sum2 = 7, carry_out_final = 0"
            severity error;
        
        -- Test Case 2: Carry propagation
        A1 <= "0100";  -- 4 in decimal
        B1 <= "0110";  -- 6 in decimal
        A2 <= "0100";  -- 4 in decimal
        B2 <= "0101";  -- 5 in decimal
        carry_in <= '0';
        wait for 20 ns;  -- Wait for the result
        
        assert (sum1 = "0000" and sum2 = "0001" and carry_out_final = '1')
            report "Test Case 2 Failed: Expected sum1 = 0, sum2 = 1, carry_out_final = 1"
            severity error;

        -- End of Test
        wait;
    end process;

end behavior;
