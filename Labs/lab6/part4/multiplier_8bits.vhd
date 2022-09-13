

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4_multiplier is
    port(
        B                      : in  std_logic_vector(7 downto 0);
        A                      : in  std_logic_vector(7 downto 0);
        P                      : out std_logic_vector(15 downto 0)

    );
end part4_multiplier;

architecture arch of part4_multiplier is

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

    component part6
        port(
            binary_input : in  std_logic_vector(8 - 1 downto 0);
            HEX0         : out std_logic_vector(7 - 1 downto 0);
            HEX1         : out std_logic_vector(7 - 1 downto 0)
        );
    end component;
    component unsigned_adder
        generic(
            n : integer
        );
        port(
            input1 : in  std_logic_vector(n - 1 downto 0);
            input2 : in  std_logic_vector(n - 1 downto 0);
            sum    : out std_logic_vector(n - 1 downto 0);
            carry  : out std_logic
        );
    end component;

    signal PP  : std_logic_vector(16 - 1 downto 0);
    signal B0A : std_logic_vector(8 - 1 downto 0);
    signal B1A : std_logic_vector(8 - 1 downto 0);
    signal B2A : std_logic_vector(8 - 1 downto 0);
    signal B3A : std_logic_vector(8 - 1 downto 0);
    signal B4A : std_logic_vector(8 - 1 downto 0);
    signal B5A : std_logic_vector(8 - 1 downto 0);
    signal B6A : std_logic_vector(8 - 1 downto 0);
    signal B7A : std_logic_vector(8 - 1 downto 0);
    signal k0  : std_logic_vector(8 - 1 downto 0);
    signal k1  : std_logic_vector(8 - 1 downto 0);
    signal k2  : std_logic_vector(8 - 1 downto 0);
    signal k3  : std_logic_vector(8 - 1 downto 0);
    signal k4  : std_logic_vector(8 - 1 downto 0);
    signal k5  : std_logic_vector(8 - 1 downto 0);
    signal k6  : std_logic_vector(8 - 1 downto 0);
    signal k7  : std_logic_vector(8 - 1 downto 0);

    signal sg0 : std_logic_vector(8 - 1 downto 0);
    signal sg1 : std_logic_vector(8 - 1 downto 0);
    signal sg2 : std_logic_vector(8 - 1 downto 0);
    signal sg3 : std_logic_vector(8 - 1 downto 0);
    signal sg4 : std_logic_vector(8 - 1 downto 0);
    signal sg5 : std_logic_vector(8 - 1 downto 0);
    signal sg6 : std_logic_vector(8 - 1 downto 0);
    signal sg7 : std_logic_vector(8 - 1 downto 0);

    signal c0, c1, c2, c3, c4, c5, c6, c7 : std_logic;

begin

    process(A, B)
    begin
        for i in 0 to 7 loop
            B0A(i) <= B(0) and A(i);
            B1A(i) <= B(1) and A(i);
            B2A(i) <= B(2) and A(i);
            B3A(i) <= B(3) and A(i);
            B4A(i) <= B(4) and A(i);
            B5A(i) <= B(5) and A(i);
            B6A(i) <= B(6) and A(i);
            B7A(i) <= B(7) and A(i);
        end loop;
    end process;

    --stage zero
    sg0 <= '0' & B0A(7 downto 1);
    add0 : unsigned_adder
        generic map(
            n => 8
        )
        port map(
            input1 => B1A,
            input2 => sg0,
            sum    => k0,
            carry  => c0
        );

    --stage one
    sg1 <= c0 & k0(7 downto 1);
    add1 : unsigned_adder
        generic map(
            n => 8
        )
        port map(
            input1 => B2A,
            input2 => sg1,
            sum    => k1,
            carry  => c1
        );
    --stage two
    sg2 <= c1 & k1(7 downto 1);
    add2 : unsigned_adder
        generic map(
            n => 8
        )
        port map(
            input1 => B3A,
            input2 => sg2,
            sum    => k2,
            carry  => c2
        );

    sg3 <= c2 & k2(7 downto 1);
    add3 : unsigned_adder
        generic map(
            n => 8
        )
        port map(
            input1 => B4A,
            input2 => sg3,
            sum    => k3,
            carry  => c3
        );

    sg4 <= c3 & k3(7 downto 1);
    add4 : unsigned_adder
        generic map(
            n => 8
        )
        port map(
            input1 => B5A,
            input2 => sg4,
            sum    => k4,
            carry  => c4
        );

    sg5 <= c4 & k4(7 downto 1);
    add5 : unsigned_adder
        generic map(
            n => 8
        )
        port map(
            input1 => B6A,
            input2 => sg5,
            sum    => k5,
            carry  => c5
        );

    sg6 <= c5 & k5(7 downto 1);
    add6 : unsigned_adder
        generic map(
            n => 8
        )
        port map(
            input1 => B7A,
            input2 => sg6,
            sum    => k6,
            carry  => c6
        );
    PP(0)  <= B0A(0);
    PP(1)  <= k0(0);
    PP(2)  <= k1(0);
    PP(3)  <= k2(0);
    PP(4)  <= k3(0);
    PP(5)  <= k4(0);
    PP(6)  <= k5(0);
    PP(7)  <= k6(0);
    PP(8)  <= k6(1);
    PP(9)  <= k6(2);
    PP(10) <= k6(3);
    PP(11) <= k6(4);
    PP(12) <= k6(5);
    PP(13) <= k6(6);
    PP(14) <= k6(7);
    PP(15) <= c6;

    P <= PP;

end architecture;
