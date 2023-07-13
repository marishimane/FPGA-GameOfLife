library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.board;

entity game_of_life is
    generic(N : natural := 16;
            MAX_ITER : natural := 2**32);
    port (
        clk : in STD_LOGIC;

        iterations : in integer;
        en_iter_write : in STD_LOGIC;

        en_cell_write : in STD_LOGIC;
        in_value : in STD_LOGIC;
        in_x : in integer range 0 to N-1;
        in_y : in integer range 0 to N-1;

        in_run_simulation : in STD_LOGIC;

        out_cell_value : out STD_LOGIC;
        out_remaining_iter : out integer
    );
end game_of_life;

architecture Behavioral of game_of_life is
  signal running_simulation : STD_LOGIC := '0';
begin
  BOARD: entity work.board
    port map(
        clk => clk,
        enable_set => en_cell_write,
        enable_run => running_simulation,

        value => in_value,
        in_x => in_x,
        in_y => in_y,

        out_o => out_cell_value
  );

  process(clk)
    variable remaining_iter : integer := 0;
    -- States:
    -- 0: Writing data
    -- 1: Running simulation
    -- 2: Reading data
    variable state : integer := 0;
  begin
    running_simulation <= '1' when state = 1 else '0';
    if rising_edge(clk) then
      -- display value of remaining_iter
      -- report "remaining_iter: " & integer'image(remaining_iter);

      if(state = 0) then
        report "# Writing data";
        report "in_x: " & integer'image(in_x);
        report "in_y: " & integer'image(in_y);
        report "out_cell_value: " & STD_LOGIC'image(out_cell_value);

        if(en_iter_write = '1') then
          remaining_iter := iterations;
        end if;
        if(in_run_simulation = '1') then
          state := 1;
        end if;

      elsif(state = 1) then
        -- report "# Running simulation";
        if(remaining_iter = 0) then
          state := 2;
        else
          -- report "remaining_iter: " & integer'image(remaining_iter);
          remaining_iter := remaining_iter - 1;
        end if;

      elsif(state = 2) then
        -- report "# Reading data";
        -- Por ahora no nos importa
      else
      end if;
    end if;

    out_remaining_iter <= remaining_iter;
  end process;
end Behavioral;
