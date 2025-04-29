library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_register is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           parallel_in: in STD_LOGIC_VECTOR(15 downto 0);
           serial_out : out STD_LOGIC);
end shift_register;

architecture Behavioral of shift_register is
    signal shift_reg : STD_LOGIC_VECTOR(15 downto 0);
begin
    -- Process to shift bits out serially
    process(clk, rst)
    begin
        if rst = '1' then
            shift_reg <= (others => '0');
            serial_out <= '0';
        elsif rising_edge(clk) then
            if load = '1' then
                shift_reg <= parallel_in;  -- Load parallel input into register
            else
                shift_reg <= shift_reg(14 downto 0) & '0';  -- Shift left
                serial_out <= shift_reg(15);  -- Output MSB
            end if;
        end if;
    end process;
end Behavioral;