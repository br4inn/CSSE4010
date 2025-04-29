library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity MUX is
 port(
 
     A,B,C,D : in STD_LOGIC_vector(3 downto 0);
     S0,S1: in STD_LOGIC;
     Z: out STD_LOGIC_vector(3 downto 0)
  );
end MUX;
 
architecture bhv of MUX is
begin
process (A,B,C,D,S0,S1) is
begin
  if (S0 ='0' and S1 = '0') then
      Z <= A;                   -- select input A based on select lines
  elsif (S0 ='1' and S1 = '0') then
      Z <= B;                       --select input B
  elsif (S0 ='0' and S1 = '1') then
      Z <= C;
  else
      Z <= D;
  end if;
 
end process;
end bhv;
