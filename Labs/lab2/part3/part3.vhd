library ieee;
use ieee.std_logic_1164.all;

entity part3 is
  port (
    A, B : in std_logic_vector(3 downto 0);
    Ci : in std_logic;
    S : out std_logic_vector(3 downto 0);
    Co : out std_logic);
end part3;

architecture Behavior of part3 is

    signal sigCo: std_logic_vector(2 downto 0);
    component fullAdder is
        port (
          A, B, Ci : in std_logic;
          S, Co : out std_logic);
      end component;

begin
    FA0 : fullAdder port map (
        A(0), B(0), Ci, S(0), sigCo(0)
    );
    FA1 : fullAdder port map (
        A(1), B(1), sigCo(0), S(1), sigCo(1)
    );
    FA2 : fullAdder port map (
        A(2), B(2), sigCo(1), S(2), sigCo(2)
    );
    FA3 : fullAdder port map (
        A(3), B(3), sigCo(2), S(3), Co
    );

end Behavior;