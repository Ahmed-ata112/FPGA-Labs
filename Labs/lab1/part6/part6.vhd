library ieee;
use ieee.std_logic_1164.all;
entity part6 is
  port (
    SW : in std_logic_vector(9 downto 7);
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);
    HEX5 : out std_logic_vector(6 downto 0));
end part6;
architecture Behavior of part6 is

  constant d_letter : std_logic_vector(1 downto 0) := "00";
  constant e_letter : std_logic_vector(1 downto 0) := "01";
  constant zero_letter : std_logic_vector(1 downto 0) := "10";
  constant blank_letter : std_logic_vector(1 downto 0) := "11";

  component mux_2bit_6to1
    port (
      S : in std_logic_vector(2 downto 0);
      U : in std_logic_vector(1 downto 0);
      V : in std_logic_vector(1 downto 0);
      W : in std_logic_vector(1 downto 0);
      X : in std_logic_vector(1 downto 0);
      D : in std_logic_vector(1 downto 0);
      L : in std_logic_vector(1 downto 0);
      M : out std_logic_vector(1 downto 0)
    );
  end component;

  component char_7seg
    port (
      C : in std_logic_vector(1 downto 0);
      Display : out std_logic_vector(6 downto 0));
  end component;

  signal M0 : std_logic_vector(1 downto 0);
  signal M1 : std_logic_vector(1 downto 0);
  signal M2 : std_logic_vector(1 downto 0);
  signal M3 : std_logic_vector(1 downto 0);
  signal M4 : std_logic_vector(1 downto 0);
  signal M5 : std_logic_vector(1 downto 0);
  signal HEX0_high,HEX1_high,HEX2_high,HEX3_high,HEX4_high,HEX5_high : std_logic_vector (6 downto 0);


begin
  U0 : mux_2bit_6to1 port map(
    SW(9 downto 7), blank_letter, blank_letter, blank_letter, d_letter, e_letter, zero_letter, M5);
  H0 : char_7seg port map(M5, HEX5_high);
  U1 : mux_2bit_6to1 port map(
    SW(9 downto 7), blank_letter, blank_letter, d_letter, e_letter, zero_letter, blank_letter, M4);
  H1 : char_7seg port map(M4, HEX4_high);

  U2 : mux_2bit_6to1 port map(
    SW(9 downto 7), blank_letter, d_letter, e_letter, zero_letter, blank_letter, blank_letter, M3);

  H2 : char_7seg port map(M3, HEX3_high);

  U3 : mux_2bit_6to1 port map(
    SW(9 downto 7), d_letter, e_letter, zero_letter, blank_letter, blank_letter, blank_letter, M2);
  H3 : char_7seg port map(M2, HEX2_high);

  U4 : mux_2bit_6to1 port map(
    SW(9 downto 7), e_letter, zero_letter, blank_letter, blank_letter, blank_letter, d_letter, M1);
  H4 : char_7seg port map(M1, HEX1_high);

  U5 : mux_2bit_6to1 port map(
    SW(9 downto 7), zero_letter, blank_letter, blank_letter, blank_letter, d_letter, e_letter, M0);

  H5 : char_7seg port map(M0, HEX0_high);
  
HEX0 <= NOT HEX0_high;
HEX1 <= NOT HEX1_high;
HEX2 <= NOT HEX2_high;
HEX3 <= NOT HEX3_high;
HEX4 <= NOT HEX4_high;
HEX5 <= NOT HEX5_high;

end Behavior;