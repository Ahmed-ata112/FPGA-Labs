

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity part3 is
  port (
    clk, pre, stp, reset_n : in std_logic;
    min : in std_logic_vector(7 downto 0);
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(7 - 1 downto 0));
end entity;
architecture Behavior of part3 is

  component part6
    port (
      binary_input : in std_logic_vector (7 - 1 downto 0);
      HEX0 : out std_logic_vector (7 - 1 downto 0);
      HEX1 : out std_logic_vector (7 - 1 downto 0)
    );
  end component;

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

  component minCounter
    generic (
      n : natural;
      k : integer
    );
    port (
      pre : in std_logic;
      value_in : in std_logic_vector(n - 1 downto 0);
      clock : in std_logic;
      reset_n : in std_logic;
      clk_enable : in std_logic;
      rollover : out std_logic;
      Q : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  signal min_en : std_logic;
  signal hund_sec : std_logic_vector(6 downto 0);
  signal sec : std_logic_vector(5 downto 0);
  signal sigsec, sigmin : std_logic_vector(6 downto 0);
  signal minut : std_logic_vector(5 downto 0);
  signal roll0 : std_logic;
  signal roll1 : std_logic;
  signal roll2 : std_logic;
  signal slow_clock : std_logic;
  signal fast_count : unsigned(31 downto 0) := (others => '0');

begin
  min_en <= roll0 and roll1;
  sigsec <= '0' & sec;
  sigmin <= '0' & minut;
  process (clk, pre, stp, reset_n)
  begin
    if reset_n = '0' then fast_count <= (others => '0');
    elsif stp = '1' and rising_edge(clk) then
      if fast_count = 500000 then
        slow_clock <= not slow_clock;
        fast_count <= (others => '0');
      else
        fast_count <= fast_count + 1;
      end if;
    end if;
  end process;

  p0 : part1 generic map(
    n => 7,
    k => 100
  ) port map(slow_clock, reset_n, stp, roll0, hund_sec);
  p1 : part1 generic map(
    n => 6,
    k => 60
  ) port map(slow_clock, reset_n, roll0, roll1, sec);
  p3 : minCounter generic map(
    n => 6,
    k => 60
  ) port map(pre, min(5 downto 0), slow_clock, reset_n, min_en, roll2, minut);

  hundsecp6 : part6 port map(hund_sec, HEX0, HEX1);
  secp6 : part6 port map(sigsec, HEX2, HEX3);
  minp6 : part6 port map(sigmin, HEX4, HEX5);
end Behavior;