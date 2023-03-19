library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part5
  is
  port (
    input : in std_logic_vector(7 downto 0);
    S : in std_logic; -----------------------------------------selector to choose which input
    result_en : std_logic;
    Pout : out std_logic_vector(15 downto 0);
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(6 downto 0)
  );
end part5;

architecture behavior of part5
  is
  component full_adder
    port (
      a : in std_logic;
      b : in std_logic;
      c : in std_logic;
      sum : out std_logic;
      cout : out std_logic
    );
  end component;
  component half_adder
    port (
      a : in std_logic;
      b : in std_logic;
      sum : out std_logic;
      cout : out std_logic
    );
  end component;

  component seg_decoder
    port (
      in_decoder : in std_logic_vector(4 - 1 downto 0);
      out_decoder : out std_logic_vector(7 - 1 downto 0)
    );
  end component;
  --                              row         col
  type partialProducts is array (7 downto 0, 7 downto 0) of std_logic;
  signal PP : partialProducts;
  signal interSum, interCarry : std_logic_vector(65 downto 0);
  signal A, B : std_logic_vector(7 downto 0);
  signal P : std_logic_vector(15 downto 0);
  signal sigHEX0, sigHEX1, sigHEX2, sigHEX3 : std_logic_vector(6 downto 0);
begin

  Pout <= P when result_en = '1';


  A <= input when S = '0' else A;
  B <= input when S = '1' else B;
  HEX0 <= sigHEX0 when result_en = '1' else "1111111";
  HEX1 <= sigHEX1 when result_en = '1' else "1111111";
  HEX2 <= sigHEX2 when result_en = '1' else "1111111";
  HEX3 <= sigHEX3 when result_en = '1' else "1111111";

  seg0 : seg_decoder port map (P(3 downto 0), sigHEX0);
  seg1 : seg_decoder port map (P(7 downto 4), sigHEX1);
  seg2 : seg_decoder port map (P(11 downto 8), sigHEX2);
  seg3 : seg_decoder port map (P(15 downto 12), sigHEX3);
  seg4 : seg_decoder port map (input(3 downto 0), HEX4);
  seg5 : seg_decoder port map (input(7 downto 4), HEX5);


  --first level of tree
  ha0 : half_adder port map(PP(0, 1), PP(1, 0), interSum(0), interCarry(0));
  fa1 : full_adder port map(PP(0, 2), PP(1, 1), PP(2, 0), interSum(1), interCarry(1));
  fa2 : full_adder port map(PP(0, 3), PP(1, 2), PP(2, 1), interSum(2), interCarry(2));
  fa3 : full_adder port map(PP(0, 4), PP(1, 3), PP(2, 2), interSum(3), interCarry(3));
  fa4 : full_adder port map(PP(0, 5), PP(1, 4), PP(2, 3), interSum(4), interCarry(4));
  fa5 : full_adder port map(PP(0, 6), PP(1, 5), PP(2, 4), interSum(5), interCarry(5));
  fa6 : full_adder port map(PP(0, 7), PP(1, 6), PP(2, 5), interSum(6), interCarry(6));
  ha1 : half_adder port map(PP(1, 7), PP(2, 6), interSum(7), interCarry(7));

  ha2 : half_adder port map(PP(3, 1), PP(4, 0), interSum(8), interCarry(8));
  fa7 : full_adder port map(PP(3, 2), PP(4, 1), PP(5, 0), interSum(9), interCarry(9));
  fa8 : full_adder port map(PP(3, 3), PP(4, 2), PP(5, 1), interSum(10), interCarry(10));
  fa9 : full_adder port map(PP(3, 4), PP(4, 3), PP(5, 2), interSum(11), interCarry(11));
  fa10 : full_adder port map(PP(3, 5), PP(4, 4), PP(5, 3), interSum(12), interCarry(12));
  fa11 : full_adder port map(PP(3, 6), PP(4, 5), PP(5, 4), interSum(13), interCarry(13));
  fa12 : full_adder port map(PP(3, 7), PP(4, 6), PP(5, 5), interSum(14), interCarry(14));
  ha3 : half_adder port map(PP(4, 7), PP(5, 6), interSum(15), interCarry(15));

  --second level of tree
  ha4 : half_adder port map(interSum(1), interCarry(0), interSum(16), interCarry(16));
  fa46 : full_adder port map(PP(3, 0), interSum(2), interCarry(1), interSum(17), interCarry(17));
  fa34 : full_adder port map(interSum(3), interSum(8), interCarry(2), interSum(18), interCarry(18));
  fa35 : full_adder port map(interSum(4), interSum(9), interCarry(3), interSum(19), interCarry(19));
  fa36 : full_adder port map(interSum(5), interSum(10), interCarry(4), interSum(20), interCarry(20));
  fa37 : full_adder port map(interSum(6), interSum(11), interCarry(5), interSum(21), interCarry(21));
  fa38 : full_adder port map(interSum(7), interSum(12), interCarry(6), interSum(22), interCarry(22));
  fa45 : full_adder port map(PP(2, 7), interSum(13), interCarry(7), interSum(23), interCarry(23));

  ha6 : half_adder port map(PP(6, 0), interCarry(9), interSum(24), interCarry(24));
  fa39 : full_adder port map(PP(6, 1), PP(7, 0), interCarry(10), interSum(25), interCarry(25));
  fa40 : full_adder port map(PP(6, 2), PP(7, 1), interCarry(11), interSum(26), interCarry(26));
  fa41 : full_adder port map(PP(6, 3), PP(7, 2), interCarry(12), interSum(27), interCarry(27));
  fa42 : full_adder port map(PP(6, 4), PP(7, 3), interCarry(13), interSum(28), interCarry(28));
  fa43 : full_adder port map(PP(6, 5), PP(7, 4), interCarry(14), interSum(29), interCarry(29));
  fa44 : full_adder port map(PP(6, 6), PP(7, 5), interCarry(15), interSum(30), interCarry(30));
  ha7 : half_adder port map(PP(6, 7), PP(7, 6), interSum(31), interCarry(31));

  -- --third level of tree

  ha8 : half_adder port map(interSum(17), interCarry(16), interSum(32), interCarry(32));
  ha9 : half_adder port map(interSum(18), interCarry(17), interSum(33), interCarry(33));
  fa47 : full_adder port map(interSum(19), interCarry(18), interCarry(8), interSum(34), interCarry(34));

  fa13 : full_adder port map(interSum(20), interSum(24), interCarry(19), interSum(35), interCarry(35));
  fa14 : full_adder port map(interSum(21), interSum(25), interCarry(20), interSum(36), interCarry(36));
  fa15 : full_adder port map(interSum(22), interSum(26), interCarry(21), interSum(37), interCarry(37));
  fa16 : full_adder port map(interSum(23), interSum(27), interCarry(22), interSum(38), interCarry(38));
  fa17 : full_adder port map(interSum(14), interSum(28), interCarry(23), interSum(39), interCarry(39));
  ha11 : half_adder port map(interSum(15), interSum(29), interSum(40), interCarry(40));
  ha12 : half_adder port map(PP(5, 7), interSum(30), interSum(41), interCarry(41));

  -- --fourth level of tree

  ha13 : half_adder port map(interSum(33), interCarry(32), interSum(42), interCarry(42));
  ha14 : half_adder port map(interSum(34), interCarry(33), interSum(43), interCarry(43));
  ha15 : half_adder port map(interSum(35), interCarry(34), interSum(44), interCarry(44));

  fa48 : full_adder port map(interSum(36), interCarry(35), interCarry(24), interSum(45), interCarry(45));
  fa49 : full_adder port map(interSum(37), interCarry(36), interCarry(25), interSum(46), interCarry(46));
  fa18 : full_adder port map(interSum(38), interCarry(37), interCarry(26), interSum(47), interCarry(47));
  fa19 : full_adder port map(interSum(39), interCarry(38), interCarry(27), interSum(48), interCarry(48));
  fa20 : full_adder port map(interSum(40), interCarry(39), interCarry(28), interSum(49), interCarry(49));
  fa21 : full_adder port map(interSum(41), interCarry(40), interCarry(29), interSum(50), interCarry(50));
  fa22 : full_adder port map(interSum(31), interCarry(41), interCarry(30), interSum(51), interCarry(51));

  ha19 : half_adder port map(PP(7, 7), interCarry(31), interSum(52), interCarry(52));

  --fifth level of tree
  ha20 : half_adder port map(interSum(43), interCarry(42), interSum(53), interCarry(53));
  fa23 : full_adder port map(interSum(44), interCarry(43), interCarry(53), interSum(54), interCarry(54));
  fa24 : full_adder port map(interSum(45), interCarry(44), interCarry(54), interSum(55), interCarry(55));
  fa25 : full_adder port map(interSum(46), interCarry(45), interCarry(55), interSum(56), interCarry(56));
  fa26 : full_adder port map(interSum(47), interCarry(46), interCarry(56), interSum(57), interCarry(57));
  fa27 : full_adder port map(interSum(48), interCarry(47), interCarry(57), interSum(58), interCarry(58));
  fa28 : full_adder port map(interSum(49), interCarry(48), interCarry(58), interSum(59), interCarry(59));
  fa29 : full_adder port map(interSum(50), interCarry(49), interCarry(59), interSum(60), interCarry(60));
  fa30 : full_adder port map(interSum(51), interCarry(50), interCarry(60), interSum(61), interCarry(61));
  fa31 : full_adder port map(interSum(52), interCarry(51), interCarry(61), interSum(62), interCarry(62));
  ha21 : half_adder port map(interCarry(52), interCarry(62), interSum(63), interCarry(63));
  P(0) <= PP(0, 0);
  P(1) <= interSum(0);
  P(2) <= interSum(16);
  P(3) <= interSum(32);
  P(4) <= interSum(42);
  P(5) <= interSum(53);
  P(6) <= interSum(54);
  P(7) <= interSum(55);
  P(8) <= interSum(56);
  P(9) <= interSum(57);
  P(10) <= interSum(58);
  P(11) <= interSum(59);
  P(12) <= interSum(60);
  P(13) <= interSum(61);
  P(14) <= interSum(62);
  P(15) <= interSum(63);
  process (A, B)
  begin
    for i in 0 to 7 loop
      for j in 0 to 7 loop
        PP(i, j) <= B(i) and A(j);
      end loop;
    end loop;
  end process;
end behavior;