library IEEE;
library work;
use IEEE.std_logic_1164.all;

entity tester is

end tester;

architecture tester_architecture of tester is

    --Inputs
    signal clk_i : std_logic := '1';
	signal values: std_logic_vector(0 to 255);
    signal enable_set : std_logic := '0';
	signal enable_run : std_logic := '0';
    
    --Outputs
	signal out_o : std_logic_vector(0 to 255);
    
    -- Clock period definitions
    constant clk_period : time := 1 us;
    
    begin
    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.board
      port map (clk => clk_i,
                values => values,
                enable_set => enable_set,
                enable_run => enable_run,
                out_o => out_o
                );

    -- clk_process : process
    -- begin

    values <= "1001010010101100011010010110100111010100100110100010110100110101100100110100110001101001101001101101010011010011001010110010110110010100100101100110101101101001110100101001101000101101001101011001001101001100011010011010011011010100110100110010101100101101";

    CLOCK:
    process 
    begin
        enable_set <= '1';

        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        clk_i <= '0';
        wait for 10 ns;
        enable_set <= '0';
        enable_run <= '1';
        wait for 10 ns;

        clk_i <= '1';
        wait for 10 ns;
        clk_i <= '0';
        wait for 10 ns;

        clk_i <= '1';
        wait for 10 ns;
        clk_i <= '0';
        wait for 10 ns;

        clk_i <= '1';
        wait for 10 ns;
        clk_i <= '0';
        wait for 10 ns;

        clk_i <= '1';
        wait for 10 ns;
        clk_i <= '0';
        wait for 10 ns;
        wait;
    end process;
    -- end process;


end tester_architecture;
