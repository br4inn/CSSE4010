----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2024 20:53:35
-- Design Name: 
-- Module Name: Full_Subtractor - Dataflow
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


entity Full_Subtractor is
  Port ( 
    A   : in std_logic;
    B   : in std_logic;
    Bin : in std_logic;
    diff: out std_logic;
    Bout: out std_logic
  
  );
end Full_Subtractor;

architecture Dataflow of Full_Subtractor is

begin

    diff <= A xor B xor Bin;
    Bout <= ((not A and B) or (B and Bin) or (not A and Bin));

end Dataflow;
