library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part2 is
  port(
    clock, reset    : in  std_logic;
    A               : in  std_logic_vector(7 downto 0);
	 add_sub 		  : in  std_logic;
    S               : out std_logic_vector(7 downto 0);
    HEX0,HEX1,HEX2,HEX3 : out std_logic_vector(6 downto 0);
    carry, overflow : out std_logic
  );
end part2;

architecture arch of part2 is

  component reg
    port(
      clock, reset : in  std_logic;
      A            : in  std_logic_vector(7 downto 0);
      A_reg        : out std_logic_vector(7 downto 0)
    );
  end component;

  component full_adder
    generic(n : integer);
    port(
      add_sub 		   : in  std_logic; 
      input1, input2 : in  std_logic_vector(n - 1 downto 0);
      sum            : out std_logic_vector(n - 1 downto 0);
      carry          : out std_logic
    );
  end component;

  component part6
  port (
    binary_input : in std_logic_vector (8 -1 downto 0);
    HEX0,HEX1 : out std_logic_vector (7 -1 downto 0)) ;
  end component ; 

  signal A_reg, S_reg, out_adder : std_logic_vector(7 downto 0);
  signal carry_reg, overflow_reg,add_sub_reg : std_logic;
begin
  process(clock, reset)
  begin
    if reset = '0' then
      A_reg    <= (others => '0');
      S_reg    <= (others => '0');
      overflow <= '0';
      carry    <= '0';

    elsif rising_edge(clock) then
      A_reg    <= A;
      S_reg    <= out_adder;
      overflow <= overflow_reg;
      carry    <= carry_reg;
      add_sub_reg<=add_sub;
    end if;

  end process;

  add : full_adder generic map(n => 8) port map(add_sub_reg,A_reg, S_reg, out_adder, carry_reg);

  overflow_reg <= '1' when (S_reg(7) = '1' and A_reg(7) = '1' and out_adder(7) = '0') or (S_reg(7) = '0' and A_reg(7) = '0' and out_adder(7) = '1') else '0';
  S            <= S_reg;

  hexA : part6 port map (A,HEX0,HEX1);
  hexS : part6 port map (S_reg,HEX2,HEX3);

end architecture;
