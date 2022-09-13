library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conv_bcd is
  port (
    binary_input : in std_logic_vector (8 - 1 downto 0);
    BCD_0 : out std_logic_vector (4 - 1 downto 0);
    BCD_1 : out std_logic_vector (4 - 1 downto 0)
  );
end conv_bcd;

architecture arch of conv_bcd is
begin
  process (binary_input)
  begin
     if binary_input >= std_logic_vector(to_unsigned(240, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 240), 4));
      BCD_1 <= std_logic_vector(to_unsigned(15, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(224, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 224), 4));
      BCD_1 <= std_logic_vector(to_unsigned(14, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(208, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 208), 4));
      BCD_1 <= std_logic_vector(to_unsigned(13, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(192, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 192), 4));
      BCD_1 <= std_logic_vector(to_unsigned(12, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(176, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 176), 4));
      BCD_1 <= std_logic_vector(to_unsigned(11, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(160, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 160), 4));
      BCD_1 <= std_logic_vector(to_unsigned(10, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(144, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 144), 4));
      BCD_1 <= std_logic_vector(to_unsigned(9, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(128, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 128), 4));
      BCD_1 <= std_logic_vector(to_unsigned(8, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(112, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 112), 4));
      BCD_1 <= std_logic_vector(to_unsigned(7, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(96, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 96), 4));
      BCD_1 <= std_logic_vector(to_unsigned(6, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(80, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 80), 4));
      BCD_1 <= std_logic_vector(to_unsigned(5, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(64, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 64), 4));
      BCD_1 <= std_logic_vector(to_unsigned(4, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(48, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 48), 4));
      BCD_1 <= std_logic_vector(to_unsigned(3, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(32, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 32), 4));
      BCD_1 <= std_logic_vector(to_unsigned(2, 4));
    elsif binary_input >= std_logic_vector(to_unsigned(16, 8)) then
      BCD_0 <= std_logic_vector(resize((unsigned(binary_input) - 16), 4));
      BCD_1 <= std_logic_vector(to_unsigned(1, 4));
    else
      BCD_0 <= binary_input(3 downto 0);
      BCD_1 <= std_logic_vector(to_unsigned(0, 4));
    end if;

  end process;
end architecture;