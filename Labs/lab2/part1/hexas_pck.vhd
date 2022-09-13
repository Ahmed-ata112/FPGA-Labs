library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package hexas_pck is

    type hex_constants_t is array (0 to 15) of std_logic_vector(6 downto 0);
    constant hex_array : hex_constants_t := (("0111111"), ("0000110"), ("1011011"), ("1001111"), ("1100110"), ("1101101"), ("1111101"), ("0000111"), ("1111111"), ("1101111"),
                                             ("1110111"), ("1111100"), ("0111001"), ("1011110"), ("1111001"), ("1110001"));

    function integer_to_std_vector(a, N : integer) return std_logic_vector;
end package;

package body hexas_pck is
    function integer_to_std_vector(a, N : integer) return std_logic_vector is
        variable ret : std_logic_vector(N - 1 downto 0);
    begin
        ret := std_logic_vector(to_unsigned(a, 4));
        return ret;
    end integer_to_std_vector;
end package body;
