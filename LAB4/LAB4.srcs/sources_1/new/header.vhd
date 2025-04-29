library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_level is
    Port (
        CLK : in STD_LOGIC;        
        RESET : in STD_LOGIC;          
        sw : in STD_LOGIC_VECTOR(15 downto 0); -- 16-bit input  
        BUTTON      : in std_logic;          
        seg : out STD_LOGIC_VECTOR(7 downto 0);  
        an  : out STD_LOGIC_VECTOR(3 downto 0); 
        cn  : out STD_LOGIC_VECTOR(3 downto 0); 
        MUX_OUT : out STD_LOGIC_VECTOR(1 downto 0)  
    );
end top_level;

architecture Behavioral of top_level is
    -- Internal signals
    signal SSD_OUT  : STD_LOGIC_VECTOR(7 downto 0);   
    signal divided_clk : STD_LOGIC;
    signal serial_in : STD_LOGIC;
    signal detected : STD_LOGIC;
   signal count_out : STD_LOGIC_VECTOR(3 downto 0);  
    signal HEX_OUT : STD_LOGIC_VECTOR(3 downto 0);   
    signal COUNTER_OUT_VEC : STD_LOGIC_VECTOR(1 downto 0);   
    signal COUNTER_OUT : integer range 0 to 3;  
    signal next_out : std_logic_vector(3 downto 0);

 begin
 
    cn <= "1111";
    
    COUNTER_OUT_VEC <= std_logic_vector(to_unsigned(COUNTER_OUT, 2));
 
     
    clock_div_inst : entity work.clock_divider
        Port map (
            clk => CLK,
            reset => RESET,
            clock_out => divided_clk
        );

    
    shift_reg_inst : entity work.shift_register
        Port map (
            clk => divided_clk,
            rst => RESET,
            load => BUTTON,
            parallel_in => sw,
            serial_out => serial_in
        );
 
    seq_det_inst : entity work.signal_detector
        Port map (
            clk => divided_clk,
            reset => RESET,
            serial_in => serial_in,
            detected => detected
        );
 
    seq_count_inst : entity work.sequence_counter
        Port map (
            clk => divided_clk,
            reset => RESET,
            detected => detected,
            count_out  => count_out,
            second_digit => neck_out
        );
 
    Counter_Inst : entity work.counter_for_decoder
        Port map (
            clk_in => divided_clk,
            q_out => COUNTER_OUT
        );
 
    MUX_Inst : entity work.mux
        Port map (
            A => count_out(3 downto 0),   
            B => next_out(3 downto 0),        
            S0 => COUNTER_OUT_VEC(0),
            S1 => COUNTER_OUT_VEC(1),
            Z => HEX_OUT
        );
 
      Decoder_Inst : entity work.demux
        port map (
            decoder_select => COUNTER_OUT_VEC,
            decoder_in     => COUNTER_OUT_VEC,
            decoder_out    => an
        );
 
      SSD_Inst: entity work.hex_to_ssd
        port map (
            hex_in => HEX_OUT,
            ssd_cathode_out => SSD_OUT
        );
        

    -- Output to the 7-segment display
    seg <= SSD_OUT;
end behavioral;