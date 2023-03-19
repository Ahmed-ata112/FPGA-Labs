library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part2 is
  port (
    V 					: in std_logic_vector(3 downto 0);
    HEX0,HEX1 			: out std_logic_vector(6 downto 0)
  );
end part2;

architecture Behavior3 of part2 is

  component MUX_2X1 is
    port (
      X,Y	: in std_logic_vector(3 downto 0);
      S		: in std_logic;
      M 		: out std_logic_vector(3 downto 0)
    );
  end component;
  
  component seg_decoder is
  port (
    in_decoder : in std_logic_vector(4-1 downto 0);
    out_decoder : out std_logic_vector(7-1 downto 0));
  end component;

  signal out_mux,out_cct_A,out_comparator : std_logic_vector(3 downto 0);
  signal HEX0_high,HEX1_high : std_logic_vector (6 downto 0);


begin

out_comparator<= "0001" when (v>"1001") else "0000" ;

out_cct_A <=std_logic_vector(unsigned (V)-10); 

m1 : MUX_2X1 port map(V, out_cct_A, out_comparator(0), out_mux);
SEG0 : seg_decoder port map(out_mux,HEX0_high);
SEG1 : seg_decoder port map(out_comparator,HEX1_high);
HEX0 <= NOT HEX0_high;
HEX1 <= NOT HEX1_high;

end Behavior3;