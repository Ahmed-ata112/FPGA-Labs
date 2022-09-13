library ieee;
use ieee.std_logic_1164.all;
-- Simple entity that connects the SW switches to the LEDR lights
entity part1 is
  port (
    SW : in std_logic_vector(3 downto 0);
    LEDR : out std_logic_vector(3 downto 0));
end part1;
architecture Behavior of part1 is
begin
  LEDR <= SW;
end Behavior;