library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter is
  generic (n : natural := 4);
  port (
    clock : in std_logic;
    reset_n : in std_logic;
    Q : out std_logic_vector(n - 1 downto 0));
end entity;
architecture Behavior of counter is
  signal value : std_logic_vector(n - 1 downto 0);
begin
  process (clock, reset_n)
  begin
    if (reset_n = '0') then
      value <= (others => '0');
    elsif ((clock'EVENT) and (clock = '1')) then
      value <= value + 1;
    end if;
  end process;
  Q <= value;
end Behavior;