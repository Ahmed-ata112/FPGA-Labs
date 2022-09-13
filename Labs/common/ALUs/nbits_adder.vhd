library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unsigned_adder is
  generic(n : integer := 4);
  port(
    input1, input2 : in  std_logic_vector(n - 1 downto 0);
    sum            : out std_logic_vector(n - 1 downto 0);
    carry          : out std_logic
  );
end unsigned_adder;

architecture arch of unsigned_adder is
  signal sum_temp : std_logic_vector(n downto 0);
begin
  sum_temp <= std_logic_vector(resize(unsigned(input1), n + 1) + resize(unsigned(input2), n + 1));
  sum      <= sum_temp(n - 1 downto 0);
  carry    <= sum_temp(n);
end architecture;
