library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conv_bcd is
  port (
    binary_input : in std_logic_vector(8 - 1 downto 0);
    BCD_0 : out std_logic_vector(4 - 1 downto 0);
    BCD_1 : out std_logic_vector(4 - 1 downto 0);
    BCD_2 : out std_logic_vector(4 - 1 downto 0)
  );
end conv_bcd;

architecture arch of conv_bcd is
begin
  process (binary_input)
  begin

    if binary_input >= std_logic_vector(to_unsigned(120, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 120), 4));
      BCD_1 <= std_logic_vector(to_unsigned(2, 4));
      BCD_2 <= std_logic_vector(to_unsigned(1, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(110, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 110), 4));
      BCD_1 <= std_logic_vector(to_unsigned(1, 4));
      BCD_2 <= std_logic_vector(to_unsigned(1, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(100, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 100), 4));
      BCD_1 <= std_logic_vector(to_unsigned(0, 4));
      BCD_2 <= std_logic_vector(to_unsigned(1, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(90, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 90), 4));
      BCD_1 <= std_logic_vector(to_unsigned(9, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(80, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 80), 4));
      BCD_1 <= std_logic_vector(to_unsigned(8, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(70, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 70), 4));
      BCD_1 <= std_logic_vector(to_unsigned(7, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(60, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 60), 4));
      BCD_1 <= std_logic_vector(to_unsigned(6, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(50, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 50), 4));
      BCD_1 <= std_logic_vector(to_unsigned(5, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(40, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 40), 4));
      BCD_1 <= std_logic_vector(to_unsigned(4, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(30, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 30), 4));
      BCD_1 <= std_logic_vector(to_unsigned(3, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(20, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 20), 4));
      BCD_1 <= std_logic_vector(to_unsigned(2, 4));
      BCD_2 <= "1111";
    elsif binary_input >= std_logic_vector(to_unsigned(10, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 10), 4));
      BCD_1 <= std_logic_vector(to_unsigned(1, 4));
      BCD_2 <= "1111";
    else
      BCD_0 <= binary_input(3 downto 0);
      BCD_1 <= std_logic_vector(to_unsigned(0, 4));
      BCD_2 <= std_logic_vector(to_unsigned(0, 4));
    end if;

  end process;

end architecture;