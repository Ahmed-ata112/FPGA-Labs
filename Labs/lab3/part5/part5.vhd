-- A gated RS latch desribed the hard way
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity part5 is
  port (
    -- chose A or B then reload the input
    clk, reset : in std_logic;
    binary_input : in std_logic_vector(7 downto 0);
    carry_out : out std_logic;
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector (7 - 1 downto 0)

  );

end part5;
architecture Structural of part5 is
  signal A : std_logic_vector(7 downto 0);
  signal B : std_logic_vector(7 downto 0);
  signal sum_with_carry : unsigned(8 downto 0);

  component seven_segment_8_bits
    port (
      binary_input : in std_logic_vector(7 downto 0);
      HEX0 : out std_logic_vector(6 downto 0);
      HEX1 : out std_logic_vector(6 downto 0)
    );
  end component;

begin
  process (clk, reset)
  begin
    if (reset = '1') then
      A <= (others => '0');
      B <= (others => '0');
    elsif rising_edge(clk) then
      A <= binary_input;
    elsif (falling_edge(clk)) then
      B <= binary_input;
    end if;
  end process;

  sum_with_carry <= unsigned('0' & A) + unsigned('0' & B);

  carry_out <= std_logic(sum_with_carry(8));
  s0 : seven_segment_8_bits port map(A, HEX0, HEX1);
  s1 : seven_segment_8_bits port map(B, HEX2, HEX3);
  s2 : seven_segment_8_bits port map(std_logic_vector(sum_with_carry(7 downto 0)), HEX4, HEX5);

end Structural;