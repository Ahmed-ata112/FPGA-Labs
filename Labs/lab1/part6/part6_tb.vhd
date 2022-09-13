library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part6_tb is
end;

architecture bench of part6_tb is

  component part6
    port (
      SW : in std_logic_vector(9 downto 7);
      HEX0 : out std_logic_vector(6 downto 0);
      HEX1 : out std_logic_vector(6 downto 0);
      HEX2 : out std_logic_vector(6 downto 0);
      HEX3 : out std_logic_vector(6 downto 0);
      HEX4 : out std_logic_vector(6 downto 0);
      HEX5 : out std_logic_vector(6 downto 0)
    );
  end component;

  -- Ports
  signal SW : std_logic_vector(9 downto 7);
  signal HEX0 : std_logic_vector(6 downto 0);
  signal HEX1 : std_logic_vector(6 downto 0);
  signal HEX2 : std_logic_vector(6 downto 0);
  signal HEX3 : std_logic_vector(6 downto 0);
  signal HEX4 : std_logic_vector(6 downto 0);
  signal HEX5 : std_logic_vector(6 downto 0);

begin

  part6_inst : part6
  port map(
    SW => SW,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2,
    HEX3 => HEX3,
    HEX4 => HEX4,
    HEX5 => HEX5
  );

  SW <= "000", "001" after 20 ns,
    "010" after 40 ns,
    "011" after 60 ns,
    "100" after 80 ns,
    "101" after 100 ns,
    "110" after 120 ns,
    "111" after 140 ns,
    "---" after 160 ns;

  end;