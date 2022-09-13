library ieee;
use ieee.std_logic_1164.all;
entity part2 is
    port(
        clk   : in  std_logic;
        w     : in  std_logic;
        reset : in  std_logic;
        z     : out std_logic
    );
end part2;
architecture Behavior of part2 is

    type State_type is (A, B, C, D, E, F, G, H, I);
    -- Attribute to declare a specific encoding for the states
    attribute syn_encoding : string;
    attribute syn_encoding of State_type : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000";
    signal y               : State_type;
    signal next_y          : State_type;

begin
    -- state process
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

    -- clk process
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

    -- output process
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
