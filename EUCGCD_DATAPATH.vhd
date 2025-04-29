-- GCD Datapath
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GCD_Datapath is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        load    : in  std_logic;
        enA     : in  std_logic;
        enB     : in  std_logic;
        selA    : in  std_logic;
        selB    : in  std_logic;
        Rx      : in  std_logic_vector(7 downto 0);
        Ry      : in  std_logic_vector(7 downto 0);
        A_eq_B  : out std_logic;
        A_gt_B  : out std_logic;
        A_lt_B  : out std_logic;
        GCD     : out std_logic_vector(7 downto 0)
    );
end GCD_Datapath;

architecture Behavioral of GCD_Datapath is
    signal A_reg, B_reg : std_logic_vector(7 downto 0);
    signal A_in, B_in   : std_logic_vector(7 downto 0);
    signal A_minus_B, B_minus_A : std_logic_vector(7 downto 0);
begin 

    RegA : entity work.Register8
        Port map (
            clk   => clk,
            reset => reset,
            en    => enA,
            D     => A_in,
            Q     => A_reg
        );

    RegB : entity work.Register8
        Port map (
            clk   => clk,
            reset => reset,
            en    => enB,
            D     => B_in,
            Q     => B_reg
        );

    -- Instantiate Subtractors
    SubA_minus_B : entity work.Subtractor8
        Port map (
            A => A_reg,
            B => B_reg,
            Y => A_minus_B
        );

    SubB_minus_A : entity work.Subtractor8
        Port map (
            A => B_reg,
            B => A_reg,
            Y => B_minus_A
        );
 
    Comp : entity work.Comparator8
        Port map (
            A      => A_reg,
            B      => B_reg,
            A_eq_B => A_eq_B,
            A_gt_B => A_gt_B,
            A_lt_B => A_lt_B
        );
 
    MuxA : entity work.Mux2to1_8
        Port map (
            sel => selA,
            D0  => Rx,
            D1  => A_minus_B,
            Y   => A_in
        );

    MuxB : entity work.Mux2to1_8
        Port map (
            sel => selB,
            D0  => Ry,
            D1  => B_minus_A,
            Y   => B_in
        );
 
    GCD <= A_reg;

end Behavioral;
