library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEE.std_logic_unsigned;

entity prac2 is
    Port (     
        clk_in     : in std_logic; -- 100 MHz system clock
        reset      : in std_logic; -- Reset button
        d_in0      : in std_logic_vector(3 downto 0); -- BCD digit 0 input
        d_in1      : in std_logic_vector(3 downto 0); -- BCD digit 1 input
        d_in2      : in std_logic_vector(3 downto 0); -- BCD digit 2 input
        d_in3      : in std_logic_vector(3 downto 0); -- BCD digit 3 input
        pb0_clk_en : in std_logic; -- Push button for BCD digit 0
        pb1_clk_en : in std_logic; -- Push button for BCD digit 1
        pb2_clk_en : in std_logic; -- Push button for BCD digit 2
        pb3_clk_en : in std_logic; -- Push button for BCD digit 3
        seg        : out std_logic_vector(6 downto 0); -- Seven-segment display
        an         : out std_logic_vector(3 downto 0); -- Anode signals
        lock       : out std_logic; -- Lock LED
        unlock     : out std_logic  -- Unlock LED
        );
end prac2;

architecture Behavioral of prac2 is
    signal bcd_digit0, bcd_digit1, bcd_digit2, bcd_digit3 : std_logic_vector(3 downto 0);
    signal match : std_logic;
    signal digit_select : std_logic_vector(1 downto 0);
    signal clk_div : std_logic;

    signal seg0, seg1, seg2, seg3 : std_logic_vector(7 downto 0); -- Signals for each digit's segment output

    -- student number "6957" in BCD
    constant student_num : std_logic_vector(15 downto 0) := "0110100101010111"; -- BCD for 6957

    -- Component Declaration for hex_to_ssd
    component hex_to_ssd is
        port (
            hex_in : in std_logic_vector(3 downto 0);
            ssd_cathode_out : out std_logic_vector(7 downto 0)
        ); 
    end component;

begin

    -- BCD Input Register for Digit 0
    process(clk_in, reset)
    begin
        if reset = '1' then
            bcd_digit0 <= "0000";
        elsif rising_edge(clk_in) then
            if pb0_clk_en = '1' then
                bcd_digit0 <= d_in0;
            end if;
        end if;
    end process;

    -- BCD Input Register for Digit 1
    process(clk_in, reset)
    begin
        if reset = '1' then
            bcd_digit1 <= "0000";
        elsif rising_edge(clk_in) then
            if pb1_clk_en = '1' then
                bcd_digit1 <= d_in1;
            end if;
        end if;
    end process;

    -- BCD Input Register for Digit 2
    process(clk_in, reset)
    begin
        if reset = '1' then
            bcd_digit2 <= "0000";
        elsif rising_edge(clk_in) then
            if pb2_clk_en = '1' then
                bcd_digit2 <= d_in2;
            end if;
        end if;
    end process;

    -- BCD Input Register for Digit 3
    process(clk_in, reset)
    begin
        if reset = '1' then
            bcd_digit3 <= "0000";
        elsif rising_edge(clk_in) then
            if pb3_clk_en = '1' then
                bcd_digit3 <= d_in3;
            end if;
        end if;
    end process;

    -- Comparator process to check if the entered BCD digits match the student number
    process(bcd_digit0, bcd_digit1, bcd_digit2, bcd_digit3)
    begin
        if (bcd_digit3 & bcd_digit2 & bcd_digit1 & bcd_digit0) = student_num then
            match <= '1';
        else
            match <= '0';
        end if;
    end process;

-- Instantiation of hex_to_ssd components
U0_hex_to_ssd: hex_to_ssd
    port map (
        hex_in => bcd_digit0,
        ssd_cathode_out => seg0
    );
 

    -- Multiplexing the digits onto the seven-segment display
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            case digit_select is
                when "00" =>
                    an <= "1110"; -- Enable the first digit
                    seg <= seg0(6 downto 0); -- Select corresponding segments
                when "01" =>
                    an <= "1101"; -- Enable the second digit
                    seg <= seg1(6 downto 0);
                when "10" =>
                    an <= "1011"; -- Enable the third digit
                    seg <= seg2(6 downto 0);
                when "11" =>
                    an <= "0111"; -- Enable the fourth digit
                    seg <= seg3(6 downto 0);
                when others =>
                    an <= "1111"; -- Disable all digits
            end case;
        end if;
    end process;

    -- Simple clock divider to drive digit select signal
    clk_divider: process(clk_in)
    begin
        if rising_edge(clk_in) then
            clk_div <= not clk_div;
            if clk_div = '1' then
                digit_select <= digit_select + 1;
            end if;
        end if;
    end process;

end Behavioral;
