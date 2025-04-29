----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2024 20:48:58
-- Design Name: 
-- Module Name: Full_Adder - Dataflow
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


entity Full_Adder is
  Port ( 
    A   : in std_logic;
    B   : in std_logic;
    Cin : in std_logic;
    sum : out std_logic;
    Cout: out std_logic
  );
end Full_Adder;

architecture Dataflow of Full_Adder is

    signal D: std_logic;

begin

    D <= A xor B;
    sum <= Cin xor D;
    Cout <= (D and Cin) or ((not D) and A);

end Dataflow;
