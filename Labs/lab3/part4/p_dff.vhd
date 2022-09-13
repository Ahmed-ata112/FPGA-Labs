library ieee;
use ieee.std_logic_1164.all;
entity p_dff is
  port (
    D, Clk : in std_logic;
    Q : out std_logic);
end p_dff;
architecture Behavior of p_dff is
begin
  process (Clk)
  begin
    if rising_edge(Clk) then
      Q <= D;
    end if;
  end process;
end Behavior;