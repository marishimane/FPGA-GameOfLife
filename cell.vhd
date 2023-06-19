library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cell is
    port ( clk : in STD_LOGIC;
           neighbors : in STD_LOGIC_VECTOR (7 downto 0);
           initial_state : in STD_LOGIC;
           reset_i: in STD_LOGIC;
           current_state_o : out STD_LOGIC);
end cell;

architecture Behavioral of cell is
signal reset : STD_LOGIC;

begin
	reset <= reset_i;
    process(clk)
    variable alive_neighbors : integer range 0 to 8;
    variable current_state : std_logic;
    variable next_state : std_logic;

	begin
        if rising_edge(clk) then
        	if(reset = '1') then
            	current_state := initial_state;
            end if;
            alive_neighbors := 0;
            for i in 0 to 7 loop
                if neighbors(i) = '1' then
                    alive_neighbors := alive_neighbors + 1;
                end if;
            end loop;
            
            -- Applying the rules of Conway's Game of Life
            -- Rule 1: Any live cell with fewer than two live neighbors dies, as if by under population.
            -- Rule 2: Any live cell with two or three live neighbors lives on to the next generation.
            -- Rule 3: Any live cell with more than three live neighbors dies, as if by overpopulation.
            -- Rule 4: Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
            if current_state = '1' and alive_neighbors < 2 then
                next_state := '0';
            elsif current_state = '1' and (alive_neighbors = 2 or alive_neighbors = 3) then
                next_state := '1';
            elsif current_state = '1' and alive_neighbors > 3 then
                next_state := '0';
            elsif current_state = '0' and alive_neighbors = 3 then
                next_state := '1';
            else
                next_state := '0';
            end if;
        end if;
        if falling_edge(clk) then
        	current_state := next_state;
		end if;
        current_state_o <= current_state;-- Se actualiza en el process? o forma parte de la arquitectura y hay que declarar una senial y despues mapear la senial
		end process;
    
end Behavioral;
