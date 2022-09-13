LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity shift_add_3 is
	port(	x	:	in	STD_LOGIC_VECTOR(3 downto 0);
		y	:	out	STD_LOGIC_VECTOR(3 downto 0)
	);
end shift_add_3;

architecture shift_add_3_Beh of shift_add_3 is
begin
	y <=	std_logic_vector(unsigned(x) + 3) when x >= "0101" else
		x;
		
end shift_add_3_Beh; 
		

