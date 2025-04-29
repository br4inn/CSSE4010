library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity twodigittopwithsubtract is
    Port ( 
        CLK         : in std_logic; 
        RESET       : in std_logic;
        sw          : in std_logic_vector(15 downto 0);  -- 16 slide switches
        sub_button  : in std_logic;                     -- Switch to select add or subtract
        seg         : out std_logic_vector(7 downto 0);  -- SSD cathode outputs  
        MUX_OUT     : out std_logic_vector(3 downto 0);  -- Output from the MUX in HEX
        an          : out std_logic_vector(3 downto 0)    -- SSD Anodes
    );
end twodigittopwithsubtract;

architecture Behavioral of twodigittopwithsubtract is
    signal A1, B1, A2, B2       : unsigned(3 downto 0);
    signal sum1, sum2           : unsigned(3 downto 0);
    signal carry_out_final      : std_logic;
    signal HEX_OUT              : std_logic_vector(3 downto 0);
    signal SSD_OUT              : std_logic_vector(7 downto 0);
    signal COUNTER_OUT_VEC      : std_logic_vector(1 downto 0);
    signal COUNTER_OUT          : integer range 0 to 3;
    signal slower_clk           : std_logic;

begin
    -- Map switches to BCD inputs
    A1 <= unsigned(SW(3 downto 0));   -- SW0 - SW3 for A1
    B1 <= unsigned(SW(7 downto 4));   -- SW4 - SW7 for B1
    A2 <= unsigned(SW(11 downto 8));  -- SW8 - SW11 for A2
    B2 <= unsigned(SW(15 downto 12)); -- SW12 - SW15 for B2

    -- Instantiate the 2-digit BCD adder/subtractor
    UUT: entity work.twodigitBCDadderandsubtract
        port map(
            A1 => A1,
            B1 => B1,
            A2 => A2,
            B2 => B2,
            carry_in => '0',            -- No initial carry-in for simplicity
            sub => sub_button,           
            sum1 => sum1,
            sum2 => sum2,
            carry_out_final => carry_out_final
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
            decoder_in     => COUNTER_OUT_VEC,
            decoder_out    => an
        );

    -- The SSD output assignment
   -- SSD_OUT <= (others => '0');  -- Default to '0', update based on your display logic
    -- SSD Hexadecimal to 7-Segment Decoder
    SSD_Inst: entity work.hex_to_ssd
        port map (
            hex_in => HEX_OUT,
            ssd_cathode_out => SSD_OUT
        );
    -- Output to the 7-segment display
    seg <= SSD_OUT;
end Behavioral;
 