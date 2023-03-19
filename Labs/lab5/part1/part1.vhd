library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity part1 is
  generic (
    n : natural := 8;
    k : integer := 20
  );
  
  port (
    clock : in std_logic;
    reset_n : in std_logic;
    clk_enable : in std_logic;
    rollover : out std_logic;
    Q : out std_logic_vector(n - 1 downto 0));
	 
end entity;
architecture Behavior of part1 is
  signal value : unsigned(n - 1 downto 0);
begin
  process (clock, reset_n)
  begin
    if (reset_n = '0') then
      value <= (others => '0');
    elsif ((clock'EVENT) and (clock = '1')) then
      if clk_enable = '1' then
        if (value = to_unsigned(k, value'length) - 1) then
          value <= (others => '0');
        else
          value <= value + 1;
        end if;
      end if;
    end if;
  end process;

  Q <= std_logic_vector(value);
  rollover <= '1' when value = to_unsigned(k, value'length) - 1 else '0';
end Behavior;