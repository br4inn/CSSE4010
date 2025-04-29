    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
    
    entity tb_onedigitBCDadder is
    -- Testbench does not need ports
    end tb_onedigitBCDadder;
    
    architecture Behavioral of tb_onedigitBCDadder is
    
        -- Component declaration for the BCD adder
        component BCDadder is
            port(
                A, B       : in  unsigned(3 downto 0); -- input numbers.
                carry_in   : in  std_logic;
                sum        : out unsigned(3 downto 0); 
                carry_out  : out std_logic  
            );
        end component;
    
        -- Signals 
        signal A, B        : unsigned(3 downto 0);
        signal carry_in    : std_logic;
        signal sum         : unsigned(3 downto 0);
        signal carry_out   : std_logic;
    
    begin
    
        -- Instantiate the BCD adder component
        UUT: BCDadder
            port map(
                A        => A,
                B        => B,
                carry_in => carry_in,
                sum      => sum,
                carry_out => carry_out
            );
    
        -- Test process
        process
        begin
            -- Case 1: A + B <= 9
            A <= "0011"; -- 3
            B <= "0101"; -- 5
            carry_in <= '0';
            wait for 10 ns;
            assert (sum = "1000" and carry_out = '0')
                report "Test Case 1 Failed" severity error;
    
            -- Case 2: 9 < A + B <= 15
            A <= "1001"; -- 9
            B <= "0100"; -- 4
            carry_in <= '0';
            wait for 10 ns;
            assert (sum = "0011" and carry_out = '1')
                report "Test Case 2 Failed" severity error;
    
            -- Case 3: A + B > 15
            A <= "1001"; -- 9
            B <= "1001"; -- 9  
            carry_in <= '0';
            wait for 10 ns;
         
    
            -- Test completed
            wait;
        end process;
    
    end Behavioral;
