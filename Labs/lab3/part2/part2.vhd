library ieee;
use ieee.std_logic_1164.all;

entity part2 is
  port (
    Clk, D : in std_logic;
    Q : out std_logic);
end part2;

architecture Structural of part2 is

  signal R_g, S_g, Qa, Qb, R : std_logic;

begin

  R <= not D;
  R_g <= not (R and Clk);
  S_g <= not (D and Clk);
  Qa <= not (S_g and Qb);
  Qb <= not (R_g and Qa);
  Q <= Qa;

end Structural;