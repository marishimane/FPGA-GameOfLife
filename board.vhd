library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cell;

entity board is
    port (
        clk : in STD_LOGIC;
        values : in STD_LOGIC_VECTOR(0 to 8);
        enable_set : in STD_LOGIC;
        enable_run : in std_logic;
        out_o : out STD_LOGIC_VECTOR(0 to 8)
    );
end board;

architecture Behavioral of board is
    signal cell_1_out : std_logic;
    signal cell_2_out : std_logic;
    signal cell_3_out : std_logic;
    signal cell_4_out : std_logic;
    signal cell_5_out : std_logic;
    signal cell_6_out : std_logic;
    signal cell_7_out : std_logic;
    signal cell_8_out : std_logic;
    signal cell_9_out : std_logic;

    signal neighbors1 : std_logic_vector(7 downto 0);
	signal neighbors2 : std_logic_vector(7 downto 0);
	signal neighbors3 : std_logic_vector(7 downto 0);
	signal neighbors4 : std_logic_vector(7 downto 0);
	signal neighbors5 : std_logic_vector(7 downto 0);
	signal neighbors6 : std_logic_vector(7 downto 0);
	signal neighbors7 : std_logic_vector(7 downto 0);
	signal neighbors8 : std_logic_vector(7 downto 0);
	signal neighbors9 : std_logic_vector(7 downto 0);
    
begin
    out_o(0) <= cell_1_out;
    out_o(1) <= cell_2_out;
    out_o(2) <= cell_3_out;
    out_o(3) <= cell_4_out;
    out_o(4) <= cell_5_out;
    out_o(5) <= cell_6_out;
    out_o(6) <= cell_7_out;
    out_o(7) <= cell_8_out;
    out_o(8) <= cell_9_out;

    neighbors1 <= (
      '0', '0', '0',
      '0', cell_2_out,
      '0', cell_4_out, cell_5_out
    );
    neighbors2 <= (
      '0', '0', '0',
      cell_1_out, cell_3_out,
      cell_4_out, cell_5_out, cell_6_out
    );
    neighbors3 <= (
      '0', '0', '0',
      cell_2_out, '0',
      cell_5_out, cell_6_out, '0'
    );
    neighbors4 <= (
      '0', cell_1_out, cell_2_out,
      '0', cell_5_out,
      '0', cell_7_out, cell_8_out
    );
    neighbors5 <= (
      cell_1_out, cell_2_out, cell_3_out,
      cell_4_out, cell_6_out,
      cell_7_out, cell_8_out, cell_9_out
    );
    neighbors6 <= (
      cell_2_out, cell_3_out, '0',
      cell_5_out, '0',
      cell_8_out, cell_9_out, '0'
    );
    neighbors7 <= (
      '0', cell_4_out, cell_5_out,
      '0', cell_8_out,
      '0', '0', '0'
    );
    neighbors8 <= (
      cell_4_out, cell_5_out, cell_6_out,
      cell_7_out, cell_9_out,
      '0', '0', '0'
    );
    neighbors9 <= (
      cell_5_out, cell_6_out, '0',
      cell_8_out, '0',
      '0', '0', '0'
    );

    CELL1: entity work.cell
        port map(
            clk => clk,
            value_i => values(0),
            enable_set_i => enable_set,
            enable_run_i => enable_run,
            neighbors => neighbors1,
            current_state_o => cell_1_out
        );
    CELL2: entity work.cell
        port map(
            clk => clk,
            value_i => values(1),
            enable_set_i => enable_set,
            enable_run_i => enable_run,
            neighbors => neighbors2,
            current_state_o => cell_2_out
        );
    CELL3: entity work.cell
        port map(
            clk => clk,
            value_i => values(2),
            enable_set_i => enable_set,
            enable_run_i => enable_run,
            neighbors => neighbors3,
            current_state_o => cell_3_out
        );
    CELL4: entity work.cell
      port map(
          clk => clk,
          value_i => values(3),
          enable_set_i => enable_set,
          enable_run_i => enable_run,
          neighbors => neighbors4,
          current_state_o => cell_4_out
      );
    CELL5: entity work.cell
        port map(
            clk => clk,
            value_i => values(4),
            enable_set_i => enable_set,
            enable_run_i => enable_run,
            neighbors => neighbors5,
            current_state_o => cell_5_out
        );
    CELL6: entity work.cell
      port map(
          clk => clk,
          value_i => values(5),
          enable_set_i => enable_set,
          enable_run_i => enable_run,
          neighbors => neighbors6,
          current_state_o => cell_6_out
      );
    CELL7: entity work.cell
      port map(
          clk => clk,
          value_i => values(6),
          enable_set_i => enable_set,
          enable_run_i => enable_run,
          neighbors => neighbors7,
          current_state_o => cell_7_out
      );
    CELL8: entity work.cell
      port map(
          clk => clk,
          value_i => values(7),
          enable_set_i => enable_set,
          enable_run_i => enable_run,
          neighbors => neighbors8,
          current_state_o => cell_8_out
      );
    CELL9: entity work.cell
      port map(
          clk => clk,
          value_i => values(8),
          enable_set_i => enable_set,
          enable_run_i => enable_run,
          neighbors => neighbors9,
          current_state_o => cell_9_out
      );
    
end Behavioral;
