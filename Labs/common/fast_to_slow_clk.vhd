library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_sec_timer is
  generic(
    ratio         : real    := 1.0;
    max_frequency : integer := 50000000
  );
  port(
    fast_Clk     : in  std_logic;
    reset        : in  std_logic;
    slow_counter : out unsigned(15 downto 0)
  );
end entity;
architecture rtl of one_sec_timer is
  signal fast_count        : unsigned(31 downto 0) := (others => '0');
  signal slow_count_signal : unsigned(15 downto 0) := (others => '0');
begin
  process(fast_Clk)
  begin
    if rising_edge(fast_Clk) then
      if (reset = '0') then
        fast_count        <= (others => '0');
        slow_count_signal <= (others => '0');
      elsif fast_count = integer(real(max_frequency) * ratio) then
        slow_count_signal <= slow_count_signal + 1;
        fast_count        <= (others => '0');
      else
        fast_count <= fast_count + 1;
      end if;

    end if;
  end process;

  slow_counter <= slow_count_signal;
end architecture;
