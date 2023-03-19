

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab9_part3 is
    port(
        address                            : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
        clock                              : in  STD_LOGIC;
        data                               : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
        wren                               : in  STD_LOGIC;
        q                                  : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX5, HEX4 : out STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
end entity;

architecture rtl of lab9_part3 is
    TYPE mem IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL memory_array : mem;
    signal q_out        : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal data_r       : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal wren_r       : STD_LOGIC;
    signal address_r    : STD_LOGIC_VECTOR(4 DOWNTO 0);
    component seg_decoder               -- @suppress "Component declaration 'seg_decoder' has none or multiple matching entity declarations"
        port(
            in_decoder  : in  std_logic_vector(4 - 1 downto 0);
            out_decoder : out std_logic_vector(7 - 1 downto 0)
        );
    end component;
begin
    process(clock)
    begin
        if (rising_edge(clock)) then

            data_r    <= data;
            wren_r    <= wren;
            address_r <= address;

        end if;
    end process;

    ram32x4 : process(wren_r, address_r, data_r)
    begin
        if (wren_r = '1') then
            memory_array(to_integer(unsigned(address_r))) <= data_r;
        end if;
    end process;

    -- out is not regestired
    q_out <= memory_array(to_integer(unsigned(address_r)));
    q     <= q_out;
    s0 : seg_decoder port map(in_decoder => data, out_decoder => HEX2);
    s1 : seg_decoder port map(in_decoder => q_out, out_decoder => HEX0);
    s3 : seg_decoder port map(in_decoder => address(3 downto 0), out_decoder => HEX4);
    s4 : seg_decoder port map(in_decoder => "000" & address(4), out_decoder => HEX5);
    HEX1  <= "1111111";
    HEX3  <= "1111111";
end architecture;

