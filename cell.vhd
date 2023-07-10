library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cell is
    port ( clk : in STD_LOGIC;
           neighbors : in STD_LOGIC_VECTOR (7 downto 0);
           value_i : in std_logic;
           enable_set_i: in std_logic;
           enable_run_i : in std_logic;
           current_state_o : out STD_LOGIC);
end cell;

architecture Behavioral of cell is
signal value : std_logic;
signal enable_set : std_logic;
signal enable_run : std_logic;

begin
    value <= value_i;
    enable_set <= enable_set_i;
    enable_run <= enable_run_i;

    process(clk)
        variable alive_neighbors : integer range 0 to 8;
        variable current_state : std_logic := '0';
        variable next_state : std_logic;

        begin
            if rising_edge(clk) then
                if(enable_set = '1') then
                    current_state := value;
                end if;

                if(enable_run = '1') then
                    alive_neighbors := 0;
                    for i in 0 to 7 loop
                        if neighbors(i) = '1' then
                            alive_neighbors := alive_neighbors + 1;
                        end if;
                    end loop;
                    
                    -- Applying the rules of Conway's Game of Life
                    -- Rule 1: Any live cell with fewer than two live neighbors dies, as if by under population.
                    if current_state = '1' and alive_neighbors < 2 then
                        next_state := '0';
                    -- Rule 2: Any live cell with two or three live neighbors lives on to the next generation.
                    elsif current_state = '1' and (alive_neighbors = 2 or alive_neighbors = 3) then
                        next_state := '1';
                    -- Rule 3: Any live cell with more than three live neighbors dies, as if by overpopulation.
                    elsif current_state = '1' and alive_neighbors > 3 then
                        next_state := '0';
                    -- Rule 4: Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
                    elsif current_state = '0' and alive_neighbors = 3 then
                        next_state := '1';
                    else
                        next_state := '0';
                    end if;
                end if;
            end if;
            if falling_edge(clk) and enable_run = '1' then
                current_state := next_state;
            end if;
            current_state_o <= current_state;-- Se actualiza en el process? o forma parte de la arquitectura y hay que declarar una senial y despues mapear la senial
        end process;

end Behavioral;

