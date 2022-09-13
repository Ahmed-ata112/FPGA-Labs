

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part3 is
    port(
        A                      : in  std_logic_vector(3 downto 0);
        B                      : in  std_logic_vector(3 downto 0);
        P                      : out std_logic_vector(7 downto 0);
        HEX0, HEX1, HEX2, HEX3 : out std_logic_vector(7 - 1 downto 0)
    );
end part3;

architecture arch of part3 is

    component full_adder
        port(
            a    : in  STD_LOGIC;
            b    : in  STD_LOGIC;
            c    : in  STD_LOGIC;
            sum  : out STD_LOGIC;
            cout : out STD_LOGIC
        );
    end component;
    component half_adder
        port(
            a    : in  STD_LOGIC;
            b    : in  STD_LOGIC;
            sum  : out STD_LOGIC;
            cout : out STD_LOGIC
        );
    end component;

    component seg_decoder
        port(
            in_decoder  : in  std_logic_vector(4 - 1 downto 0);
            out_decoder : out std_logic_vector(7 - 1 downto 0)
        );
    end component;
    component part6
        port(
            binary_input : in  std_logic_vector(8 - 1 downto 0);
            HEX0         : out std_logic_vector(7 - 1 downto 0);
            HEX1         : out std_logic_vector(7 - 1 downto 0)
        );
    end component;
    signal PP  : std_logic_vector(8 - 1 downto 0);
    signal A0B : std_logic_vector(4 - 1 downto 0);
    signal A1B : std_logic_vector(4 - 1 downto 0);
    signal A2B : std_logic_vector(4 - 1 downto 0);
    signal A3B : std_logic_vector(4 - 1 downto 0);
    signal k0  : std_logic_vector(4 - 1 downto 0);
    signal k1  : std_logic_vector(4 - 1 downto 0);
    signal k2  : std_logic_vector(4 - 1 downto 0);

    signal c01, c02, c03, c04, c11, c12, c13, c14, c21, c22, c23, c24 : std_logic;

begin

    A0B(0) <= A(0) and B(0);
    A1B(0) <= A(1) and B(0);
    A2B(0) <= A(2) and B(0);
    A3B(0) <= A(3) and B(0);

    A0B(1) <= A(0) and B(1);
    A1B(1) <= A(1) and B(1);
    A2B(1) <= A(2) and B(1);
    A3B(1) <= A(3) and B(1);

    A0B(2) <= A(0) and B(2);
    A1B(2) <= A(1) and B(2);
    A2B(2) <= A(2) and B(2);
    A3B(2) <= A(3) and B(2);

    A0B(3) <= A(0) and B(3);
    A1B(3) <= A(1) and B(3);
    A2B(3) <= A(2) and B(3);
    A3B(3) <= A(3) and B(3);

    --stage zero

    ha00 : half_adder port map(a => A0B(1), b => A1B(0), sum => k0(0), cout => c01);
    fa00 : full_adder port map(A1B(1), A2B(0), c01, k0(1), c02);
    fa01 : full_adder port map(A3B(0), A2B(1), c02, k0(2), c03);
    ha02 : half_adder port map(a => A3B(1), b => c03, sum => k0(3), cout => c04);

    --stage one
    ha10 : half_adder port map(a => k0(1), b => A0B(2), sum => k1(0), cout => c11);

    fa10 : full_adder port map(A1B(2), k0(2), c11, k1(1), c12);
    fa11 : full_adder port map(A2B(2), k0(3), c12, k1(2), c13);
    fa12 : full_adder port map(A3B(2), c04, c13, k1(3), c14);

    --stage two
    ha40 : half_adder port map(a => k1(1), b => A0B(3), sum => k2(0), cout => c21);
    fa40 : full_adder port map(k1(2), A1B(3), c21, k2(1), c22);
    fa41 : full_adder port map(k1(3), A2B(3), c22, k2(2), c23);
    fa42 : full_adder port map(c14, A3B(3), c23, k2(3), c24);

    --stage four

    PP(0) <= A0B(0);
    PP(1) <= k0(0);
    PP(2) <= k1(0);
    PP(3) <= k2(0);

    PP(4) <= k2(1);
    PP(5) <= k2(2);
    PP(6) <= k2(3);
    PP(7) <= c24;

    P <= PP;
    seg0 : seg_decoder port map(A, HEX0);
    seg1 : seg_decoder port map(B, HEX1);
    seg2 : part6 port map(PP, HEX2, HEX3);

end architecture;
