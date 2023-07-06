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

    type board_t is array(2 downto 0) of std_logic_vector(2 downto 0);
    type row is array(2 downto 0) of std_logic_vector(7 downto 0);
    type neighbors_t is array(2 downto 0) of row;

    signal cells_out : board_t;
    signal cells_neighbors : neighbors_t;
    signal cells_values : board_t;

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
    input_cells_values_row: for y in 0 to 2 generate
      input_cells_values_col: for x in 0 to 2 generate
        cells_values(y)(x) <= values(3*y + x);
      end generate input_cells_values_col;
    end generate input_cells_values_row;

    output_cells_row: for y in 0 to 2 generate
      output_cells_col: for x in 0 to 2 generate
        out_o(3*y + x) <= cells_out(y)(x);
      end generate output_cells_col;
    end generate output_cells_row;
    

        cells_neighbors(0)(0)(0) <= '0';
        cells_neighbors(0)(0)(1) <= '0';
        cells_neighbors(0)(0)(2) <= '0';
        cells_neighbors(0)(0)(3) <= '0';
        cells_neighbors(0)(0)(4) <= cells_out(0)(1);
        cells_neighbors(0)(0)(5) <= '0';
        cells_neighbors(0)(0)(6) <= cells_out(1)(0);
        cells_neighbors(0)(0)(7) <= cells_out(1)(1);

        cells_neighbors(0)(2)(0) <= '0';
        cells_neighbors(0)(2)(1) <= '0';
        cells_neighbors(0)(2)(2) <= '0';
        cells_neighbors(0)(2)(3) <= '0';
        cells_neighbors(0)(2)(4) <= cells_out(0)(1);
        cells_neighbors(0)(2)(5) <= '0';
        cells_neighbors(0)(2)(6) <= cells_out(1)(1);
        cells_neighbors(0)(2)(7) <= cells_out(1)(2);


        cells_neighbors(2)(0)(0) <= '0';
        cells_neighbors(2)(0)(1) <= cells_out(1)(0);
        cells_neighbors(2)(0)(2) <= cells_out(1)(1);
        cells_neighbors(2)(0)(3) <= '0';
        cells_neighbors(2)(0)(4) <= cells_out(0)(1);
        cells_neighbors(2)(0)(5) <= '0';
        cells_neighbors(2)(0)(6) <= '0';
        cells_neighbors(2)(0)(7) <= '0';


        cells_neighbors(2)(2)(0) <= cells_out(1)(1);
        cells_neighbors(2)(2)(1) <= cells_out(1)(2);
        cells_neighbors(2)(2)(2) <= '0';
        cells_neighbors(2)(2)(3) <= cells_out(2)(1);
        cells_neighbors(2)(2)(4) <= '0';
        cells_neighbors(2)(2)(5) <= '0';
        cells_neighbors(2)(2)(6) <= '0';
        cells_neighbors(2)(2)(7) <= '0';

    cell_neighbors_top_border: for x in 1 to 1 generate
        cells_neighbors(0)(x)(0) <= '0';
        cells_neighbors(0)(x)(1) <= '0';
        cells_neighbors(0)(x)(2) <= '0';
        cells_neighbors(0)(x)(3) <= cells_out(0)(x-1);
        cells_neighbors(0)(x)(4) <= cells_out(0)(x+1);
        cells_neighbors(0)(x)(5) <= cells_out(1)(x-1);
        cells_neighbors(0)(x)(6) <= cells_out(1)(x);
        cells_neighbors(0)(x)(7) <= cells_out(1)(x+1);
    end generate cell_neighbors_top_border;

    cell_neighbors_bottom_border: for x in 1 to 1 generate
        cells_neighbors(2)(x)(0) <= cells_out(1)(x-1);
        cells_neighbors(2)(x)(1) <= cells_out(1)(x);
        cells_neighbors(2)(x)(2) <= cells_out(1)(x+1);
        cells_neighbors(2)(x)(3) <= cells_out(2)(x-1);
        cells_neighbors(2)(x)(4) <= cells_out(2)(x+1);
        cells_neighbors(2)(x)(5) <= '0';
        cells_neighbors(2)(x)(6) <= '0';
        cells_neighbors(2)(x)(7) <= '0';
    end generate cell_neighbors_bottom_border;

    cell_neighbors_left_border: for y in 1 to 1 generate
        cells_neighbors(y)(0)(0) <= '0';
        cells_neighbors(y)(0)(1) <= cells_out(y-1)(0);
        cells_neighbors(y)(0)(2) <= cells_out(y-1)(1);
        cells_neighbors(y)(0)(3) <= '0';
        cells_neighbors(y)(0)(4) <= cells_out(y)(1);
        cells_neighbors(y)(0)(5) <= '0';
        cells_neighbors(y)(0)(6) <= cells_out(y+1)(0);
        cells_neighbors(y)(0)(7) <= cells_out(y+1)(1);
    end generate cell_neighbors_left_border;

    cell_neighbors_right_border: for y in 1 to 1 generate
        cells_neighbors(y)(2)(0) <= cells_out(y-1)(1);
        cells_neighbors(y)(2)(1) <= cells_out(y-1)(2);
        cells_neighbors(y)(2)(2) <= '0';
        cells_neighbors(y)(2)(3) <= cells_out(y)(1);
        cells_neighbors(y)(2)(4) <= '0';
        cells_neighbors(y)(2)(5) <= cells_out(y+1)(1);
        cells_neighbors(y)(2)(6) <= cells_out(y+1)(2);
        cells_neighbors(y)(2)(7) <= '0';
    end generate cell_neighbors_right_border;


    cell_neighbors_rows: for y in 1 to 1 generate
      cell_neighbors_cols: for x in 1 to 1 generate
        cells_neighbors(y)(x)(0) <= cells_out(y-1)(x-1);
        cells_neighbors(y)(x)(1) <= cells_out(y-1)(x  );
        cells_neighbors(y)(x)(2) <= cells_out(y-1)(x+1);
        cells_neighbors(y)(x)(3) <= cells_out(y  )(x-1);
        cells_neighbors(y)(x)(4) <= cells_out(y  )(x+1);
        cells_neighbors(y)(x)(5) <= cells_out(y+1)(x-1);
        cells_neighbors(y)(x)(6) <= cells_out(y+1)(x  );
        cells_neighbors(y)(x)(7) <= cells_out(y+1)(x+1);
      end generate cell_neighbors_cols;
    end generate cell_neighbors_rows;

    cell_rows: for y in 0 to 2 generate
      cell_cols: for x in 0 to 2 generate
        cell_y_x: entity work.cell
          port map(
            clk => clk,
            value_i => cells_values(y)(x),
            enable_set_i => enable_set,
            enable_run_i => enable_run,
            neighbors => cells_neighbors(y)(x),
            current_state_o => cells_out(y)(x)
        );

      end generate cell_cols;
    end generate cell_rows;
end Behavioral;
