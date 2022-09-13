LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity multiplier is
	port(	a	:	in	STD_LOGIC_VECTOR(3 downto 0);
		b	:	in	STD_LOGIC_VECTOR(3 downto 0);
		p	:	out	STD_LOGIC_VECTOR(7 downto 0)
	);
end multiplier;

architecture multplier_Beh of multiplier is

	signal b0	: std_logic_vector(3 downto 0);
	signal b1	: std_logic_vector(3 downto 0);
	signal b2	: std_logic_vector(3 downto 0);
	signal b3	: std_logic_vector(3 downto 0);

	signal pb0	: std_logic_vector(4 downto 0);
	signal pb1	: std_logic_vector(4 downto 0);
	signal pb2	: std_logic_vector(4 downto 0);

begin
	b0 <=	(b(0) & b(0) & b(0) & b(0)) and a;
	b1 <=	(b(1) & b(1) & b(1) & b(1)) and a;
	b2 <=	(b(2) & b(2) & b(2) & b(2)) and a;
	b3 <=	(b(3) & b(3) & b(3) & b(3)) and a;

	pb0 <=	std_logic_vector(unsigned('0' & b1) + unsigned("00" & b0(3 downto 1)));
	pb1 <=	std_logic_vector(unsigned('0' & b2) + unsigned('0' & pb0(4 downto 1)));
	pb2 <=	std_logic_vector(unsigned('0' & b3) + unsigned('0' & pb1(4 downto 1)));

	p <= (pb2 & pb1(0) & pb0(0) & b0(0));
		
end multplier_Beh; 
		

