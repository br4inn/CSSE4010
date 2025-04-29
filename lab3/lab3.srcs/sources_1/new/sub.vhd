library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_Adder_Subtractor is
  port(
        A, B       : in  unsigned(3 downto 0); -- Input numbers (BCD digits)
        C_in       : in  std_logic;            -- Carry-in for addition/subtraction
        sub        : in  std_logic;            -- 0 for add, 1 for subtract
        sum        : out unsigned(3 downto 0); -- Output BCD digit
        carry      : out std_logic             -- Carry-out from the operation
    );
end BCD_Adder_Subtractor;

architecture Behavioral of BCD_Adder_Subtractor is
    signal B_comp : unsigned(3 downto 0); -- 10's complement of B
    signal temp   : unsigned(4 downto 0); -- Temporary signal for calculation
begin

    -- Determine whether to add B or its 10's complement
    B_comp <= (not B + 1) when sub = '1' else B;

    -- Process for addition/subtraction
    process(A, B_comp, C_in)
    begin
        temp <= ('0' & A) + ('0' & B_comp) + ("0000" & C_in); -- Perform addition/subtraction
        
        if sub = '1' then
            -- Subtraction (using 10's complement)
            -- Handle subtraction similarly to addition, with carry-out being handled differently
            if temp(4) = '1' then
                -- A borrow occurred, indicating a correct 10's complement subtraction
                carry <= '0'; -- Set carry to indicate borrow
                sum <= temp(3 downto 0); -- The sum is correct in 10's complement form
            else
                -- No borrow occurred, but result needs to be corrected if necessary
                if temp(3 downto 0) > 9 then
                    sum <= temp(3 downto 0) + 6; -- BCD correction
                    carry <= '0'; -- No carry in subtraction without a borrow
                else
                    sum <= temp(3 downto 0); -- No correction needed
                    carry <= '0';
                end if;
            end if;
        else
            -- Addition logic (Handle the three cases)
            if temp(4) = '1' then
                -- CASE 3: temp > 15
                sum <= (temp(3 downto 0) + 6) mod 10;  -- Apply BCD correction and modulo 10
                carry <= '1';                          -- Correct carry-out
            elsif temp(3 downto 0) > 9 then
                -- CASE 2: 9 < temp ? 15
                sum <= temp(3 downto 0) + 6;  -- Apply BCD correction
                carry <= '1';                 -- Correct carry-out
            else
                -- CASE 1: temp ? 9
                sum <= temp(3 downto 0);      -- No correction needed
                carry <= '0';                 -- No carry-out
            end if;
        end if;
    end process;

end Behavioral;