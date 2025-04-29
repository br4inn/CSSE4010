library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity signal_detector is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        serial_in : in STD_LOGIC;
        detected : out STD_LOGIC
    );
end signal_detector;

architecture Behavioral of signal_detector is
    
    type state_type is (S0, S1, S2, S3, S4, S5, S6);
    signal state, next_state : state_type;
begin
  
    process(clk, reset)
    begin
        if reset = '1' then
            state <= S0;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;
 
    process(state, serial_in)
    begin
        case state is
            when S0 =>
                if serial_in = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;

            when S1 =>
                if serial_in = '0' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;

            when S2 =>
                if serial_in = '0' then
                    next_state <= S3;
                else
                    next_state <= S1;
                end if;

            when S3 =>
                if serial_in = '1' then
                    next_state <= S4;
                else
                    next_state <= S0;
                end if;

            when S4 =>
                if serial_in = '0' then
                    next_state <= S5;
                else
                    next_state <= S1;
                end if;

            when S5 =>
                if serial_in = '1' then
                    next_state <= S6;
                else
                    next_state <= S2; --  for overlap
                end if;

            when S6 =>
                -- move to S1 for overlap 
                if serial_in = '0' then
                    next_state <= S2;  
                else
                    next_state <= S1;   
                end if;

        end case;
    end process;

     
    process(state)
    begin
        if state = S6 then
            detected <= '1';  
        else
            detected <= '0';  
        end if;
    end process;

end Behavioral;