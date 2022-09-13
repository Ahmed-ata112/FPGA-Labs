library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part2_tb is
end;

architecture bench of part2_tb is

    component part2
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
    type State_type is (A, B, C, D, E, F, G, H, I);
    -- Ports
    signal clk          : std_logic;
    signal w            : std_logic;
    signal reset        : std_logic;
    signal z            : std_logic;
    --State_type
    alias state_out is << signal .part2_tb.part2_inst.y : State_type >>;
begin

    part2_inst : part2
        port map(
            clk   => clk,
            w     => w,
            reset => reset,
            z     => z
        );

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process clk_process;

    process
    begin
        w     <= '0';
        reset <= '0';
        wait for clk_period;
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = A report "not valid state at time: " & time'image(now) severity ERROR;

        reset <= '1';
        w     <= '1';
        wait for clk_period;
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = F report "not valid state at time: " & time'image(now) severity ERROR; -- 1
        w     <= '0';

        wait for clk_period;
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = B report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '0';

        wait for clk_period;
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = C report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '0';

        wait for clk_period;
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = D report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '0';

        wait for clk_period;
        assert z = '1' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = E report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '0';

        wait for clk_period * 3;        -- stays at the E state
        assert z = '1' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = E report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '1';

        wait for clk_period * 4;        -- Goes to state I because of the 4 cycles
        assert z = '1' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = I report "not valid state at time: " & time'image(now) severity ERROR; --0
        w     <= '1';
        reset <= '0';

        wait for clk_period;            -- Goes to reset state
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = A report "not valid state at time: " & time'image(now) severity ERROR; --0
        w     <= '1';
        reset <= '1';

        wait for clk_period;            -- 1 state
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = F report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '1';

        wait for clk_period;            -- 11 state
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = G report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '1';

        wait for clk_period;            -- 111 state
        assert z = '0' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = H report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '1';

        wait for clk_period;            -- 1111 state
        assert z = '1' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = I report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '1';

        wait for clk_period * 3;        -- stays at 1111 state
        assert z = '1' report "not valid output at time: " & time'image(now) severity ERROR;
        assert state_out = I report "not valid state at time: " & time'image(now) severity ERROR; --0
        w <= '1';

        report "Finished at time: " & time'image(now) severity NOTE;
        wait;

    end process;

end;
