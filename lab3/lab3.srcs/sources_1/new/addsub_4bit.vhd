library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addsub_4bit is
    Port (
        cout : out STD_LOGIC;             -- Carry out or borrow out
        s    : out STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit sum/difference
        a    : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input A
        b    : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input B
        cin  : in  STD_LOGIC;              -- Carry in or borrow in
        op   : in  STD_LOGIC               -- Operation: 0 for add, 1 for subtract
    );
end addsub_4bit;

architecture Behavioral of addsub_4bit is
    signal bin : STD_LOGIC_VECTOR(3 downto 0);   -- B input after XOR with op
    signal carry : STD_LOGIC_VECTOR(4 downto 1); -- Carry signals between full adders
    signal sum : STD_LOGIC_VECTOR(4 downto 0);   -- Intermediate 5-bit sum
begin

    -- XOR operation for subtraction: bin = b XOR op
    bin(0) <= b(0) xor op;
    bin(1) <= b(1) xor op;
    bin(2) <= b(2) xor op;
    bin(3) <= b(3) xor op;

    -- Instantiate full adders
    FA0: entity work.full_adder
        port map (cout => carry(1), s => sum(0), a => a(0), b => bin(0), cin => cin);

    FA1: entity work.full_adder
        port map (cout => carry(2), s => sum(1), a => a(1), b => bin(1), cin => carry(1));

    FA2: entity work.full_adder
        port map (cout => carry(3), s => sum(2), a => a(2), b => bin(2), cin => carry(2));

    FA3: entity work.full_adder
        port map (cout => carry(4), s => sum(3), a => a(3), b => bin(3), cin => carry(3));

    -- Correction logic
    process(sum)
    begin
        if (unsigned(sum(3 downto 0)) > 9) then
            s <= std_logic_vector(unsigned(sum(3 downto 0)) + 6);
            cout <= '1';
        else
            s <= sum(3 downto 0);
            cout <= carry(4);
        end if;
    end process;

end Behavioral;
