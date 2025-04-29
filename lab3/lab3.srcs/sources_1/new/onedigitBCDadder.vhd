library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCDadder is
  port(
        A, B  : in  unsigned(3 downto 0);
        carry_in : in std_logic;
        sum  : out  unsigned(3 downto 0); 
        carry_out : out std_logic  
    );
end BCDadder;

architecture Behavioral of BCDadder is

begin
process(A, B, carry_in)
    variable temp : unsigned(4 downto 0);
begin
    temp := ('0' & A) + ('0' & B) + ("0000" & carry_in); 
    if temp > 9 then
        temp := temp + 6; -- BCD correction
        carry_out <= '1'; -- Set carry if result exceeds BCD range
    else
        carry_out <= '0';
    end if;

    sum <= temp(3 downto 0); -- Assign the lower 4 bits to the sum output
end process;   

end Behavioral;
