library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity isqrt_controller is
    Port (
        clk, reset       : in std_logic;
        start            : in std_logic;
        greater_equal    : in std_logic;
        load_Rx          : out std_logic;
        Rx_sel           : out std_logic;
        load_K           : out std_logic;
        K_sel            : out std_logic;
        load_Rz          : out std_logic;
        Rz_sel           : out std_logic;
        done             : out std_logic
    );
end isqrt_controller;

architecture Behavioral of isqrt_controller is
    type state_type is (IDLE, INIT, CHECK, SUBTRACT, FINISHED);
    signal state, next_state : state_type;
begin
    process (clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    process (state, start, greater_equal)
    begin 
        load_Rx   <= '0';
        Rx_sel    <= '0';
        load_K    <= '0';
        K_sel     <= '0';
        load_Rz   <= '0';
        Rz_sel    <= '0';
        done      <= '0';
        next_state <= state;

        case state is
            when IDLE =>
                if start = '1' then
                    load_Rx <= '1';
                    Rx_sel  <= '0';  
                    load_K  <= '1';
                    K_sel   <= '0'; 
                    load_Rz <= '1';
                    Rz_sel  <= '0';  
                    next_state <= CHECK;
                end if;

            when CHECK =>
                if greater_equal = '1' then
                    next_state <= SUBTRACT;
                else
                    next_state <= FINISHED;
                end if;

            when SUBTRACT =>
                load_Rx <= '1';
                Rx_sel  <= '1';  
                load_K  <= '1';
                K_sel   <= '1'; 
                load_Rz <= '1';
                Rz_sel  <= '1';  
                next_state <= CHECK;

            when FINISHED =>
                done <= '1';
                next_state <= IDLE;

            when others =>
                next_state <= IDLE;
        end case;
    end process;
end Behavioral;
