library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4 is
  port (
    fast_Clk : in std_logic;
    key_start : in std_logic;
    reset : in std_logic;
    letter : in std_logic_vector (2 downto 0);
    LEDR : out std_logic
  );
end part4;

architecture arch of part4 is

  signal fast_count : unsigned(31 downto 0) := (others => '0');
  signal halves_count : unsigned (15 downto 0) := (others => '0');
begin
  process (fast_Clk, reset)
  begin
    if reset = '0' then
      fast_count <= (others => '0');
      halves_count <= X"004F";

    elsif rising_edge(fast_Clk) then
      if fast_count = 25000000 then
        if key_start = '0' then
          halves_count <= (others => '0');
        else
          halves_count <= halves_count + 1;
        end if;
        fast_count <= (others => '0');
      else
        fast_count <= fast_count + 1;
      end if;
    end if;
  end process;
  process (key_start, halves_count)
  begin
    if key_start = '1' then
      case letter is
        when "000" => --A
          if (halves_count < 1 or (halves_count >= 2 and halves_count < 5)) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when "001" => --B
          if (halves_count < 3 or (halves_count >= 4 and halves_count < 5) or
            (halves_count >= 6 and halves_count < 7) or (halves_count >= 8 and halves_count < 9)) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when "010" => --C
          if (halves_count < 3 or (halves_count >= 4 and halves_count < 5) or
            (halves_count >= 6 and halves_count < 9) or (halves_count >= 10 and halves_count < 11)) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when "011" => --D
          if (halves_count < 3 or (halves_count >= 4 and halves_count < 5) or
            (halves_count >= 6 and halves_count < 7)) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when "100" => --E
          if (halves_count < 1) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when "101" => --F
          if (halves_count <1  or (halves_count >= 2 and halves_count < 3) or 
          (halves_count >= 4 and halves_count < 7) or(halves_count >= 8 and halves_count < 9)) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when "110" => --G
          if (halves_count < 3 or (halves_count >= 4 and halves_count < 7) or
            (halves_count >= 8 and halves_count < 9)) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when "111" => --H
          if (halves_count < 1 or (halves_count >= 2 and halves_count < 3) or
            (halves_count >= 4 and halves_count < 5) or (halves_count >= 6 and halves_count < 7)) then
            LEDR <= '1';
          else LEDR <= '0';
          end if;
        when others =>
          LEDR <= '0';
      end case;
    else
      LEDR <= '0';

    end if;

  end process;

end architecture;