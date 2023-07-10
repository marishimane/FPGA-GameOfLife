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
    signal enable_set : std_logic := '0';
	signal enable_run : std_logic := '0';

    signal value : std_logic := '0';
    signal in_x : std_logic_vector(0 to N-1) := (others => '0');
    signal in_y : std_logic_vector(0 to N-1) := (others => '0');
    
    --Outputs
	signal out_o : std_logic;
    
    -- Clock period definitions
    constant clk_period : time := 1 us;
    
    begin
    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.board
      port map (clk => clk_i,
                enable_set => enable_set,
                enable_run => enable_run,
                in_x => in_x,
                in_y => in_y,

                value => value,
                out_o => out_o
                );

    -- clk_process : process
    -- begin

    CLOCK:
    process 
    begin
        enable_set <= '0';

        -- Glider initialization
        enable_set <= '1';
        value <= '1';

        in_x <= std_logic_vector(to_unsigned(1, in_x'length));
        in_y <= std_logic_vector(to_unsigned(0, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        in_x <= std_logic_vector(to_unsigned(2, in_x'length));
        in_y <= std_logic_vector(to_unsigned(1, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        in_x <= std_logic_vector(to_unsigned(0, in_x'length));
        in_y <= std_logic_vector(to_unsigned(2, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        in_x <= std_logic_vector(to_unsigned(1, in_x'length));
        in_y <= std_logic_vector(to_unsigned(2, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        in_x <= std_logic_vector(to_unsigned(2, in_x'length));
        in_y <= std_logic_vector(to_unsigned(2, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        enable_set <= '0';
        enable_run <= '1';

        -- # 1
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        -- # 2
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        -- # 3
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        -- # 4
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        clk_i <= '0';
        wait for 10 ns;

        enable_set <= '0';
        enable_run <= '0';

        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(0, in_x'length));
        in_y <= std_logic_vector(to_unsigned(0, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=0, y=0" severity failure;

        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(1, in_x'length));
        in_y <= std_logic_vector(to_unsigned(0, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=1, y=0" severity failure;

        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(2, in_x'length));
        in_y <= std_logic_vector(to_unsigned(0, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=2, y=0" severity failure;

        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(3, in_x'length));
        in_y <= std_logic_vector(to_unsigned(0, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=3, y=0" severity failure;

        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(0, in_x'length));
        in_y <= std_logic_vector(to_unsigned(1, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=0, y=1" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(1, in_x'length));
        in_y <= std_logic_vector(to_unsigned(1, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=1, y=1" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(2, in_x'length));
        in_y <= std_logic_vector(to_unsigned(1, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='1') report "Fail x=2, y=1" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(3, in_x'length));
        in_y <= std_logic_vector(to_unsigned(1, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=3, y=1" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(0, in_x'length));
        in_y <= std_logic_vector(to_unsigned(2, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=0, y=2" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(1, in_x'length));
        in_y <= std_logic_vector(to_unsigned(2, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=1, y=2" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(2, in_x'length));
        in_y <= std_logic_vector(to_unsigned(2, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=2, y=2" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(3, in_x'length));
        in_y <= std_logic_vector(to_unsigned(2, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='1') report "Fail x=3, y=2" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(0, in_x'length));
        in_y <= std_logic_vector(to_unsigned(3, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='0') report "Fail x=0, y=3" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(1, in_x'length));
        in_y <= std_logic_vector(to_unsigned(3, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='1') report "Fail x=1, y=3" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(2, in_x'length));
        in_y <= std_logic_vector(to_unsigned(3, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='1') report "Fail x=2, y=3" severity failure;
        -- # Assert 0
        in_x <= std_logic_vector(to_unsigned(3, in_x'length));
        in_y <= std_logic_vector(to_unsigned(3, in_x'length));
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;
        assert(out_o='1') report "Fail x=3, y=3" severity failure;

        /*
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
        */
        wait;
    end process;
    -- end process;


end tester_architecture;
