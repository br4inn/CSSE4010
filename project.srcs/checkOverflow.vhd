library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OverflowDetector is
    Port ( Rx : in  STD_LOGIC_VECTOR (7 downto 0);
           Ry : in  STD_LOGIC_VECTOR (7 downto 0);
           Sum : in  STD_LOGIC_VECTOR (7 downto 0);
           Overflow : out STD_LOGIC );
end OverflowDetector;

architecture Behavioral of OverflowDetector is
begin
    Overflow <= (Rx(7) and Ry(7) and not Sum(7)) or (not Rx(7) and not Ry(7) and Sum(7));
end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FullAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is
begin 
    Sum <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end Behavioral;