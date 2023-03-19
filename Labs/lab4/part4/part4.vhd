library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4 is
  port (
    fast_Clk : in std_logic;
    HEX0, HEX1, HEX2, HEX3 : out std_logic_vector (7 - 1 downto 0)
  );
end part4;

architecture behavior of part4 is
  signal sw : std_logic_vector(10 - 1 downto 0);
  signal fast_count : unsigned(31 downto 0) := (others => '0');
  signal count : unsigned(1 downto 0) := "00";
  component part5 is
    port (
      SW : in std_logic_vector (10 - 1 downto 0);
      LEDR : out std_logic_vector (10 - 1 downto 0);
      HEX0, HEX1, HEX2, HEX3 : out std_logic_vector (7 - 1 downto 0)
    );
  end component;
begin
  sw(7 downto 0) <= "10010011";
  p5 : part5 port map(
    SW => sw,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2,
    HEX3 => HEX3
  );
  process (fast_clk) is
  begin
  if fast_Clk'event and fast_Clk = '1' then
    if fast_count = 50000000 then
      count <= count + 1;
      fast_count <= (others => '0');
      else
      fast_count <= fast_count + 1;
    end if;

  end if;
end process;
sw(9 downto 8) <= std_logic_vector(count);
end behavior;