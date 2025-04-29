library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity top_level is
    Port (
        CLK         : in std_logic; 
        RESET       : in std_logic;                         -- E16 BTNC (middle button)
        BUTTON      : in std_logic_vector(3 downto 0);      -- Button for loading each register *V10, T16, F15, R10)
        SW          : in std_logic_vector(3 downto 0);     -- to input num (U9, U8, R7, R6) (SW0-SW3) 
        seg         : out std_logic_vector(7 downto 0);     -- SSD cath outputs
        an          : out std_logic_vector(3 downto 0);     -- SSD an outputs
        MUX_OUT     : out std_logic_vector(3 downto 0);   -- Output from the MUX in HEX
        MATCH       : out std_logic;    -- match sdnt num
        LOCK_LED       : out std_logic    --  do not match student number
        );
end top_level;

architecture Behavioural of top_level is

-- four reg signals
    signal REG0_OUT : std_logic_vector(3 downto 0) := (others => '0');
    signal REG1_OUT : std_logic_vector(3 downto 0) := (others => '0');
    signal REG2_OUT : std_logic_vector(3 downto 0) := (others => '0');
    signal REG3_OUT : std_logic_vector(3 downto 0) := (others => '0');
    signal decoder_out : std_logic_vector(3 downto 0);  -- Decoder output
    signal clk_en   : std_logic_vector(3 downto 0);  -- Clock enable for regs
    signal q_out_internal : std_logic_vector(15 downto 0);
    signal BCD_INPUT : std_logic_vector(15 downto 0) := (others => '0');  -- 4 reg input combined
    signal LOCK, UNLOCK : std_logic;  -- Signal to store result
    signal HEX_OUT  : std_logic_vector(3 downto 0);  -- Output of the Mux
    signal SSD_OUT  : std_logic_vector(7 downto 0);  -- 7-segment display input
    signal COUNTER_OUT_VEC : std_logic_vector(1 downto 0);  -- Select lines for MUX
    signal COUNTER_OUT : integer range 0 to 3;  -- Counts from 0 to 3
    signal slower_clk : std_logic;  
    signal STUDENT_NUM  : std_logic_vector(15 downto 0) := "0110100101010111"; --6957
begin
    -- Clock enable for regs based on button presses
    clk_en(0) <= BUTTON(0);
    clk_en(1) <= BUTTON(1);
    clk_en(2) <= BUTTON(2);
    clk_en(3) <= BUTTON(3);
    
    -- make counter output a 2 bit vector
    COUNTER_OUT_VEC <= std_logic_vector(to_unsigned(COUNTER_OUT, 2));

    -- Initialise Clock Divider
    Clock_Divider_Inst : entity work.Clock_Divider
        port map (
            clk       => CLK,
            reset     => RESET,
            clock_out => slower_clk
        );
        
    -- Initialise counter
    Counter_Inst : entity work.counter
        port map (
            clk_in => slower_clk,
            q_out => COUNTER_OUT
        );
     
        
    -- Instialise the mux
    MUX_Inst : entity work.mux
        port map (
            A => REG0_OUT,
            B => REG1_OUT,
            C => REG2_OUT,
            D => REG3_OUT,
            S0 => COUNTER_OUT_VEC(0),
            S1 => COUNTER_OUT_VEC(1),
            Z => HEX_OUT
        );
        -- initialise demux/decoder
    Decoder_Inst : entity work.demux
        port map (
            decoder_select => COUNTER_OUT_VEC,
            decoder_in     => COUNTER_OUT_VEC,  
            decoder_out    => an
        );
    
    -- SSD Hexadecimal to 7-Segment Decoder
    SSD_Inst: entity work.hex_to_ssd
        port map (
            hex_in => HEX_OUT,
            ssd_cathode_out => SSD_OUT
        );

    -- Initialise four 4-bit registers
    reg0: entity work.register_example
        port map (
        d_in => SW(3 downto 0),
        clk_in => slower_clk,
        clk_en_in => BUTTON(0),
        reset_in => RESET,   
        q_out => REG0_OUT
    );

    reg1: entity work.register_example
        port map (
        d_in => SW(3 downto 0),
        clk_in => slower_clk,
        clk_en_in => BUTTON(1),
        reset_in => RESET,   
        q_out => REG1_OUT
    );

    reg2: entity work.register_example
        port map (
        d_in => SW(3 downto 0),
        clk_in => slower_clk,
        clk_en_in => BUTTON(2),
        reset_in => RESET,   
        q_out => REG2_OUT
    );

    reg3: entity work.register_example
        port map (
        d_in => SW(3 downto 0),
        clk_in => slower_clk,
        clk_en_in => BUTTON(3),
        reset_in => RESET,  
        q_out => REG3_OUT
    );
        
    -- Combine the 4 registers into 16-bit BCD input
    BCD_INPUT <= REG3_OUT & REG2_OUT & REG1_OUT & REG0_OUT;

    -- Compare the BCD input with the student num
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

    MATCH <= UNLOCK;
    LOCK_LED <= LOCK;

    -- Output to the 7-segment display
    seg <= SSD_OUT;
    

end Behavioural;
 