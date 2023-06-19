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
           initial_state : in STD_LOGIC;
           reset_i: in STD_LOGIC;
           current_state_o : out STD_LOGIC);
end component;

signal clk : std_logic;
signal neighbors : std_logic_vector(7 downto 0);
signal initial_state : std_logic;
signal reset_i : std_logic;
signal current_state_o : std_logic;

begin

  -- Connect DUT
  DUT: cell port map(
  	clk,
    neighbors,
    initial_state,
    reset_i,
    current_state_o
  );

  process
  begin
    clk <= '0';
    wait for 10 ns;

	-- current_state: DEAD
    -- less than 3 alive neighbors
    neighbors <= "00000000";
    initial_state <= '0';
	reset_i <= '1';
    wait for 1 ns;
    clk <= '1';

    wait for 10 ns;
    clk <= '0';
    wait for 10 ns;
    assert(current_state_o='0') report "Fail 1" severity error;

    reset_i <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 10 ns;
    clk <= '0';
    wait for 10 ns;

    assert(current_state_o='0') report "Fail 2" severity error;
    
    
    -- current_state: DEAD
    -- exactly 3 alive neighbors
    neighbors <= "10001100";
    initial_state <= '0';
	reset_i <= '1';
    wait for 1 ns;
    clk <= '1';

    wait for 10 ns;
    reset_i <= '0';
    wait for 1 ns;
    clk <= '0';
    wait for 10 ns;
    assert(current_state_o='1') report "Fail 3" severity error;
    
    -- current_state: DEAD
    -- more than 3 alive neighbors
    neighbors <= "11001100";
    initial_state <= '0';
	reset_i <= '1';
    wait for 1 ns;
    clk <= '1';

    wait for 10 ns;
    reset_i <= '0';
    wait for 1 ns;
    clk <= '0';
    wait for 10 ns;
    assert(current_state_o='0') report "Fail 4" severity failure;
    
    -- current_state: ALIVe
    -- less than 2 alive neighbors
    neighbors <= "00010000";
    initial_state <= '1';
	reset_i <= '1';
    wait for 1 ns;
    clk <= '1';

    wait for 10 ns;
    reset_i <= '0';
    wait for 1 ns;
    clk <= '0';
    wait for 10 ns;
    assert(current_state_o='0') report "Fail 5" severity failure;
    
    -- current_state: ALIVe
    -- between [2,3] alive neighbors
    neighbors <= "00010001";
    initial_state <= '1';
	reset_i <= '1';
    wait for 1 ns;

    clk <= '1';

    wait for 10 ns;
    reset_i <= '0';
    wait for 1 ns;
    clk <= '0';
    wait for 10 ns;
    assert(current_state_o='1') report "Fail 6" severity failure;

    -- current_state: ALIVe
    -- more than 3 alive neighbors
    neighbors <= "11011111";
    initial_state <= '1';
	reset_i <= '1';
    wait for 1 ns;
    clk <= '1';

    wait for 10 ns;
    reset_i <= '0';
    wait for 1 ns;
    clk <= '0';
    wait for 10 ns;
    assert(current_state_o='0') report "Fail 7" severity failure;

    wait;
  end process;
end tb;
