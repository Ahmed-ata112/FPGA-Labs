library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part1_b_tb is
end;

architecture bench of part1_b_tb is

    component part1_b
        port(
            clk   : in  std_logic;
            w     : in  std_logic;
            reset : in  std_logic;
            z     : out std_logic
        );
    end component;

    -- Clock period
    constant clk_period : time := 10 ns;
    -- Generics

    -- Ports
    signal clk   : std_logic;
    signal w     : std_logic;
    signal reset : std_logic;
    signal z     : std_logic;

begin

    part1_b_inst : part1_b
        port map(
            clk   => clk,
            w     => w,
            reset => reset,
            z     => z
        );

    clk_process : process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process clk_process;

    process
    begin
        reset <= '0';
        w     <= '0';

        wait for (clk_period*2);
        reset <= '1';
        w     <= '1';
        wait for (clk_period * 2);
        w     <= '0';
        wait for (clk_period * 4);
        w     <= '1';
        wait for (clk_period * 5);
        w     <= '0';
        wait for (clk_period * 4);
        w     <= '1';
        wait for (clk_period * 2);
    end process;

end;
