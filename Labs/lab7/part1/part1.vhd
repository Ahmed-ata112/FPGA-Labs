library ieee;
use ieee.std_logic_1164.all;

entity part1 is
  port (
    w, clk, reset : in std_logic;
    z : out std_logic;
    state_out : out std_logic_vector(8 downto 0)
  );

end part1;

architecture behavior of part1 is
  signal state_code : std_logic_vector(8 downto 0);
begin

  z <= state_code(8) or state_code(4);
  state_out <= state_code;
  process (clk)
  begin
    if reset = '0' then
      state_code <= "000000001";

    elsif clk'event and clk = '1' then
      if state_code(0) = '1' then --A
        if w = '1' then
          state_code(0) <= '0';
          state_code(5) <= '1';
        else
          state_code(1 downto 0) <= "10";
        end if;

      elsif state_code(1) = '1' then --B
        if w = '1' then
          state_code(1) <= '0';
          state_code(5) <= '1';
        else
          state_code(2 downto 1) <= "10";
        end if;
      elsif state_code(2) = '1' then --C
        if w = '1' then
          state_code(2) <= '0';
          state_code(5) <= '1';
        else
          state_code(3 downto 2) <= "10";
        end if;
      elsif state_code(3) = '1' then --D
        if w = '1' then
          state_code(3) <= '0';
          state_code(5) <= '1';
        else
          state_code(4 downto 3) <= "10";
        end if;

      elsif state_code(4) = '1' then --E
        if w = '1' then
          state_code(5 downto 4) <= "10";

        end if;
      elsif state_code(5) = '1' then --F
        if w = '0' then
          state_code(1) <= '1';
          state_code(5) <= '0';
        else
          state_code(6 downto 5) <= "10";
        end if;
      elsif state_code(6) = '1' then --G
        if w = '0' then
          state_code(1) <= '1';
          state_code(6) <= '0';
        else
          state_code(7 downto 6) <= "10";
        end if;
      elsif state_code(7) = '1' then --H
        if w = '0' then
          state_code(1) <= '1';
          state_code(7) <= '0';
        else
          state_code(8 downto 7) <= "10";
        end if;

      else --I
        if w = '0' then
          state_code(1) <= '1';
          state_code(8) <= '0';
        end if;
      end if;
    end if;
  end process;

end behavior;