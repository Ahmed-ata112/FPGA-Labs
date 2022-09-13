library ieee;
use ieee.std_logic_1164.all;
entity neg_dff is
  port (
    D, Clk : in std_logic;
    Q : out std_logic);
end neg_dff;
architecture Behavior of neg_dff is
begin
  process (Clk)
  begin
    if falling_edge(Clk) then
      Q <= D;
    end if;
  end process;
end Behavior;