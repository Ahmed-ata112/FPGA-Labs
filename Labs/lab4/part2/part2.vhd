library ieee;
use ieee.std_logic_1164.all;

entity part2 is
  port (
    CLK,rst 	: in std_logic;
	 OUTPUT : out std_logic_vector(7 downto 0);
    HEX0,HEX1: out std_logic_vector(6 downto 0)
  );
end part2;

architecture Behavior of part2 is

component COUNTER is 
	generic (size : integer := 8);
    Port ( rst,CLK : in std_logic;
           Q: OUT std_logic_vector(size-1 downto 0));
end component;

component part6 is 
  port (
    binary_input : in std_logic_vector (8 -1 downto 0);
    HEX0,HEX1 : out std_logic_vector (7 -1 downto 0)) ;
end component;

signal out_count : std_logic_vector (8 -1 downto 0);
begin

  C1 : COUNTER generic map (size => 8) port map(rst,CLK,out_count);
  HEX: part6 port map (out_count,HEX0,HEX1);
OUTPUT<= out_count;

end Behavior;

