library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use std.textio.all;

entity counter is
    port (
        clk_in : in std_logic;
        q_out : out integer range 0 to 3
    );
end counter;

architecture Behavioral of counter is

signal is_finished : std_logic := '0';
signal counter_value : integer range 0 to 3 := 0;

begin
process (clk_in) 
    variable L: line;
begin
    if clk_in'event and clk_in = '1' then
        if counter_value < 3 then
            counter_value <= counter_value + 1;
        else
            counter_value <= 0;
        end if;

        -- Print the current counter val to console
        write(L, string'("Count value: "));
        write(L, counter_value);
        writeline(output, L);
    end if;
end process;

q_out <= counter_value;
end behavioral;