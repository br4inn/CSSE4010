library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Use numeric_std for arithmetic operations

entity int_sqrt_top is
    Port (
        CLK, RESET : in std_logic;
        sw         : in std_logic_vector(15 downto 0); -- SW0-SW15 represent Rx and Ry
        seg        : out std_logic_vector(7 downto 0); 
        an         : out std_logic_vector(3 downto 0);  -- Right four displays
        cn         : out std_logic_vector(3 downto 0)   -- Left four displays
      
    );
end int_sqrt_top;

architecture Behavioral of int_sqrt_top is
 
    
    type bcd_array is array (0 to 1) of std_logic_vector(3 downto 0); -- Two digits
    signal Rx_in          : std_logic_vector(7 downto 0);
    signal Rz_out         : std_logic_vector(7 downto 0);
    signal greater_equal  : std_logic;
    signal load_Rx        : std_logic;
    signal Rx_sel         : std_logic;
    signal load_Rz        : std_logic;
    signal Rz_sel         : std_logic;
    signal load_K         : std_logic;
    signal K_sel          : std_logic;
    signal start          : std_logic;  
    signal controller_done: std_logic;
    signal bcd     : std_logic_vector(7 downto 0);  
    signal divided_clk    : std_logic;
 
    signal digit_counter  : std_logic_vector(1 downto 0);  
    signal ssd_digit      : std_logic_vector(3 downto 0);
    signal ssd_cathode_out: std_logic_vector(7 downto 0);
  signal BCD_digits   : bcd_array; 
    signal Rz_bcd         : std_logic_vector(11 downto 0);  
  Signal COUNTER_OUT_VEC : STD_LOGIC_VECTOR(1 downto 0);   
    signal COUNTER_OUT : integer range 0 to 3;  
    signal HEX_OUT : STD_LOGIC_VECTOR(3 downto 0);  
     signal SSD_OUT  : STD_LOGIC_VECTOR(7 downto 0); 
begin 
    Rx_in <= sw(7 downto 0);   
 COUNTER_OUT_VEC <= std_logic_vector(to_unsigned(COUNTER_OUT, 2));
  
    clock_div_inst : entity work.Clock_Divider
        Port map (
            clk       => CLK,
            reset     => RESET,
            clock_out => divided_clk
    );
 
    datapath_inst : entity work.sqr_datapath
        port map (
            clk           => CLK,
            reset         => RESET,
            load_Rx       => load_Rx,
            Rx_in         => Rx_in,
            load_K        => load_K,
            load_Rz       => load_Rz,
            Rx_sel        => Rx_sel,
            K_sel         => K_sel,
            Rz_sel        => Rz_sel,
            greater_equal => greater_equal,
            Rx_zero       => open,  
            Rz_out        => Rz_out
        );
        
        
   
   
        
 
    controller_inst : entity work.isqrt_controller
        port map (
            clk           => CLK,
            reset         => RESET,
            start         => start,
            greater_equal => greater_equal,
            load_Rx       => load_Rx,
            Rx_sel        => Rx_sel,
            load_K        => load_K,
            K_sel         => K_sel,
            load_Rz       => load_Rz,
            Rz_sel        => Rz_sel,
            done          => controller_done
        );
 
start_process: process(CLK, RESET)
    variable start_pulse_generated : boolean := false;
begin
    if RESET = '1' then
        start <= '0';
        start_pulse_generated := false;
    elsif rising_edge(CLK) then
        if controller_done = '1' then
            start <= '0';  
            start_pulse_generated := false; 
        elsif start = '0' and not start_pulse_generated then
            start <= '1'; 
            start_pulse_generated := true;  
        else
            start <= '0';  
        end if;
    end if;
end process;


  
     BCD_Converter_inst : entity work.Binary_to_BCD
        port map (
            binary_in => Rz_out,
            bcd_out   => bcd
        );
        
 
    BCD_digits(0) <= bcd(3 downto 0);  
    BCD_digits(1) <= bcd(7 downto 4); 
   
     Mux2to1_4_inst : entity work.Mux2to1_4
            port map (
                sel => COUNTER_OUT_VEC(0),   
                D0  => BCD_digits(0),
                D1  => BCD_digits(1),
                Y   => HEX_OUT
            );
             
    SSD_Inst : entity work.hex_to_ssd
        port map (
            hex_in          => HEX_OUT,
            ssd_cathode_out => SSD_OUT
        );

        
   Counter_Inst : entity work.counter_for_decoder
           Port map (
               clk_in => divided_clk,
               q_out => COUNTER_OUT
    ); 
    
    demux_inst : entity work.demux
        Port map (
            decoder_select => COUNTER_OUT_VEC,
            decoder_in     => COUNTER_OUT_VEC,
            decoder_out    => an     
            );   
            
    cn <= "1111"; 
    
    seg <= SSD_OUT;
    
end Behavioral;
