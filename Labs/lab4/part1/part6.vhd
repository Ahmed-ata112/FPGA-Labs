library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part6 is
  port (
    binary_input : in std_logic_vector (8 - 1 downto 0);
    HEX0, HEX1 : out std_logic_vector (7 - 1 downto 0);
    HEX2 : out std_logic_vector (7 - 1 downto 0));
end part6;

architecture arch of part6 is

  component conv_bcd
    port (
      binary_input : in std_logic_vector (8 - 1 downto 0);
      BCD_0 : out std_logic_vector (4 - 1 downto 0);
      BCD_1 : out std_logic_vector (4 - 1 downto 0);
      BCD_2 : out std_logic_vector (4 - 1 downto 0)
    );
  end component;
  component seg_decoder
    port (
      in_decoder : in std_logic_vector(3 downto 0);
      out_decoder : out std_logic_vector(6 downto 0));
  end component;

  signal in_HEX_BCD0, in_HEX_BCD1 , in_HEX_BCD2: std_logic_vector (4 - 1 downto 0);
  signal HEX0_high, HEX1_high, HEX2_high : std_logic_vector(7 - 1 downto 0);

begin
  conv0 : conv_bcd port map(binary_input, in_HEX_BCD0, in_HEX_BCD1, in_HEX_BCD2);

  dec0 : seg_decoder port map(in_HEX_BCD0, HEX0_high);
  dec1 : seg_decoder port map(in_HEX_BCD1, HEX1_high);
  dec2 : seg_decoder port map(in_HEX_BCD2, HEX2_high);
  
  Hex0 <= not HEX0_high;
  Hex1 <= not HEX1_high;
  Hex2 <= not HEX2_high;
  
end architecture;