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
    signal en_cell_write : std_logic := '0';
    signal in_value : std_logic;
    signal in_x : integer range 0 to N-1;
    signal in_y : integer range 0 to N-1;

    signal in_run_simulation : std_logic := '0';
    signal out_cell_value : std_logic;

    signal out_remaining_iter : integer;


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
                in_x => in_x,
                in_y => in_y,

                in_run_simulation => in_run_simulation,

                out_cell_value => out_cell_value,
                out_remaining_iter => out_remaining_iter
                );

    -- clk_process : process
    -- begin
    initial_values  <= "0110011111011101101001010001111001011011110000011110111101011011011110101000000000100111000110000110110100100000101100101100111010001011001101001101001101000011111110010110000011111010001011100111001001011000010111111001111000000010001100000011101101110001";
    expected_output <= "0000000011010000000000001101000000000000100100110000000110110100000000011011110100000000100101010000000001100110000000000001001100000000100110110000001001011001000000110100011100000011100111100000000000001000000001000000110000000000000011000000010110000100";

    CLOCK:
    process
      variable var_in_x : integer range 0 to N := 0;
      variable var_in_y : integer range 0 to N := 0;
    begin
        -- Set iterations
        iterations <= 3;
        en_iter_write <= '1';
        clk_i <= '0';
        wait for 10 ns;
        clk_i <= '1';
        wait for 10 ns;

        -- Set cell inital values
        en_iter_write <= '0';
        en_cell_write <= '1';
        var_in_x := 0;
        var_in_y := 0;
        while(var_in_y < N) loop
          var_in_x := 0;
          while(var_in_x < N) loop
            in_x <= var_in_x;
            in_y <= var_in_y;
            -- report "WRITE in_x: " & integer'image(in_x);
            -- report "WRITE var_in_x: " & integer'image(var_in_x);
            -- report "WRITE in_y: " & integer'image(in_y);
            -- report "WRITE var_in_y: " & integer'image(var_in_y);
            in_value <= initial_values(var_in_y*N + var_in_x);
            clk_i <= '0';
            wait for 10 ns;
            clk_i <= '1';
            wait for 10 ns;

            var_in_x := var_in_x + 1;
          end loop;
          var_in_y := var_in_y + 1;
        end loop;
        en_cell_write <= '0';
        -- TODO

        -- Enable simulation
        in_run_simulation <= '1';

        while(out_remaining_iter > 0) loop
          -- report "out_remaining_iter: " & integer'image(out_remaining_iter);
          clk_i <= '0';
          wait for 10 ns;
          clk_i <= '1';
          wait for 10 ns;
        end loop;

        -- Check output
        var_in_x := 0;
        var_in_y := 0;

        report "Checking output";
        
        while(var_in_y < N) loop
          var_in_x := 0;
          while(var_in_x < N) loop
            in_x <= var_in_x;
            in_y <= var_in_y;
            -- report "var_in_x: " & integer'image(var_in_x);
            -- report "var_in_y: " & integer'image(var_in_y);
            -- report "out_cell_value: " & std_logic'image(out_cell_value);
            -- report "expected_output: " & std_logic'image(expected_output(in_y*N + in_x));
            assert(out_cell_value=expected_output(in_y*N + in_x) ) report "Fail" severity failure;
            clk_i <= '0';
            wait for 10 ns;
            clk_i <= '1';
            wait for 10 ns;

            var_in_x := var_in_x + 1;
          end loop;
          var_in_y := var_in_y + 1;
        end loop;

        wait;

      -- Wait for simulation
      -- Read values and assert
    end process;
    -- end process;


end tester_architecture;

