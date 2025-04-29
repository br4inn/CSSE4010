library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port (
        cout : out STD_LOGIC;
        s    : out STD_LOGIC;
        a    : in  STD_LOGIC;
        b    : in  STD_LOGIC;
        cin  : in  STD_LOGIC
    );
end full_adder;

architecture Behavioral of full_adder is
begin
    -- Full adder logic
    s    <= (a xor b) xor cin;
    cout <= (a and b) or ((a xor b) and cin);

end Behavioral;
