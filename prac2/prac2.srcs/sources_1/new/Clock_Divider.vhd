library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Clock_Divider is
port ( clk,reset: in std_logic;
    clock_out: INOUT std_logic
    );
end Clock_Divider;

architecture bhv of Clock_Divider is

signal count: integer:=1; -- Counter to track clock cycles
signal tmp : std_logic := '0'; -- Temp signal to generate the divided clock

begin

process(clk,reset)
begin

    -- Synchronous reset: when reset is active (high), initialize signals
    if(reset='1') then
        count<=1;
        tmp<='0';
        
    -- Clock edge detection
    elsif(clk'event and clk='1') then
        count <=count+1;
        
    -- If the counter reaches the desired value, toggle the clock output
    if (count = 300000) then
        tmp <= NOT tmp; -- Toggle the divided clock signal
        count <= 1;
        end if;
    end if;
    
     -- Assign the temporary signal to the output
    clock_out <= tmp;
    end process;

end bhv;
