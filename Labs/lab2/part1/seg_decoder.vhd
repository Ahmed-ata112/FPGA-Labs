library ieee;
use ieee.std_logic_1164.all;

entity seg_decoder is
	port(
		in_decoder  : in  std_logic_vector(4 - 1 downto 0);
		out_decoder : out std_logic_vector(7 - 1 downto 0));
end seg_decoder;

architecture Behavior of seg_decoder is
begin
	process(in_decoder)
	begin
		case (in_decoder) is
			when "0000" => out_decoder <= NOT "0111111";
			when "0001" => out_decoder <= NOT "0000110";
			when "0010" => out_decoder <= NOT "1011011";
			when "0011" => out_decoder <= NOT "1001111";
			when "0100" => out_decoder <= NOT "1100110";
			when "0101" => out_decoder <= NOT "1101101";
			when "0110" => out_decoder <= NOT "1111101";
			when "0111" => out_decoder <= NOT "0000111";
			when "1000" => out_decoder <= NOT "1111111";
			when "1001" => out_decoder <= NOT "1101111";
			when others => out_decoder <= NOT "0000000";
		end case;
	end process;

end Behavior;
