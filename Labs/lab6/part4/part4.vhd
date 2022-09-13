library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4 is
    port(
        clk                    : in  std_logic;
        reset                  : in  std_logic;
        EA                     : in  std_logic;
        EB                     : in  std_logic;
        input_n                : in  std_logic_vector(7 downto 0);
        HEX0, HEX1, HEX2, HEX3 : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of part4 is

    component part4_multiplier
        port(
            B : in  std_logic_vector(7 downto 0);
            A : in  std_logic_vector(7 downto 0);
            P : out std_logic_vector(15 downto 0)
        );
    end component;
    component seg_decoder
        port(
            in_decoder  : in  std_logic_vector(4 - 1 downto 0);
            out_decoder : out std_logic_vector(7 - 1 downto 0)
        );
    end component;

    signal A : std_logic_vector(7 downto 0);
    signal B : std_logic_vector(7 downto 0);
    signal P : std_logic_vector(15 downto 0);

begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '0') then
                A <= (others => '0');
                B <= (others => '0');
            else
                if (EA = '1') then
                    A <= input_n;
                end if;
                if (EB = '1') then
                    B <= input_n;
                end if;
            end if;
        end if;

    end process;
    pp1 : part4_multiplier
        port map(
            A => A,
            B => B,
            P => P
        );

    dec0 : seg_decoder port map(P(3 downto 0), HEX0);
    dec1 : seg_decoder port map(P(7 downto 4), HEX1);
    dec2 : seg_decoder port map(P(11 downto 8), HEX2);
    dec3 : seg_decoder port map(P(15 downto 12), HEX3);

end architecture;
