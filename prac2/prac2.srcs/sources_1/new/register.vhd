library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_example is
    port(
        -- In the .xdc file these inputs and outputs
        -- will correspond to the physical switches, buttons
        -- and LEDs on the FPGA development board
        d_in : in std_logic_vector(3 downto 0);
        clk_in : in std_logic;
        clk_en_in : in std_logic;
        reset_in : in std_logic;
        q_out : out std_logic_vector(3 downto 0)
    );
end register_example;

architecture Behavioral of register_example is

signal reg : std_logic_vector(3 downto 0) := (others => '0');

begin
process (clk_in, reset_in) 
begin
    if reset_in = '1' then
        reg <= "1110";  -- Reset value
    elsif (clk_in'event and clk_in = '1' and clk_en_in = '1') then
        reg <= d_in;
    end if;
end process;

q_out <= reg;

end Behavioral;