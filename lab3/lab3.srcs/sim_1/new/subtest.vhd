library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Header_tb is
end Header_tb;

architecture Behavioral of Header_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component Header
    Port (
        CLK           : in  std_logic;
        RESET         : in  std_logic;
        sw            : in  std_logic_vector(15 downto 0);
        BUTTON        : in  std_logic;
        seg           : out std_logic_vector(7 downto 0);
        MUX_OUT       : out std_logic_vector(3 downto 0);
        an            : out std_logic_vector(3 downto 0);
        cn            : out std_logic_vector(3 downto 0);
        LED1          : out std_logic;
        total_sum_out : out integer   -- Single output for the total sum
    );
    end component;

    -- Signals to connect to the UUT
    signal CLK        : std_logic := '0';
    signal RESET      : std_logic := '0';
    signal sw         : std_logic_vector(15 downto 0);
    signal BUTTON     : std_logic;
    signal seg        : std_logic_vector(7 downto 0);
    signal MUX_OUT    : std_logic_vector(3 downto 0);
    signal an         : std_logic_vector(3 downto 0);
    signal cn         : std_logic_vector(3 downto 0);
    signal LED1       : std_logic;
    signal total_sum_out : integer;

    -- Clock generation
    constant clk_period : time := 10 ns;
begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Header
        Port map (
            CLK => CLK,
            RESET => RESET,
            sw => sw,
            BUTTON => BUTTON,
            seg => seg,
            MUX_OUT => MUX_OUT,
            an => an,
            cn => cn,
            LED1 => LED1,
            total_sum_out => total_sum_out
        );

    -- Clock process definitions
    CLK_process :process
    begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin	
        -- Reset the system
     ----   RESET <= '1';
      --  wait for 20 ns;
    --    RESET <= '0';
     --   wait for 20 ns;

        
        sw <= "0010100000010000"; --  
        BUTTON <= '1';            -- Addition mode
        wait for 100 ns;
        
        -- 22 - 1
        sw <= "0010001000000001";   
        BUTTON <= '1';            -- Addition mode
        wait for 100 ns;
        
        -- Output the total sum
    --    report "Case 2 - P = 33, Q = 18, Total Sum: " & integer'image(total_sum_out);
        
        wait; -- Wait forever
    end process;

end Behavioral;
