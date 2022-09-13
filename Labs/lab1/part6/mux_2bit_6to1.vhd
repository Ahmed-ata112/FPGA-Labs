library ieee;
use ieee.std_logic_1164.all;
-- implements a 2-bit wide 4-to-1 multiplexer
entity mux_2bit_6to1 is
  port (
    S : in std_logic_vector(2 downto 0);
    U, V, W, X, D, L : in std_logic_vector(1 downto 0);
    M : out std_logic_vector(1 downto 0));
end mux_2bit_6to1;
architecture Behavior of mux_2bit_6to1 is
  -- . . . code not shown
begin
  with S select
    M <= U when "000",
    V when "001",
    W when "010",
    X when "011",
    D when "100",
    L when others;
end Behavior;