library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity onedigittop is
    Port ( 
        CLK         : in std_logic; 
        RESET       : in std_logic;
        sw          : in std_logic_vector(15 downto 0);  -- 16 slide switches
        seg         : out std_logic_vector(7 downto 0);  -- SSD cathode outputs  
        an          : out std_logic_vector(3 downto 0);  -- SSD Anodes
        cn: out std_logic_vector(3 downto 0)
    );
end onedigittop;

architecture Behavioral of onedigittop is
    signal A1, B1, A2, B2       : unsigned(3 downto 0);
    signal sum1, sum2           : unsigned(3 downto 0);
    signal carry_out_final      : std_logic;
    signal HEX_OUT              : std_logic_vector(3 downto 0);
    signal SSD_OUT              : std_logic_vector(7 downto 0);
    signal COUNTER_OUT_VEC      : std_logic_vector(1 downto 0);
    signal slower_clk           : std_logic;
    signal COUNTER_OUT         : integer range 0 to 3;       
    signal MUX_IN1              : std_logic_vector(3 downto 0);
    signal MUX_IN2              : std_logic_vector(3 downto 0);
    signal carry_out_display    : std_logic_vector(3 downto 0);  -- For carry_out display

begin
cn<= "1111";
    -- Map switches to BCD inputs
    A1 <= unsigned(sw(3 downto 0));   -- SW0 - SW3 for A1
    B1 <= unsigned(sw(7 downto 4));   -- SW4 - SW7 for B1
    A2 <= unsigned(sw(11 downto 8));  -- SW8 - SW11 for A2
    B2 <= unsigned(sw(15 downto 12)); -- SW12 - SW15 for B2

    -- Instantiate the 2-digit BCD adder
    UUT: entity work.onedigitBCDadder
        port map(
            A1 => A1,
            B1 => B1,
            A2 => A2,
            B2 => B2,
            carry_in => '0',
            sum1 => sum1,
            sum2 => sum2,
            carry_out_final => carry_out_final
        );

    -- Handle MUX inputs for three 7-segment displays
    MUX_IN1 <= std_logic_vector(sum1);   -- First digit (least significant)
    MUX_IN2 <= std_logic_vector(sum2);   -- Second digit
    carry_out_display <= "000" & carry_out_final; -- Third digit (carry-out)

    -- Instantiate the MUX to select which sum to display
    MUX_Inst : entity work.MUX
        port map (
            A => MUX_IN1,  -- Display first sum digit
            B => MUX_IN2,  -- Display second sum digit
            C => carry_out_display,  -- Display carry-out as third digit
            S0 => COUNTER_OUT_VEC,
            S1 => COUNTER_OUT_VEC,
            Z  => HEX_OUT
        );

    -- Initialize Clock Divider
    Clock_Divider_Inst : entity work.Clock_Divider
        port map (
            clk       => CLK,
            reset     => RESET,
            clock_out => slower_clk
        );

    -- Initialize Counter
    Counter_Inst : entity work.counter
        port map (
            clk_in => slower_clk,
            q_out => COUNTER_OUT
        );

    -- Initialize Decoder/Demux
    Decoder_Inst : entity work.demux
        port map (
            decoder_select => COUNTER_OUT_VEC,
            decoder_in     => COUNTER_OUT_VEC,  -- No enable input needed
            decoder_out    => an
        );

    -- SSD Hexadecimal to 7-Segment Decoder
    SSD_Inst: entity work.hex_to_ssd
        port map (
            hex_in => HEX_OUT,
            ssd_cathode_out => SSD_OUT
        );

    -- Output to the 7-segment display
    seg <= SSD_OUT;
end Behavioral;
