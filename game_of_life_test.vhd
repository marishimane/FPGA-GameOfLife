library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity tester is

end tester;

architecture tester_architecture of tester is
    constant N : natural := 16;

    --Inputs
    signal clk_i : std_logic := '1';
    signal iterations : integer := 0;
	signal en_iter_write : std_logic := '0';
    signal out_remaining_iter : integer := 0;


    -- Clock period definitions
    constant clk_period : time := 1 us;
    
    begin
    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.game_of_life
      port map (clk => clk_i,
                iterations => iterations,
                en_iter_write => en_iter_write,
                out_remaining_iter => out_remaining_iter
                );

    -- clk_process : process
    -- begin

    CLOCK:
    process 
    begin
        iterations <= 4;
        en_iter_write <= '1';
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        en_iter_write <= '0';
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

        wait;
    end process;
    -- end process;


end tester_architecture;

