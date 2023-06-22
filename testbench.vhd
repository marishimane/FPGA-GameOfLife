  -- Testbench for OR gate
  library IEEE;
  use IEEE.std_logic_1164.all;

  entity testbench is
  -- empty
  end testbench;

  architecture tb of testbench is

  -- DUT component
  component cell is
      port ( clk : in STD_LOGIC;
             neighbors : in STD_LOGIC_VECTOR (7 downto 0);
             value_i : in std_logic;
             enable_set_i: in std_logic;
             enable_run_i : in std_logic;
             current_state_o : out std_logic);
  end component;

  signal clk : std_logic;
  signal neighbors : std_logic_vector(7 downto 0);
  signal value_i : std_logic;
  signal enable_set_i : std_logic;
  signal enable_run_i : std_logic;
  signal current_state_o : std_logic;


  begin

    -- Connect DUT
    DUT: cell port map(
      clk,
      neighbors,
      value_i,
      enable_set_i,
      enable_run_i,
      current_state_o
    );

    process
    begin
      clk <= '0';
      wait for 10 ns;

      -- setting values
      neighbors <= "00000000";
      value_i <= '0';
      enable_set_i <= '0';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      assert(current_state_o='U') report "Fail 1" severity error;

      clk <= '0';
      value_i <= '1';
      enable_set_i <= '0';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      assert(current_state_o='U') report "Fail 2" severity error;

      clk <= '0';
      value_i <= '1';
      enable_set_i <= '1';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      assert(current_state_o='1') report "Fail 3" severity error;

      clk <= '0';
      value_i <= '0';
      enable_set_i <= '0';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      assert(current_state_o='1') report "Fail 4" severity error;

      -- current_state: DEAD
      -- less than 3 alive neighbors
      neighbors <= "00000100";
      clk <= '0';
      value_i <= '0';
      enable_set_i <= '1';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      enable_run_i <= '1';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      assert(current_state_o='0') report "Fail 5" severity error;

      -- current_state: DEAD
      -- exactly 3 alive neighbors
      neighbors <= "10001100";
      clk <= '0';
      value_i <= '0';
      enable_set_i <= '1';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      enable_run_i <= '1';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      assert(current_state_o='1') report "Fail 6" severity error;

      -- current_state: DEAD
      -- more than 3 alive neighbors
      neighbors <= "11001100";
      clk <= '0';
      value_i <= '0';
      enable_set_i <= '1';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      enable_run_i <= '1';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      assert(current_state_o='0') report "Fail 7" severity failure;

      -- current_state: ALIVe
      -- less than 2 alive neighbors
      neighbors <= "00010000";
      clk <= '0';
      value_i <= '1';
      enable_set_i <= '1';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      enable_run_i <= '1';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;
      assert(current_state_o='0') report "Fail 8" severity failure;

      -- current_state: ALIVe
      -- between [2,3] alive neighbors
      neighbors <= "00010001";
      clk <= '0';
      value_i <= '1';
      enable_set_i <= '1';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      enable_run_i <= '1';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;
      assert(current_state_o='1') report "Fail 9" severity failure;

      -- current_state: ALIVe
      -- more than 3 alive neighbors
      neighbors <= "11011111";
      clk <= '0';
      value_i <= '1';
      enable_set_i <= '1';
      enable_run_i <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;

      enable_run_i <= '1';
      wait for 1 ns;
      clk <= '1';
      wait for 10 ns;
      clk <= '0';
      wait for 10 ns;
      assert(current_state_o='0') report "Fail 10" severity failure;

      wait;
    end process;
  end tb;

