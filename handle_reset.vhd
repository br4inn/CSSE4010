library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ssd_multiplex is
    Port (
        CLK       : in std_logic;
        RESET     : in std_logic;     --center push button BTNC
        seg       : out std_logic_vector(7 downto 0);  
        an        : out std_logic_vector(3 downto 0);   
        cn        : out std_logic_vector(3 downto 0)  
    );
end ssd_multiplex;

architecture Behavioral of ssd_multiplex is

    signal slower_clk   : std_logic;                 
    signal counter_out  : integer range 0 to 7 := 0;   
    signal HEX_OUT      : std_logic_vector(3 downto 0); 
    signal SSD_OUT      : std_logic_vector(7 downto 0);  
 
    component Clock_Divider is
        port (
            clk        : in std_logic;
            reset      : in std_logic;
            clock_out  : out std_logic
        );
    end component;
 
    component hex_to_ssd is
        port (
            hex_in         : in std_logic_vector(3 downto 0);
            ssd_cathode_out : out std_logic_vector(7 downto 0)
        );
    end component;

begin
 
    Clock_Divider_Inst : Clock_Divider
        port map (
            clk       => CLK,
            reset     => RESET,
            clock_out => slower_clk
        );
 
    process(slower_clk, RESET)
    begin
        if RESET = '1' then
            counter_out <= 0;   
        elsif rising_edge(slower_clk) then
            if counter_out = 7 then
                counter_out <= 0;
            else
                counter_out <= counter_out + 1;
            end if;
        end if;
    end process;
 
    process(counter_out)
begin
    case counter_out is
        when 0 => HEX_OUT <= "0100";  
        when 1 => HEX_OUT <= "0100";  
        when 2 => HEX_OUT <= "0111";  
        when 3 => HEX_OUT <= "0100";  
        when 4 => HEX_OUT <= "0111";  
        when 5 => HEX_OUT <= "0101"; 
        when 6 => HEX_OUT <= "1001";  
        when 7 => HEX_OUT <= "0110"; 
        when others => HEX_OUT <= "0000";  
    end case;
end process; 
 
    SSD_Inst : hex_to_ssd
        port map (
            hex_in => HEX_OUT,
            ssd_cathode_out => SSD_OUT
        );
 
    process(counter_out)
    begin 
        an <= "1111"; 
        cn <= "1111";
         
        case counter_out is 
            when 0 => cn <= "1110";   
            when 1 => cn <= "1101";   
            when 2 => cn <= "1011";   
            when 3 => cn <= "0111";  
             
            when 4 => an <= "1110";   
            when 5 => an <= "1101";  
            when 6 => an <= "1011";  
            when 7 => an <= "0111";   
            when others => 
                an <= "1111";  
                cn <= "1111";  
        end case;
    end process;
    seg <= SSD_OUT;

end Behavioral;
