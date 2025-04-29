library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Lock_Unlock is
    Port (
        CLK         : in std_logic;
        RESET       : in std_logic;    
        LOCK        : out std_logic;                   
        UNLOCK      : out std_logic;                     
        seg         : out std_logic_vector(7 downto 0);  
        an          : out std_logic_vector(7 downto 0);   
        BUTTON      : in std_logic_vector(3 downto 0);   
        SW          : in std_logic_vector(3 downto 0)  
    );
end Lock_Unlock;

architecture Behavioral of Lock_Unlock is
    
   
    signal digit_index  : integer range 0 to 3 := 0;  -- Track digit being entered
    signal ssd_display  : std_logic_vector(3 downto 0); -- Display the curr digit on the SSD
    signal BCD_INPUT    : std_logic_vector(15 downto 0) := (others => '0');  
    signal STUDENT_NUM  : std_logic_vector(15 downto 0) := "0110100101010111";--6957
begin
    --   handle BCD input based on button presses
    process(CLK, RESET)
    begin
        if RESET = '1' then
            BCD_INPUT <= (others => '0');
            digit_index <= 0;
        elsif rising_edge(CLK) then
            if BUTTON(digit_index) = '1' then
                case digit_index is
                    when 0 =>
                        BCD_INPUT(3 downto 0) <= SW;
                        digit_index <= 1;
                    when 1 =>
                        BCD_INPUT(7 downto 4) <= SW;
                        digit_index <= 2;
                    when 2 =>
                        BCD_INPUT(11 downto 8) <= SW;
                        digit_index <= 3;
                    when 3 =>
                        BCD_INPUT(15 downto 12) <= SW;
                        digit_index <= 0;
                end case;
            end if;
        end if;
    end process;

    -- Compare the BCD input with student num
    process(BCD_INPUT, STUDENT_NUM)
    begin
        if BCD_INPUT = STUDENT_NUM then
            LOCK <= '0';
            UNLOCK <= '1';
        else
            LOCK <= '1';
            UNLOCK <= '0';
        end if;
    end process;

        
end Behavioral;
