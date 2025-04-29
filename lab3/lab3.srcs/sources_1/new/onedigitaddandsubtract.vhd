--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity onedigitaddandsubtract is
--  port(
--        A, B       : in  unsigned(3 downto 0); -- input numbers.
--        carry_in   : in  std_logic;
--        sub        : in  std_logic;            -- 0 for add, 1 for subtract
--        sum        : out unsigned(3 downto 0); 
--        carry_out  : out std_logic  
--    );
--end onedigitaddandsubtract;

--+architecture Behavioral of onedigitaddandsubtract is
--    signal B_comp : unsigned(3 downto 0); -- 10's complement of B
--    signal temp   : unsigned(4 downto 0);
--begin
--    -- Determine whether to add B or its 10's complement
--    B_comp <= (not B + 1) when sub = '1' else B;

--    process(A, B_comp)
--    begin
--        --  addition
--        temp <= ('0' & A) + ('0' & B_comp) + ("0000" & carry_in); 
        
--        if temp > 9 then
--            temp <= temp + 6; -- BCD correction
--            carry_out <= '1'; -- Set carry if result exceeds BCD range
--        else
--            carry_out <= '0';
--        end if;

--        sum <= temp(3 downto 0); -- Assign the lower 4 bits to the sum output
--    end process;    
--end Behavioral;
