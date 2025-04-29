library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EUCGCD is
    Port (
        CLK    : in  std_logic;
        RESET  : in  std_logic;                      
        sw     : in  std_logic_vector(15 downto 0);  
        BUTTON : in  std_logic;                      
        seg    : out std_logic_vector(7 downto 0);   
        an     : out std_logic_vector(3 downto 0);   
        cn     : out std_logic_vector(3 downto 0)
   --     ssd_data : out  std_logic_vector(7 downto 0)
    );
end EUCGCD;

    
  architecture Structural of EUCGCD is 
    
    signal divided_clk : std_logic;   
    signal digit_clk   : std_logic;  
    signal Rx, Ry      : std_logic_vector(7 downto 0);   
    signal GCD_bcd     : std_logic_vector(7 downto 0);  
    signal GCD_internal         : std_logic_vector(7 downto 0); 
    signal load, enA, enB, selA, selB, done : std_logic;
    signal A_eq_B, A_gt_B, A_lt_B           : std_logic;
 
    type bcd_array is array (0 to 1) of std_logic_vector(3 downto 0); -- Two digits
    signal BCD_digits   : bcd_array;
    signal digit_counter: integer range 0 to 1 := 0;  
    signal HEX_OUT      : std_logic_vector(3 downto 0);
    signal SSD_OUT      : std_logic_vector(7 downto 0); 
  
 
    signal start_signal : std_logic; 
    signal COUNTER_OUT_VEC : std_logic_vector(1 downto 0);
      signal COUNTER_OUT : integer range 0 to 3;

begin 
   start_signal <= BUTTON;

    cn <= "1111"; 
    Rx <= sw(7 downto 0);     
    Ry <= sw(15 downto 8);   
 
    clock_div_inst : entity work.Clock_Divider
        Port map (
            clk       => CLK,
            reset     => RESET,    
            clock_out => divided_clk
        );


      Datapath_inst : entity work.GCD_Datapath
    Port map (
        clk     => divided_clk,
        reset   => RESET,
        load    => load,
        enA     => enA,
        enB     => enB,
        selA    => selA,
        selB    => selB,
        Rx      => Rx,
        Ry      => Ry,
        A_eq_B  => A_eq_B,
        A_gt_B  => A_gt_B,
        A_lt_B  => A_lt_B,
        GCD     => GCD_internal  
    );
     
        Controller_inst : entity work.GCD_Controller
            Port map (
                clk     => divided_clk,
                reset   => RESET,
                start   => start_signal,
                A_eq_B  => A_eq_B,
                A_gt_B  => A_gt_B,
                A_lt_B  => A_lt_B,
                load    => load,
                enA     => enA,
                enB     => enB,
                selA    => selA,
                selB    => selB,
                done    => done
            );
            
             BCD_Converter_inst : entity work.Binary_to_BCD
        port map (
            binary_in => GCD_internal,
            bcd_out   => GCD_bcd
        );
        
 
    BCD_digits(0) <= GCD_bcd(3 downto 0);  
    BCD_digits(1) <= GCD_bcd(7 downto 4); 
    
   
     
        Mux2to1_4_inst : entity work.Mux2to1_4
            port map (
                sel => COUNTER_OUT_VEC(0),   
                D0  => BCD_digits(0),
                D1  => BCD_digits(1),
                Y   => HEX_OUT
            );
            
        SSD_Inst: entity work.hex_to_ssd
            port map (
                hex_in          => HEX_OUT,
                ssd_cathode_out => SSD_OUT
            ); 
     demux_inst : entity work.demux
        Port map (
            decoder_select => COUNTER_OUT_VEC,
            decoder_in     => COUNTER_OUT_VEC,
            decoder_out    => an          
        );
 --   ssd_data <= SSD_OUT;
       seg <= SSD_OUT;
    
    end Structural;
