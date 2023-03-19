library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package hexas_pck is

    type hex_constants_t is array (0 to 15) of std_logic_vector(6 downto 0);
    constant hex_array : hex_constants_t := (("0111111"), ("0000110"), ("1011011"), ("1001111"), ("1100110"), ("1101101"), ("1111101"), ("0000111"), ("1111111"), ("1101111"),
                                             ("1110111"), ("1111100"), ("0111001"), ("1011110"), ("1111001"), ("1110001"));

    constant num_0 : std_logic_vector(6 downto 0) := "0111111"; --40
    constant num_1 : std_logic_vector(6 downto 0) := "0000110";
    constant num_2 : std_logic_vector(6 downto 0) := "1011011";
    constant num_3 : std_logic_vector(6 downto 0) := "1001111";

    constant num_4 : std_logic_vector(6 downto 0) := "1100110";

    constant num_5 : std_logic_vector(6 downto 0) := "1101101";
    constant num_6 : std_logic_vector(6 downto 0) := "1111101"; -- 02
    constant num_7 : std_logic_vector(6 downto 0) := "0000111";
    constant num_8 : std_logic_vector(6 downto 0) := "1111111";
    constant num_9 : std_logic_vector(6 downto 0) := "1101111";
    constant num_A : std_logic_vector(6 downto 0) := "1110111";
    constant num_B : std_logic_vector(6 downto 0) := "1111100";
    constant num_C : std_logic_vector(6 downto 0) := "0111001";
    constant num_D : std_logic_vector(6 downto 0) := "1011110";
    constant num_E : std_logic_vector(6 downto 0) := "1111001"; -- 06
    constant num_F : std_logic_vector(6 downto 0) := "1110001";

end package;

package body hexas_pck is

end package body;
