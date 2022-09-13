library ieee;
use ieee.std_logic_1164.all;

entity part3 is
  port (
    Clk, D : in std_logic;
    Q, Q_inv : out std_logic);
end part3;

architecture Structural of part3 is

  component part2 is
    port (
      Clk, D : in std_logic;
      Q : out std_logic);
  end component;

  signal Qm, clk_inv, Qs : std_logic;

begin

  clk_inv <= not clk;
  latch0 : part2 port map(clk_inv, D, Qm);
  latch1 : part2 port map(clk, Qm, Qs);
  Q <= Qs;
  Q_inv <= not Qs;
end Structural;