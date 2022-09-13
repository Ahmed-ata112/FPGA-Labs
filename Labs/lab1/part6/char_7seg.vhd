library ieee;
use ieee.std_logic_1164.all;
entity char_7seg is
  port (
    C : in std_logic_vector(1 downto 0);
    Display : out std_logic_vector(6 downto 0));
end char_7seg;
architecture Behavior of char_7seg is
begin
  -- . . . code not shown
  with c select
    Display <= "1011110" when "00",
    "1111001" when "01",
    "0111111" when "10",
    "0000000" when others; -- blank

end Behavior;