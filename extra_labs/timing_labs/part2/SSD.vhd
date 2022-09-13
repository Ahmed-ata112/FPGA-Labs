LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity SSD is
	port(	BCD	:	in	STD_LOGIC_VECTOR(3 downto 0);
		ss	:	out	STD_LOGIC_VECTOR(6 downto 0)
	);
end SSD;

architecture SSD_Beh of SSD is
begin
	ss <=	"0000001" when BCD = "0000" else
		"1001111" when BCD = "0001" else
		"0010010" when BCD = "0010" else
		"0000110" when BCD = "0011" else
		"1001100" when BCD = "0100" else
		"0100100" when BCD = "0101" else
		"0100000" when BCD = "0110" else
		"0001111" when BCD = "0111" else
		"0000000" when BCD = "1000" else
		"0001100" when BCD = "1001" else
		"0000000";
		
end SSD_Beh; 
		

