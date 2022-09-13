-- A gated RS latch desribed the hard way
library ieee;
use ieee.std_logic_1164.all;
entity part4 is
  port (
    Clk, D : in std_logic;
    Qa, Qb, Qc : out std_logic);
end part4;
architecture Structural of part4 is
  component dlatch1
    port (
      D : in std_logic;
      Clk : in std_logic;
      Q : out std_logic
    );
  end component;

  component p_dff
    port (
      D : in std_logic;
      Clk : in std_logic;
      Q : out std_logic
    );
  end component;
  component neg_dff
    port (
      D : in std_logic;
      Clk : in std_logic;
      Q : out std_logic
    );
  end component;

begin
  D0 : dlatch1 port map(D, Clk, Qa);
  d1 : p_dff port map(D, Clk, Qb);
  d2 : neg_dff port map(D, Clk, Qc);

end Structural;