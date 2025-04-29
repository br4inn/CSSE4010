library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADDSAT is
    Port (
        CLK       : in  std_logic;
        RESET     : in  std_logic;
        sw        : in  std_logic_vector(15 downto 0);  -- Rx and Ry from switches
        BUTTON    : in  std_logic;                      -- Start button
        seg       : out std_logic_vector(7 downto 0);   -- 7-segment cathode control
        an        : out std_logic_vector(3 downto 0);   -- Right four display anode control
        cn        : out std_logic_vector(3 downto 0)    -- Left four display anode control (currently unused)
    );
end ADDSAT;

architecture Structural of ADDSAT is
  
    signal GCD_bcd        : std_logic_vector(11 downto 0);  
    signal GCD_internal   : std_logic_vector(11 downto 0);
    signal Sum            : std_logic_vector(7 downto 0);
    signal Carry          : std_logic_vector(7 downto 0);
    signal Overflow       : std_logic;
    signal divided_clk    : std_logic;
    signal Rx, Ry         : std_logic_vector(7 downto 0);
    signal HEX_OUT        : std_logic_vector(3 downto 0);   
    signal SSD_OUT        : std_logic_vector(7 downto 0); 
    signal COUNTER_OUT    : integer range 0 to 2;  
    type bcd_array is array (0 to 2) of std_logic_vector(3 downto 0); 
    signal BCD_digits     : bcd_array; 
    signal COUNTER_OUT_VEC: std_logic_vector(1 downto 0);

    -- Saturation constants
    constant POS_SAT : std_logic_vector(7 downto 0) := "01111111";  
    constant NEG_SAT : std_logic_vector(7 downto 0) := "10000000";  -- -128

begin
 
    Rx <= sw(7 downto 0);   
    Ry <= sw(15 downto 8);  
 
    FA0: entity work.FullAdder port map(A => Rx(0), B => Ry(0), Cin => '0', Sum => Sum(0), Cout => Carry(0));
    FA1: entity work.FullAdder port map(A => Rx(1), B => Ry(1), Cin => Carry(0), Sum => Sum(1), Cout => Carry(1));
    FA2: entity work.FullAdder port map(A => Rx(2), B => Ry(2), Cin => Carry(1), Sum => Sum(2), Cout => Carry(2));
    FA3: entity work.FullAdder port map(A => Rx(3), B => Ry(3), Cin => Carry(2), Sum => Sum(3), Cout => Carry(3));
    FA4: entity work.FullAdder port map(A => Rx(4), B => Ry(4), Cin => Carry(3), Sum => Sum(4), Cout => Carry(4));
    FA5: entity work.FullAdder port map(A => Rx(5), B => Ry(5), Cin => Carry(4), Sum => Sum(5), Cout => Carry(5));
    FA6: entity work.FullAdder port map(A => Rx(6), B => Ry(6), Cin => Carry(5), Sum => Sum(6), Cout => Carry(6));
    FA7: entity work.FullAdder port map(A => Rx(7), B => Ry(7), Cin => Carry(6), Sum => Sum(7), Cout => Carry(7));
 
    OverflowDet: entity work.OverflowDetector port map(Rx => Rx, Ry => Ry, Sum => Sum, Overflow => Overflow);
 
   process(Sum, Overflow)
   begin
      if Overflow = '1' then
         if Sum(7) = '1' then
          
            GCD_internal <= "10000000" & "0000";  -- Extend -128  
         else 
            GCD_internal <= "01111111" & "0000";  -- Extend +127  
         end if;
      else 
         GCD_internal <= std_logic_vector(resize(signed(Sum), 12));  
      end if;
   end process;
 
    BCD_Converter_inst : entity work.Binary_to_BCD_12
        port map (
            binary_in => GCD_internal(7 downto 0),
            bcd_out   => GCD_bcd
        );
     
    BCD_digits(0) <= GCD_bcd(3 downto 0);   -- Ones 
    BCD_digits(1) <= GCD_bcd(7 downto 4);   -- Tens  
    BCD_digits(2) <= GCD_bcd(11 downto 8);  -- Hundreds  
 
    process(CLK, RESET)
        variable clk_count : integer := 0;
        constant DIVIDER : integer := 50000; 
    begin
        if RESET = '1' then
            clk_count := 0;
            divided_clk <= '0';
        elsif rising_edge(CLK) then
            if clk_count = DIVIDER then
                divided_clk <= not divided_clk;
                clk_count := 0;
            else
                clk_count := clk_count + 1;
            end if;
        end if;
    end process;
 
    process(divided_clk, RESET)
    begin
        if RESET = '1' then
            COUNTER_OUT <= 0;
        elsif rising_edge(divided_clk) then
            COUNTER_OUT <= COUNTER_OUT + 1;
            if COUNTER_OUT = 3 then
                COUNTER_OUT <= 0;
            end if;
        end if;
    end process;

process(COUNTER_OUT)
begin
    case COUNTER_OUT is
        when 0 => HEX_OUT <= BCD_digits(0);  -- Select Ones Place
        when 1 => HEX_OUT <= BCD_digits(1);  -- Select Tens Place
        when 2 => HEX_OUT <= BCD_digits(2);  -- Select Hundreds Place
        when others => HEX_OUT <= "0000";    -- Default case (should not occur)
    end case;
end process;

    -- SSD Decoder (Converts BCD to 7-Segment)
    SSD_Inst: entity work.hex_to_ssd
        port map (
            hex_in          => HEX_OUT,
            ssd_cathode_out => SSD_OUT
        ); 

   
    process(COUNTER_OUT)
    begin
        case COUNTER_OUT is
            when 0 => an <= "1110"; --  (Ones Place)
            when 1 => an <= "1101"; --  (Tens Place)
            when 2 => an <= "1011"; --  (Hundreds Place)
            when others => an <= "1111"; -- All off
        end case;
    end process;
 
    seg <= SSD_OUT;

end Structural;
