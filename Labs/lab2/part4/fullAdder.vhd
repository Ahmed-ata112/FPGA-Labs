library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
  port (
    A, B, Ci : in std_logic;
    S, Co : out std_logic);
end fullAdder;

architecture Behavior of fullAdder is
  signal axb : std_logic;
begin
  axb <= A xor B;
  S <= axb xor Ci;
  Co <= b when (axb = '0') else Ci;
end Behavior;