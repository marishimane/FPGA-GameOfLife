library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity tester is

end tester;

architecture tester_architecture of tester is
    constant N : natural := 16;

    -- Initial values
    signal initial_values : std_logic_vector(0 to (N*N- 1));

    -- Expected output
    signal expected_output : std_logic_vector(0 to (N*N- 1));

    --Inputs
    signal clk_i : std_logic := '1';
    signal iterations : integer := 0;
	signal en_iter_write : std_logic := '0';
    signal en_cell_write : STD_LOGIC;
    signal in_value : STD_LOGIC;
    signal in_rx : integer := 0;
    signal in_ry : integer := 0;

    signal in_run_simulation : STD_LOGIC;
    signal out_cell_value : STD_LOGIC;

    signal out_remaining_iter : integer := 0;


    -- Clock period definitions
    constant clk_period : time := 1 us;
    
    begin
    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.game_of_life
      port map (clk => clk_i,
                iterations => iterations,
                en_iter_write => en_iter_write,

                en_cell_write => en_cell_write,
                in_value => in_value,
                in_rx => in_rx,
                in_ry => in_ry,

                in_run_simulation => in_run_simulation,

                out_cell_value => out_cell_value,
                out_remaining_iter => out_remaining_iter
                );

    -- clk_process : process
    -- begin
    initial_values <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    expected_output <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    CLOCK:
    process 
      variable var_in_rx : integer := 0;
      variable var_in_ry : integer := 0;
    begin
        in_rx <= var_in_rx;
        in_ry <= var_in_ry;
        -- Set iterations
        iterations <= 4;
        en_iter_write <= '1';
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        -- Set cell inital values
        en_iter_write <= '0';
        en_cell_write <= '1';
        var_in_rx := 0;
        var_in_ry := 0;
        while(var_in_ry < N) loop
          var_in_rx := 0;
          while(var_in_rx < N) loop
            in_value <= initial_values(var_in_ry*N + var_in_rx);
            clk_i <= '0';
            wait for 10 ns;
            clk_i <= '1';
            wait for 10 ns;

            var_in_rx := var_in_rx + 1;
          end loop;
          var_in_ry := var_in_ry + 1;
        end loop;
        en_cell_write <= '0';
        -- TODO

        -- Enable simulation
        in_run_simulation <= '1';

        while(out_remaining_iter > 0) loop
          clk_i <= '0';
          wait for 10 ns;
          clk_i <= '1';
          wait for 10 ns;
        end loop;

        while(out_remaining_iter > 0) loop
          clk_i <= '0';
          wait for 10 ns;
          clk_i <= '1';
          wait for 10 ns;
        end loop;


        -- Check output
        var_in_rx := 0;
        var_in_ry := 0;
        while(var_in_ry < N) loop
          var_in_rx := 0;
          while(var_in_rx < N) loop
            assert(out_cell_value=expected_output(var_in_ry*N + var_in_rx) ) report "Fail" severity failure;
            clk_i <= '0';
            wait for 10 ns;
            clk_i <= '1';
            wait for 10 ns;

            var_in_rx := var_in_rx + 1;
          end loop;
          var_in_ry := var_in_ry + 1;
        end loop;

        wait;

      -- Wait for simulation
      -- Read values and assert
    end process;
    -- end process;


end tester_architecture;

