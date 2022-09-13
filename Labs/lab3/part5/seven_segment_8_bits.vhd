
library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_8_bits is
  port (
    binary_input : in std_logic_vector(7 downto 0);
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0)

  );
end entity;
architecture rtl of seven_segment_8_bits is

  component conv_bcd
    port (
      binary_input : in std_logic_vector (8 - 1 downto 0);
      BCD_0 : out std_logic_vector (4 - 1 downto 0);
      BCD_1 : out std_logic_vector (4 - 1 downto 0)
    );
  end component;

  component seg_decoder
    port (
      in_decoder : in std_logic_vector(4 - 1 downto 0);
      out_decoder : out std_logic_vector(7 - 1 downto 0)
    );
  end component;
  signal BCD_0 : std_logic_vector (4 - 1 downto 0);
  signal BCD_1 : std_logic_vector (4 - 1 downto 0);
begin
  c1 : conv_bcd port map(binary_input, BCD_0, BCD_1);
  s0 : seg_decoder port map(BCD_0, HEX0);
  s1 : seg_decoder port map(BCD_1, HEX1);

end architecture;