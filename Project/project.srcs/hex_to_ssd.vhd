library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hex_to_ssd is
    Port ( hex_in : in STD_LOGIC_VECTOR(3 downto 0);
           ssd_cathode_out : out STD_LOGIC_VECTOR(7 downto 0));
end hex_to_ssd;

architecture Dataflow of hex_to_ssd is

 
subtype cathode_out_t is std_logic_vector(7 downto 0);

-- Set up Numbers and Letters segments for SSD
-- First index is G Segment
-- 0th index is DP Segment  -- H is dp
-- Active Low                        
constant ZERO   : cathode_out_t := B"1100_0000";
constant ONE    : cathode_out_t := B"1111_1001";
constant TWO    : cathode_out_t := B"1010_0100"; 
constant THREE  : cathode_out_t := B"1011_0000"; 
constant FOUR   : cathode_out_t := B"1001_1001"; 
constant FIVE   : cathode_out_t := B"1001_0010"; 
constant SIX    : cathode_out_t := B"1000_0010"; 
constant SEVEN  : cathode_out_t := B"1111_1000"; 
constant EIGHT  : cathode_out_t := B"1000_0000"; 
constant NINE   : cathode_out_t := B"1001_1000"; 
constant E      : cathode_out_t := B"1000_0110";
begin

ssd_cathode_out <=  ZERO    when hex_in = X"0"  else
                    ONE     when hex_in = X"1"  else
                    TWO     when hex_in = X"2"  else
                    THREE   when hex_in = X"3"  else
                    FOUR    when hex_in = X"4"  else
                    FIVE    when hex_in = X"5"  else
                    SIX     when hex_in = X"6"  else
                    SEVEN   when hex_in = X"7"  else
                    EIGHT   when hex_in = X"8"  else
                    NINE    when hex_in = X"9"  else
                    E       when hex_in = X"E"  else
                    X"11";                        

end Dataflow;