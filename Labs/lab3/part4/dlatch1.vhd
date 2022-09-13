library ieee;
use ieee.std_logic_1164.all;
entity dlatch1 is
  port (
    D, Clk : in std_logic;
    Q : out std_logic);
end dlatch1;

architecture Behavior of dlatch1 is

begin
  process (D, Clk)
  begin
    if Clk = '1' then
      Q <= D;
    end if;
  end process;
end Behavior;