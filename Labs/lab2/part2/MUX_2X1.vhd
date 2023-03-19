library ieee;
use ieee.std_logic_1164.all;

entity MUX_2X1 is
  generic (MUX_part2_width : integer := 4);
  port (
    X,Y : in std_logic_vector(MUX_part2_width-1 downto 0);
	 S : in std_logic;
	 S_out : out std_logic;
    M : out std_logic_vector(MUX_part2_width-1 downto 0));
end MUX_2X1;

architecture Behavior of MUX_2X1 is
begin
	process(S,X,Y)
	begin
		for i in 0 to (MUX_part2_width-1) loop
			M(i) <= (NOT (S) AND X(i)) OR (S AND Y(i));
		end loop;
	end process;

	S_out <= S;

end Behavior;