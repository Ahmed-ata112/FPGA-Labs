

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity part2 is
  generic (n : natural := 4);
  port (
    fast_Clk : in std_logic;
    reset_n : in std_logic;
    HEX0, HEX1, HEX2 : out std_logic_vector(7 - 1 downto 0));
end entity;
architecture Behavior of part2 is

  component part1
    generic (
      n : natural;
      k : integer
    );
    port (
      clock : in std_logic;
      reset_n : in std_logic;
      clk_enable : in std_logic;
      rollover : out std_logic;
      Q : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  component seg_decoder
    port (
      in_decoder : in std_logic_vector(4 - 1 downto 0);
      out_decoder : out std_logic_vector(7 - 1 downto 0)
    );
  end component;

  signal BCD_0 : std_logic_vector(n - 1 downto 0); -- output of first counter
  signal BCD_1 : std_logic_vector(n - 1 downto 0);
  signal BCD_2 : std_logic_vector(n - 1 downto 0);
  signal roll0 : std_logic;
  signal roll1 : std_logic;
  signal roll2 : std_logic;
  signal slow_clock : std_logic;
  signal fast_count : unsigned(31 downto 0) := (others => '0');

begin
  process (fast_Clk)
  begin
    if rising_edge(fast_Clk) then
      if fast_count = 50000000 then
        slow_clock <= not slow_clock;
        fast_count <= (others => '0');
      else
        fast_count <= fast_count + 1;
      end if;
    end if;
  end process;

  p0 : part1 generic map(
    n => 4,
    k => 10
  ) port map(slow_clock, reset_n, '1', roll0, BCD_0);
  -- to be used as a clk
  p1 : part1 generic map(
    n => 4,
    k => 10
  ) port map(slow_clock, reset_n, roll0, roll1, BCD_1);
  p3 : part1 generic map(
    n => 4,
    k => 10
  ) port map(slow_clock, reset_n, roll1 and roll0, roll2, BCD_2);

  seg0 : seg_decoder port map(BCD_0, HEX0);
  seg1 : seg_decoder port map(BCD_1, HEX1);
  seg2 : seg_decoder port map(BCD_2, HEX2);

end Behavior;