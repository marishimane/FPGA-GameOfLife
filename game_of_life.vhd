library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.cell;

entity game_of_life is
    generic(N : natural := 16;
            MAX_ITER : natural := 2**32);
    port (
        clk : in STD_LOGIC;
        
        iterations : in integer;
        en_iter_write : in STD_LOGIC;

        out_remaining_iter : out integer
    );
end game_of_life;

architecture Behavioral of game_of_life is
begin
  process(clk)
    variable remaining_iter : integer := 0;
    -- States:
    -- 0: Writing data
    -- 1: Running simulation
    -- 2: Reading data
    variable state : integer := 0;
  begin
    if rising_edge(clk) then
      -- TODO: ver si hay case
      if(state = 0) then
        -- Escribimos de alguna manera
        if(en_iter_write = '1') then
          remaining_iter := iterations;
        end if;
        state := 1;
      elsif(state = 1) then
        if(remaining_iter = 0) then
          state := 2;
        else
          remaining_iter := remaining_iter - 1;
        end if;
        -- Se termino de simular?
      elsif(state = 2) then
        -- Por ahora no nos importa
      else
      end if;
    end if;
    out_remaining_iter <= remaining_iter;
  end process;
end Behavioral;
