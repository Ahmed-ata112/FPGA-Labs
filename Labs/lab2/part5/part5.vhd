library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity part5 is
  port (
    A, B : in std_logic_vector(3 downto 0);
    Ci : in std_logic;
    HEX0, HEX1, HEX3, HEX5 : out std_logic_vector(6 downto 0)
  );
end part5;

architecture Behavior of part5 is
  component part1 is
    port (
      N0 : in std_logic_vector(3 downto 0);
      N1 : in std_logic_vector(3 downto 0);
      HEX0 : out std_logic_vector(6 downto 0);
      HEX1 : out std_logic_vector(6 downto 0));
  end component;

  signal sigHEX0 : std_logic_vector(3 downto 0);
  signal sigHEX1 : std_logic_vector(3 downto 0);
  signal mid : unsigned(4 downto 0);
begin
  SegAB : part1 port map(A, B, HEX5, HEX3);
  SegS : part1 port map(sigHEX0, sigHEX1, HEX0, HEX1);
	mid <= "0000" & Ci;
  process (A, B, Ci) is
    variable T, Z: unsigned(4 downto 0);
	 variable C : unsigned(3 downto 0);
  begin
    T := unsigned('0' & A) + unsigned('0' & B) + unsigned(mid);
    if (T > 9) then
      Z := "00110";
      C := "0001";
    else
      Z := "00000";
      C := "0000";
    end if;
end process;

    sigHEX0 <= std_logic_vector(resize(T + Z, 4));
    sigHEX1 <= std_logic_vector(C);
  
end Behavior;