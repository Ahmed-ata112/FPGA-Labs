

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab9_part1 is
    port(
        address : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
        clock   : in  STD_LOGIC;
        data    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        wren    : in  STD_LOGIC;
        q       : out STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
end entity;

architecture rtl of lab9_part1 is
    component ram32x4
        port(
            address : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
            clock   : in  STD_LOGIC;
            data    : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            wren    : in  STD_LOGIC;
            q       : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    end component;

begin

    inst1 : ram32x4
        port map(
            address => address,
            clock   => clock,
            data    => data,
            wren    => wren,
            q       => q
        );

end architecture;

