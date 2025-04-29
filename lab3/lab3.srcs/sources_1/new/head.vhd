library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Header is
Port ( 
        CLK         : in std_logic; 
        RESET       : in std_logic;                        
        sw          : in std_logic_vector(15 downto 0);   
        BUTTON      : in std_logic;     
        seg         : out std_logic_vector(7 downto 0);    
        MUX_OUT     : out std_logic_vector(3 downto 0);  -- Output from the MUX in HEX
        an          : out std_logic_vector(3 downto 0);  -- SSD Anodes
        cn          : out std_logic_vector(3 downto 0)
          
    );
end Header;

architecture Behavioral of Header is
    signal A1, B1, A2, B2       : unsigned(3 downto 0);
    signal sum1, sum2           : unsigned(3 downto 0);
    signal carry_out            : std_logic;           
    signal HEX_OUT              : std_logic_vector(3 downto 0);  -- Output of the Mux
    signal SSD_OUT              : std_logic_vector(7 downto 0);  -- 7-segment display input
    signal COUNTER_OUT_VEC      : std_logic_vector(1 downto 0);  -- Select lines for MUX
    signal COUNTER_OUT          : integer range 0 to 3;          
    signal slower_clk           : std_logic;
    signal C_out       : std_logic;      
    signal carry_out_final      : std_logic_vector(3 downto 0);
       
begin
    
    Clock_Divider_Inst : entity work.clock_divider
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
    
    cn <= "1111";      
    carry_out_final <= "000" & C_out;
 
    A1 <= unsigned(sw(3 downto 0));    -- A1
    A2 <= unsigned(sw(7 downto 4));   --  B1    
    B1 <= unsigned(sw(11 downto 8));  --   A2
    B2 <= unsigned(sw(15 downto 12)); --   B2
    
    -- Assign the counter output to a 2-bit vector
    COUNTER_OUT_VEC <= std_logic_vector(to_unsigned(COUNTER_OUT, 2));
    
     
    BCD_Adder_Sub_inst_1 : entity work.BCD_Adder_Subtractor
        port map(
            A => A1, 
            B => B1,
            C_in => '0',
            sum => sum1, 
            carry => carry_out, 
            sub => BUTTON
        ); 
    

    BCD_Adder_Sub_inst_2 : entity work.BCD_Adder_Subtractor
        port map(
            A => A2, 
            B => B2,
            C_in => carry_out,
            sum => sum2, 
            carry => C_out, 
            sub => BUTTON
        );
        
 
  
    
    MUX_Inst : entity work.MUX
        port map (
            A => std_logic_vector(sum1),                 
            B => std_logic_vector(sum2),                   
            C => carry_out_final,                        
            S0 => COUNTER_OUT_VEC(0),
            S1 => COUNTER_OUT_VEC(1),
            Z  => HEX_OUT
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
    
 
end Behavioral;