--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity BCD_Adder_Testbench is
--end BCD_Adder_Testbench;

--architecture Behavioral of BCD_Adder_Testbench is
--    -- Constants for test cases
--    constant A_val_1 : unsigned(3 downto 0) := "0001";  -- A = 1
--    constant B_val_1 : unsigned(3 downto 0) := "0001";  -- B = 1
--    constant C_in_1  : std_logic := '0';                 -- Carry-in = 0 (for addition)
    
--    constant A_val_2 : unsigned(3 downto 0) := "1001";  -- A = 9
--    constant B_val_2 : unsigned(3 downto 0) := "1001";  -- B = 9
--    constant C_in_2  : std_logic := '0';                 -- Carry-in = 0 (for addition)
    
--    constant A_val_3 : unsigned(3 downto 0) := "0101";  -- A = 5
--    constant B_val_3 : unsigned(3 downto 0) := "0101";  -- B = 5
--    constant C_in_3  : std_logic := '0';                 -- Carry-in = 0 (for addition)
    
--    -- Signals for the testbench
--    signal sum_1, sum_2, sum_3 : unsigned(3 downto 0);
--    signal carry_1, carry_2, carry_3 : std_logic;

--begin

--    -- Instantiate the Unit Under Test (UUT)
--    uut_1 : entity work.BCD_Adder_Subtractor
--        port map (
--            A => A_val_1,
--            B => B_val_1,
--            C_in => C_in_1,
--            sub => '0',  -- '0' for addition mode
--            sum => sum_1,
--            carry => carry_1
--        );
    
--    uut_2 : entity work.BCD_Adder_Subtractor
--        port map (
--            A => A_val_2,
--            B => B_val_2,
--            C_in => C_in_2,
--            sub => '0',  -- '0' for addition mode
--            sum => sum_2,
--            carry => carry_2
--        );
    
--    uut_3 : entity work.BCD_Adder_Subtractor
--        port map (
--            A => A_val_3,
--            B => B_val_3,
--            C_in => C_in_3,
--            sub => '0',  -- '0' for addition mode
--            sum => sum_3,
--            carry => carry_3
--        );

--    -- Simulation process
--    stimulus : process
--    begin
--        -- Case 1: A = 1, B = 1, C_in = 0 (Addition)
--        wait for 10 ns;
--        assert to_integer(sum_1) = 2
--            report "Error: Case 1 failed. Expected sum = 2, got sum = " & integer'image(to_integer(sum_1)));
--        assert carry_1 = '0'
--            report "Error: Case 1 failed. Expected carry_out = '0', got carry_out = " & std_logic'image(carry_1);
        
--        -- Case 2: A = 9, B = 9, C_in = 0 (Addition)
--        wait for 10 ns;
--        assert to_integer(sum_2) = 8
--            report "Error: Case 2 failed. Expected sum = 8, got sum = " & integer'image(to_integer(sum_2)));
--        assert carry_2 = '1'
--            report "Error: Case 2 failed. Expected carry_out = '1', got carry_out = " & std_logic'image(carry_2);
        
--        -- Case 3: A = 5, B = 5, C_in = 0 (Addition)
--        wait for 10 ns;
--        assert to_integer(sum_3) = 0
--            report "Error: Case 3 failed. Expected sum = 0, got sum = " & integer'image(to_integer(sum_3)));
--        assert carry_3 = '1'
--            report "Error: Case 3 failed. Expected carry_out = '1', got carry_out = " & std_logic'image(carry_3);

--        wait;
--    end process;

--end Behavioral;
