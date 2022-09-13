library ieee;
use ieee.std_logic_1164.all;
entity part1 is
  port (
    N0 : in std_logic_vector(3 downto 0);
    N1 : in std_logic_vector(3 downto 0);
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0));
end part1;
architecture Behavior of part1 is
  component seg_decoder
    port (
    in_decoder : in std_logic_vector(3 downto 0);
    out_decoder : out std_logic_vector(6 downto 0)
  );
end component;

signal HEX0_high,HEX1_high : std_logic_vector (6 downto 0);

begin
  seven1 : seg_decoder port map(N0, HEX0_high);
  seven2 : seg_decoder port map(N1, HEX1_high);
  
HEX0 <= NOT HEX0_high;
HEX1 <= NOT HEX1_high;

end Behavior;