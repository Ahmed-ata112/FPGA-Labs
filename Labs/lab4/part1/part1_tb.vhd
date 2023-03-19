library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
use work.hexas_pck.all;

entity counter_tb is
end;

architecture bench of counter_tb is

  component counter
    generic (
      N : integer
    );
    port (
      en : in std_logic;
      clk : in std_logic;
      clr : in std_logic;
      HEX0 : out std_logic_vector(7 - 1 downto 0);
      HEX1 : out std_logic_vector(7 - 1 downto 0);
      HEX2 : out std_logic_vector(7 - 1 downto 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 10 ns;
  -- Generics
  constant N : integer := 8;

  -- Ports
  signal en : std_logic;
  signal clk : std_logic := '0';
  signal clr : std_logic;
  signal HEX0 : std_logic_vector(7 - 1 downto 0);
  signal HEX1 : std_logic_vector(7 - 1 downto 0);
  signal HEX2 : std_logic_vector(7 - 1 downto 0);

begin

  counter_inst : counter
  generic map(
    N => N
  )
  port map(
    en => en,
    clk => clk,
    clr => clr,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2
  );

  -- clk generation
  clk <= not clk after (clk_period / 2);

  -- test process
  stimulus : process
    variable out_line : line;
    file out_file : text open WRITE_MODE is "testBench_result.txt";
  begin
    -- reset counter
    clr <= '0';
    wait for clk_period;

    -- start counting
    clr <= '1';
    en <= '1';
    for i in 0 to 10 loop
      for j in 0 to 9 loop

        write(out_line, integer'image(i) & integer'image(j) & " hex0=> " & to_bstring(HEX0) & " hex1=> " & to_bstring(HEX1) & LF);
        writeline(out_file, out_line);
        wait for clk_period;
      end loop;
    end loop;

    write(out_line, integer'image(11) & integer'image(0) & " hex0=> " & to_bstring(HEX0) & " hex1=> " & to_bstring(HEX1) & LF & LF);
    --try stop

    en <= '0';
    wait for clk_period * 5;
    write(out_line, "After five clock cycles with stop signal enabled hex0=> " & to_bstring(HEX0) & " hex1=> " & to_bstring(HEX1) & LF);
    writeline(out_file, out_line);

    en <= '1';
    wait for clk_period * 5;
    write(out_line, "After five clock cycles with stop signal disabled hex0=> " & to_bstring(HEX0) & " hex1=> " & to_bstring(HEX1) & LF);
    writeline(out_file, out_line);

    clr <= '0';
    wait for clk_period;
    write(out_line, "When reset is enabled hex0=> " & to_bstring(HEX0) & " hex1=> " & to_bstring(HEX1) & LF);
    writeline(out_file, out_line);
    clr <= '1';
    wait for clk_period;
    write(out_line, "When reset is disabled hex0=> " & to_bstring(HEX0) & " hex1=> " & to_bstring(HEX1) & LF);
    writeline(out_file, out_line);

    wait;
  end process;
end;