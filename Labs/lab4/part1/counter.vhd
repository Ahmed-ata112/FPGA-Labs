library ieee;
use ieee.std_logic_1164.all;

entity counter is
  generic (N : integer := 8);
  port (
    en, clk, clr : in std_logic;
    HEX0, HEX1, HEX2 : out std_logic_vector (7 - 1 downto 0));
end counter;

architecture behavior of counter is
  signal t, q : std_logic_vector(N - 1 downto 0);

  component part6 is
    port (
      binary_input : in std_logic_vector (8 - 1 downto 0);
      HEX0, HEX1, HEX2 : out std_logic_vector (7 - 1 downto 0));
  end component;
  component part1a is
    port(
      T, clk, clr : in  std_logic;
      Q           : out std_logic);
  end component;
begin
  p6 : part6 port map(q, HEX0, HEX1, HEX2);
  t(0) <= en;
  tf_f : part1a port map(t(0), clk, clr, q(0));

  g_generate : for i in 1 to (N - 1) generate
    tf : part1a port map(t(i), clk, clr, q(i));
    t(i) <= t(i - 1) and q(i - 1);

  end generate g_generate;

end behavior;
