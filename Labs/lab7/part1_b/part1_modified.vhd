
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part1_modified is
    port(
        clk   : in  std_logic;
        w     : in  std_logic;
        reset : in  std_logic;
        z     : out std_logic
    );
end entity;
architecture Behavior of part1_modified is

    signal y      : std_logic_vector(8 downto 0);
    signal next_y : std_logic_vector(8 downto 0);

    constant A : std_logic_vector(8 downto 0) := "000000000";
    constant B : std_logic_vector(8 downto 0) := "000000011";
    constant C : std_logic_vector(8 downto 0) := "000000101";
    constant D : std_logic_vector(8 downto 0) := "000001001";
    constant E : std_logic_vector(8 downto 0) := "000010001";
    constant F : std_logic_vector(8 downto 0) := "000100001";
    constant G : std_logic_vector(8 downto 0) := "001000001";
    constant H : std_logic_vector(8 downto 0) := "010000001";
    constant I : std_logic_vector(8 downto 0) := "100000001";

begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '0') then
                y <= A;                 -- reset State
            else
                y <= next_y;
            end if;
        end if;
    end process;

    process(y, w)
    begin
        case (y) is
            when A =>
                if w = '0' then
                    next_y <= B;
                else
                    next_y <= F;
                end if;
            when B =>
                if w = '0' then
                    next_y <= C;
                else
                    next_y <= F;
                end if;
            when C =>
                if w = '0' then
                    next_y <= D;
                else
                    next_y <= F;
                end if;
            when D =>
                if w = '0' then
                    next_y <= E;
                else
                    next_y <= F;
                end if;
            when E =>
                if w = '0' then
                    next_y <= E;
                else
                    next_y <= F;
                end if;

            when F =>
                if w = '0' then
                    next_y <= B;
                else
                    next_y <= G;
                end if;
            when G =>
                if w = '0' then
                    next_y <= B;
                else
                    next_y <= H;
                end if;
            when H =>
                if w = '0' then
                    next_y <= B;
                else
                    next_y <= I;
                end if;
            when I =>
                if w = '0' then
                    next_y <= B;
                else
                    next_y <= I;
                end if;
            when others =>
                next_y <= A;            -- must be the idle state here -> in case the hardware faced a srtange state or st

        end case;
    end process;

    process(y)
    begin
        z <= '0';
        case (y) is

            when A =>
                z <= '0';

            when B =>
                z <= '0';

            when C =>
                z <= '0';

            when D =>
                z <= '0';

            when E =>
                z <= '1';

            when F =>
                z <= '0';

            when G =>
                z <= '0';

            when H =>
                z <= '0';

            when I =>
                z <= '1';

            when others =>
                z <= '0';

        end case;
    end process;
end Behavior;
