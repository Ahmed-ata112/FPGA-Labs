library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4_b is
  port(
    fast_Clk  : in  std_logic;
    key_start : in  std_logic;
    reset     : in  std_logic;
    letter    : in  std_logic_vector(2 downto 0);
    LEDR      : out std_logic
  );
end part4_b;

architecture arch of part4_b is

  signal fast_count   : unsigned(31 downto 0) := (others => '0');
  signal halves_count : unsigned(15 downto 0) := (others => '0');
  type t_state is (WORKING, NOT_WORKING, IDLE);
  signal state        : t_state;
  signal next_state   : t_state;

begin

  process(fast_Clk, reset)
  begin
    if reset = '0' then
      fast_count   <= (others => '0');
      halves_count <= (others => '0');
      state        <= NOT_WORKING;

    elsif rising_edge(fast_Clk) then
      if (key_start = '0') then         -- preassed
        state        <= WORKING;
        halves_count <= (others => '0');
        fast_count   <= (others => '0'); -- to begin counting a half of a second

      elsif fast_count = 25 then        --half a second
        halves_count <= halves_count + 1;
        fast_count   <= (others => '0');
      else
        fast_count <= fast_count + 1;
        state      <= next_state;
      end if;
    else

    end if;
  end process;

  process(state, halves_count, letter)
  begin
    case state is
      when WORKING | IDLE =>
        case letter is
          when "000" =>                 --A
            if (halves_count < 1 or (halves_count >= 2 and halves_count < 5)) then
              next_state <= WORKING;
              LEDR       <= '1';
            elsif halves_count < 5 then
              LEDR       <= '0';
              next_state <= IDLE;
            else
              next_state <= NOT_WORKING;
            end if;
          when "001" =>                 --B
            if (halves_count < 3 or (halves_count >= 4 and halves_count < 5) or (halves_count >= 6 and halves_count < 7) or (halves_count >= 8 and halves_count < 9)) then
              next_state <= WORKING;
              LEDR       <= '1';
            elsif halves_count < 9 then
              LEDR       <= '0';
              next_state <= IDLE;
            else
              next_state <= NOT_WORKING;

            end if;
          when "010" =>                 --C
            if (halves_count < 3 or (halves_count >= 4 and halves_count < 5) or (halves_count >= 6 and halves_count < 9) or (halves_count >= 10 and halves_count < 11)) then
              next_state <= WORKING;
              LEDR       <= '1';
            elsif halves_count < 11 then
              LEDR       <= '0';
              next_state <= IDLE;
            else
              next_state <= NOT_WORKING;
            end if;
          when "011" =>                 --D
            if (halves_count < 3 or (halves_count >= 4 and halves_count < 5) or (halves_count >= 6 and halves_count < 7)) then
              next_state <= WORKING;
              LEDR       <= '1';
            elsif halves_count < 7 then
              LEDR       <= '0';
              next_state <= IDLE;
            else
              next_state <= NOT_WORKING;
            end if;
          when "100" =>                 --E
            if (halves_count < 1) then
              LEDR <= '1';
            else
              next_state <= NOT_WORKING;

            end if;
          when "101" =>                 --F
            if (halves_count < 1 or (halves_count >= 2 and halves_count < 3) or (halves_count >= 4 and halves_count < 7) or (halves_count >= 8 and halves_count < 9)) then
              next_state <= WORKING;
              LEDR       <= '1';
            elsif halves_count < 9 then
              LEDR       <= '0';
              next_state <= IDLE;
            else
              next_state <= NOT_WORKING;
            end if;
          when "110" =>                 --G
            if (halves_count < 3 or (halves_count >= 4 and halves_count < 7) or (halves_count >= 8 and halves_count < 9)) then
              next_state <= WORKING;
              LEDR       <= '1';
            elsif halves_count < 9 then
              LEDR       <= '0';
              next_state <= IDLE;
            else
              next_state <= NOT_WORKING;
            end if;
          when "111" =>                 --H
            if (halves_count < 1 or (halves_count >= 2 and halves_count < 3) or (halves_count >= 4 and halves_count < 5) or (halves_count >= 6 and halves_count < 7)) then
              next_state <= WORKING;
              LEDR       <= '1';
            elsif halves_count < 7 then
              LEDR       <= '0';
              next_state <= IDLE;
            else
              next_state <= NOT_WORKING;
            end if;
          when others =>
            next_state <= NOT_WORKING;
        end case;
      when NOT_WORKING =>
        LEDR <= '0';

    end case;
  end process;
end architecture;
