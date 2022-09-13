

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab9_part2 is
    port(
        address                            : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
        clock                              : in  STD_LOGIC;
        data                               : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        wren                               : in  STD_LOGIC;
        q                                  : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX5, HEX4 : out STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
end entity;

architecture rtl of lab9_part2 is
    component ram32x4                   -- @suppress "Component declaration 'ram32x4' has none or multiple matching entity declarations"
        port(
            address : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
            clock   : in  STD_LOGIC;
            data    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            wren    : in  STD_LOGIC;
            q       : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    end component;

    component seg_decoder               -- @suppress "Component declaration 'seg_decoder' has none or multiple matching entity declarations"
        port(
            in_decoder  : in  std_logic_vector(4 - 1 downto 0);
            out_decoder : out std_logic_vector(7 - 1 downto 0)
        );
    end component;
    signal q_out : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

    inst1 : ram32x4
        port map(
            address => address,
            clock   => clock,
            data    => data,
            wren    => wren,
            q       => q_out
        );
    q    <= q_out;
    s0 : seg_decoder port map(in_decoder => data, out_decoder => HEX2);
    s1 : seg_decoder port map(in_decoder => q_out, out_decoder => HEX0);
    s3 : seg_decoder port map(in_decoder => address(3 downto 0), out_decoder => HEX4);
    s4 : seg_decoder port map(in_decoder => "000" & address(4), out_decoder => HEX5);
    HEX1 <= "1111111";
    HEX3 <= "1111111";
end architecture;

