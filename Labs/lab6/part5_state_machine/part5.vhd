library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part5
  is
  port (
    input : in std_logic_vector(7 downto 0);
    clk, s, reset : in std_logic; -----------------------------------------selector to choose which input
    Pout : out std_logic_vector(15 downto 0);
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(6 downto 0)
  );
end part5;

architecture behavior of part5
  is
  type state is (idle, inA, inB, result);

  component wallaceMultiplier
    port (
      A : in std_logic_vector(7 downto 0);
      B : in std_logic_vector(7 downto 0);
      P : out std_logic_vector(15 downto 0)
    );
  end component;

  component seg_decoder
    port (
      in_decoder : in std_logic_vector(4 - 1 downto 0);
      out_decoder : out std_logic_vector(7 - 1 downto 0)
    );
  end component;

  signal A, B : std_logic_vector(7 downto 0);
  signal P : std_logic_vector(15 downto 0);
  signal current_state, next_state : state;
  signal sig2, sig3, sig4, sig5 : std_logic_vector(3 downto 0);
  signal sigHEX2, sigHEX3, sigHEX4, sigHEX5 : std_logic_vector(6 downto 0);
begin
  multiplier : wallaceMultiplier port map(A, B, P);

  seg2 : seg_decoder port map(sig2, sigHEX2);
  seg3 : seg_decoder port map(sig3, sigHEX3);
  seg4 : seg_decoder port map(sig4, sigHEX4);
  seg5 : seg_decoder port map(sig5, sigHEX5);

  sig2 <= B(3 downto 0) when (current_state = inA or current_state = inB) else P(3 downto 0);
  sig3 <= B(7 downto 4) when (current_state = inA or current_state = inB) else P(7 downto 4);
  sig4 <= A(3 downto 0) when (current_state = inA or current_state = inB) else P(11 downto 8);
  sig5 <= A(7 downto 4) when (current_state = inA or current_state = inB) else P(15 downto 12);

  process (clk, reset)
  begin
    if reset = '0' then
      current_state <= idle;

    elsif clk'event and clk = '0' then
      current_state <= next_state;
    end if;
  end process;

  process (current_state, s)

  begin
    if (current_state = idle) then
      if s = '0' then

        next_state <= inA;
      end if;
    elsif (current_state = inA) then
      if (s = '1') then
        next_state <= inB;
      end if;
    elsif current_state = inB then
      if (s = '0') then
        next_state <= result;
      end if;
    elsif s = '1' then
      next_state <= idle;
    end if;
  end process;

  process (current_state)
  begin

    case current_state is
      when idle =>
		
        A <= (others => '0');
        B <= (others => '0');
        Pout <= (others => '0');
        HEX2 <= "1111111";
        HEX3 <= "1111111";
        HEX4 <= "1111111";
        HEX5 <= "1111111";

      when inA =>
        A <= input;
        HEX2 <= "1111111";
        HEX3 <= "1111111";
        HEX4 <= sigHEX4;
        HEX5 <= sigHEX5;

      when inB =>
        B <= input;
        HEX2 <= sigHEX2;
        HEX3 <= sigHEX3;
      when result =>
        Pout <= P;
        HEX2 <= sigHEX2;
        HEX3 <= sigHEX3;
        HEX4 <= sigHEX4;
        HEX5 <= sigHEX5;
    end case;
  end process;
end behavior;