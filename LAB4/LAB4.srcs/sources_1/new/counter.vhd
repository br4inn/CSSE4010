library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;   

entity sequence_counter is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        detected : in STD_LOGIC;
        second_digit : out std_logic_vector(3 downto 0);  -- Tens place
        count_out : out STD_LOGIC_VECTOR(3 downto 0)      -- Ones place
    );
end sequence_counter;

architecture Behavioral of sequence_counter is
    signal count : unsigned(3 downto 0) := "0000";   
    signal next_digit : unsigned(3 downto 0) := "0000";  
begin 

    process(clk, reset)
    begin
        if reset = '1' then
            count <= "0000";   
            next_digit <= "0000";    
        elsif rising_edge(clk) then
            if detected = '1' then
                if count = "1001" then   
                    count <= "0000";     
                    if next_digit = "1001" then   
                        next_digit <= "0000";   
                    else
                        next_digit <= next_digit + 1;   
                    end if;
                else
                    count <= count + 1;  
                end if;
            end if;
        end if;
    end process;

    -- Output to SSD
    count_out <= std_logic_vector(count);   -- Ones digit 
    second_digit <= std_logic_vector(next_digit); -- Tens digit 

end Behavioral;