library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity board is
    port ( clk : in STD_LOGIC );
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

    CELL1: entity work.cell
        port map(
            clk => clk,
            neighbors => (
                0, 0, 0,
                0, cell_2_out,
                0, cell_4_out, cell_5_out
            ),
        );
    CELL2: entity work.cell
        port map(
            clk => clk,
            neighbors => (
                0, 0, 0,
                cell_1_out, cell_3_out,
                cell_4_out, cell_5_out, cell_6_out
            ),
        );
    CELL3: entity work.cell
        port map(
            clk => clk,
            neighbors => (
                0, 0, 0,
                cell_2_out, 0,
                cell_5_out, cell_6_out, 0
            ),
        );
    CELL5: entity work.cell
        port map(
            clk => clk,
            neighbors => (
                cell_1_out, cell_2_out, cell_3_out,
                cell_4_out, cell_6_out,
                cell_7_out, cell_8_out, cell_9_out
            ),
        );
begin
    
end Behavioral;

