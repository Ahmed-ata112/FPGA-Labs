library ieee;
use ieee.std_logic_1164.all;

entity part1a is
  port (
    T, clk, clr: in std_logic;
    Q : out std_logic);
end part1a;

architecture behavior of part1a is
signal qbar, qtemp : std_logic;

begin
  process(clk) is
  begin
    if (clk'event and clk = '1') then
      if (clr = '0') then
        qtemp <= '0';
      elsif (T = '1') then
        qtemp <= not qtemp;
      end if;
    end if;
  end process;
  Q <= qtemp;
end behavior;