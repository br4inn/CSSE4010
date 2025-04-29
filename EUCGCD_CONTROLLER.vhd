-- GCD Controller
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GCD_Controller is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        start   : in  std_logic;
        A_eq_B  : in  std_logic;
        A_gt_B  : in  std_logic;
        A_lt_B  : in  std_logic;
        load    : out std_logic;
        enA     : out std_logic;
        enB     : out std_logic;
        selA    : out std_logic;
        selB    : out std_logic;
        done    : out std_logic
    );
end GCD_Controller;

architecture Behavioral of GCD_Controller is
    type state_type is (Idle, loading, Compare, Subtract_A, Subtract_B, finished);
    signal state, next_state: state_type;
begin
    
    process(clk, reset)
    begin
        if reset = '1' then
            state <= Idle;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    
    process(state, start, A_eq_B, A_gt_B, A_lt_B)
    begin
        case state is
            when Idle =>
                if start = '1' then
                    next_state <= loading;
                else
                    next_state <= Idle;
                end if;
            when loading =>
                next_state <= Compare;
            when Compare =>
                if A_eq_B = '1' then
                    next_state <= finished;
                elsif A_gt_B = '1' then
                    next_state <= Subtract_A;
                else
                    next_state <= Subtract_B;
                end if;
            when Subtract_A =>
                next_state <= Compare;
            when Subtract_B =>
                next_state <= Compare;
            when finished =>
                if start = '0' then
                    next_state <= Idle;  
                else
                    next_state <= finished; 
                end if;
            when others =>
                next_state <= Idle;
        end case;
    end process;
 
    process(state)
    begin 
        load <= '0';
        enA  <= '0';
        enB  <= '0';
        selA <= '0';
        selB <= '0';
        done <= '0';

        case state is
            when Idle =>
                null;
            when loading =>
                load <= '1';
                enA  <= '1';
                enB  <= '1';
                selA <= '0';  
                selB <= '0';  
            when Compare =>
                null;
            when Subtract_A =>
                enA  <= '1';
                selA <= '1'; 
            when Subtract_B =>
                enB  <= '1';
                selB <= '1';  
            when finished =>
                done <= '1';  
            when others =>
                null;
        end case;
    end process;

end Behavioral;
