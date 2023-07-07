library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cell;

entity board is
    generic(N : natural := 16);
    port (
        clk : in STD_LOGIC;
        values : in STD_LOGIC_VECTOR(0 to (N*N - 1) );
        enable_set : in STD_LOGIC;
        enable_run : in std_logic;
        out_o : out STD_LOGIC_VECTOR(0 to (N*N - 1) )
    );
end board;

architecture Behavioral of board is
    type board_t is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
    type row is array(N-1 downto 0) of std_logic_vector(7 downto 0);
    type neighbors_t is array(N-1 downto 0) of row;

    signal cells_out : board_t;
    signal cells_neighbors : neighbors_t;
    signal cells_values : board_t;

begin
    input_cells_values_row: for y in 0 to (N-1) generate
      input_cells_values_col: for x in 0 to (N-1) generate
        cells_values(y)(x) <= values(N*y + x);
      end generate input_cells_values_col;
    end generate input_cells_values_row;

    output_cells_row: for y in 0 to (N-1) generate
      output_cells_col: for x in 0 to (N-1) generate
        out_o(N*y + x) <= cells_out(y)(x);
      end generate output_cells_col;
    end generate output_cells_row;
    
    -- TOP LEFT
    cells_neighbors(0)(0)(0) <= '0';
    cells_neighbors(0)(0)(1) <= '0';
    cells_neighbors(0)(0)(2) <= '0';
    cells_neighbors(0)(0)(3) <= '0';
    cells_neighbors(0)(0)(4) <= cells_out(0)(1);
    cells_neighbors(0)(0)(5) <= '0';
    cells_neighbors(0)(0)(6) <= cells_out(1)(0);
    cells_neighbors(0)(0)(7) <= cells_out(1)(1);

    -- TOP RIGHT
    cells_neighbors(0)(N-1)(0) <= '0';
    cells_neighbors(0)(N-1)(1) <= '0';
    cells_neighbors(0)(N-1)(2) <= '0';
    cells_neighbors(0)(N-1)(3) <= '0';
    cells_neighbors(0)(N-1)(4) <= cells_out(0)(N-2);
    cells_neighbors(0)(N-1)(5) <= '0';
    cells_neighbors(0)(N-1)(6) <= cells_out(1)(N-2);
    cells_neighbors(0)(N-1)(7) <= cells_out(1)(N-1);


    -- BOTTOM LEFT
    cells_neighbors(N-1)(0)(0) <= '0';
    cells_neighbors(N-1)(0)(1) <= cells_out(N-2)(0);
    cells_neighbors(N-1)(0)(2) <= cells_out(N-2)(1);
    cells_neighbors(N-1)(0)(3) <= '0';
    cells_neighbors(N-1)(0)(4) <= cells_out(N-1)(1);
    cells_neighbors(N-1)(0)(5) <= '0';
    cells_neighbors(N-1)(0)(6) <= '0';
    cells_neighbors(N-1)(0)(7) <= '0';


    -- BOTTOM RIGHT
    cells_neighbors(N-1)(N-1)(0) <= cells_out(N-2)(N-2);
    cells_neighbors(N-1)(N-1)(1) <= cells_out(N-2)(N-1);
    cells_neighbors(N-1)(N-1)(2) <= '0';
    cells_neighbors(N-1)(N-1)(3) <= cells_out(N-1)(N-2);
    cells_neighbors(N-1)(N-1)(4) <= '0';
    cells_neighbors(N-1)(N-1)(5) <= '0';
    cells_neighbors(N-1)(N-1)(6) <= '0';
    cells_neighbors(N-1)(N-1)(7) <= '0';

    cell_neighbors_top_border: for x in 1 to N-2 generate
        cells_neighbors(0)(x)(0) <= '0';
        cells_neighbors(0)(x)(1) <= '0';
        cells_neighbors(0)(x)(2) <= '0';
        cells_neighbors(0)(x)(3) <= cells_out(0)(x-1);
        cells_neighbors(0)(x)(4) <= cells_out(0)(x+1);
        cells_neighbors(0)(x)(5) <= cells_out(1)(x-1);
        cells_neighbors(0)(x)(6) <= cells_out(1)(x);
        cells_neighbors(0)(x)(7) <= cells_out(1)(x+1);
    end generate cell_neighbors_top_border;

    cell_neighbors_bottom_border: for x in 1 to N-2 generate
        cells_neighbors(N-1)(x)(0) <= cells_out(N-2)(x-1);
        cells_neighbors(N-1)(x)(1) <= cells_out(N-2)(x);
        cells_neighbors(N-1)(x)(2) <= cells_out(N-2)(x+1);
        cells_neighbors(N-1)(x)(3) <= cells_out(N-1)(x-1);
        cells_neighbors(N-1)(x)(4) <= cells_out(N-1)(x+1);
        cells_neighbors(N-1)(x)(5) <= '0';
        cells_neighbors(N-1)(x)(6) <= '0';
        cells_neighbors(N-1)(x)(7) <= '0';
    end generate cell_neighbors_bottom_border;

    cell_neighbors_left_border: for y in 1 to N-2 generate
        cells_neighbors(y)(0)(0) <= '0';
        cells_neighbors(y)(0)(1) <= cells_out(y-1)(0);
        cells_neighbors(y)(0)(2) <= cells_out(y-1)(1);
        cells_neighbors(y)(0)(3) <= '0';
        cells_neighbors(y)(0)(4) <= cells_out(y)(1);
        cells_neighbors(y)(0)(5) <= '0';
        cells_neighbors(y)(0)(6) <= cells_out(y+1)(0);
        cells_neighbors(y)(0)(7) <= cells_out(y+1)(1);
    end generate cell_neighbors_left_border;

    cell_neighbors_right_border: for y in 1 to N-2 generate
        cells_neighbors(y)(N-1)(0) <= cells_out(y-1)(N-2);
        cells_neighbors(y)(N-1)(1) <= cells_out(y-1)(N-1);
        cells_neighbors(y)(N-1)(2) <= '0';
        cells_neighbors(y)(N-1)(3) <= cells_out(y)(N-2);
        cells_neighbors(y)(N-1)(4) <= '0';
        cells_neighbors(y)(N-1)(5) <= cells_out(y+1)(N-2);
        cells_neighbors(y)(N-1)(6) <= cells_out(y+1)(N-1);
        cells_neighbors(y)(N-1)(7) <= '0';
    end generate cell_neighbors_right_border;


    cell_neighbors_rows: for y in 1 to N-2 generate
      cell_neighbors_cols: for x in 1 to N-2 generate
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

    cell_rows: for y in 0 to N-1 generate
      cell_cols: for x in 0 to N-1 generate
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
