LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity binaryToBCD is
	port(	p	:	in	STD_LOGIC_VECTOR(7 downto 0);
		BCD	:	out	STD_LOGIC_VECTOR(11 downto 0)
	);
end binaryToBCD;

architecture binaryToBCD_Beh of binaryToBCD is

	signal x0	: std_logic_vector(3 downto 0);
	signal x1	: std_logic_vector(3 downto 0);
	signal x2	: std_logic_vector(3 downto 0);
	signal x3	: std_logic_vector(3 downto 0);
	signal x4	: std_logic_vector(3 downto 0);
	signal x5	: std_logic_vector(3 downto 0);
	signal x6	: std_logic_vector(3 downto 0);
	signal x7	: std_logic_vector(3 downto 0);

	signal z0	: std_logic_vector(3 downto 0);
	signal z1	: std_logic_vector(3 downto 0);
	signal z2	: std_logic_vector(3 downto 0);
	signal z3	: std_logic_vector(3 downto 0);
	signal z4	: std_logic_vector(3 downto 0);
	signal z5	: std_logic_vector(3 downto 0);
	signal z6	: std_logic_vector(3 downto 0);
	
	component shift_add_3 is
	port(	x	:	in	STD_LOGIC_VECTOR(3 downto 0);
		y	:	out	STD_LOGIC_VECTOR(3 downto 0)
	);
	end component;

begin

	z0 <= ('0' & p(7 downto 5));
	z1 <= (x0(2 downto 0) & p(4));
	z2 <= (x1(2 downto 0) & p(3));
	z3 <= (x2(2 downto 0) & p(2));
	z4 <= (x3(2 downto 0) & p(1));
	z5 <= ('0' & x0(3) & x1(3) & x2(3));
	z6 <= (x5(2 downto 0) & x3(3));

	U1: shift_add_3 port map(x => z0, y => x0);
	U2: shift_add_3 port map(x => z1, y => x1);
	U3: shift_add_3 port map(x => z2, y => x2);
	U4: shift_add_3 port map(x => z3, y => x3);
	U5: shift_add_3 port map(x => z4, y => x4);
	U6: shift_add_3 port map(x => z5, y => x5);
	U7: shift_add_3 port map(x => z6, y => x6);

	BCD <= ("00" & x5(3) & x6 & x4 & p(0));
		
end binaryToBCD_Beh; 
		

