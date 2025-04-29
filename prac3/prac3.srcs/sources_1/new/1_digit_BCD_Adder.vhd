----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.08.2024 12:43:44
-- Design Name: 
-- Module Name: 1_digit_BCD_Adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity 1DigitBCDAdder is
    port(
    A, B : in unsigned(3 downto 0);
    sum : out unsigned (3 downto 0);
    carry in
    carryOut : out std_logic
    );
    
    end 1DigitBCDAdder;

architecture Behavioral of 1DigitBCDAdder is

begin

process(A, B)
variable temp : unsigned(4 downto 0);
begin
    if A + B +C> 9
    temp = A+B+6
    sum <= temp
    end if;
    end process;
end Behavioral;
