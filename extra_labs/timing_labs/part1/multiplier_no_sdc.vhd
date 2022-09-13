LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity multiplier_no_sdc is
	port(	clock	:	in	STD_LOGIC;
		reset	:	in	STD_LOGIC;
		a	:	in	STD_LOGIC_VECTOR(3 downto 0);
		b	:	in	STD_LOGIC_VECTOR(3 downto 0);
		ss1	:	out	STD_LOGIC_VECTOR(6 downto 0);
		ss2	:	out	STD_LOGIC_VECTOR(6 downto 0);
		ss3	:	out	STD_LOGIC_VECTOR(6 downto 0)
	);
end multiplier_no_sdc;

architecture multiplier_no_sdc_Beh of multiplier_no_sdc is

	signal p	: std_logic_vector(7 downto 0);
	signal BCD	: std_logic_vector(11 downto 0);

	signal ss1_c	: std_logic_vector(6 downto 0);
	signal ss2_c	: std_logic_vector(6 downto 0);
	signal ss3_c	: std_logic_vector(6 downto 0);

	signal a_reg	: std_logic_vector(3 downto 0);
	signal b_reg	: std_logic_vector(3 downto 0);

	component binaryToBCD is
	port(	p	:	in	STD_LOGIC_VECTOR(7 downto 0);
		BCD	:	out	STD_LOGIC_VECTOR(11 downto 0)
	);
	end component;

	component multiplier is
	port(	a	:	in	STD_LOGIC_VECTOR(3 downto 0);
		b	:	in	STD_LOGIC_VECTOR(3 downto 0);
		p	:	out	STD_LOGIC_VECTOR(7 downto 0)
	);
	end component;

	component SSD is
	port(	BCD	:	in	STD_LOGIC_VECTOR(3 downto 0);
		ss	:	out	STD_LOGIC_VECTOR(6 downto 0)
	);
	end component;
begin

	m1: 	multiplier	port map(a => a_reg, b => b_reg, p => p);
	bcd1: 	binaryToBCD	port map(p => p, BCD => BCD);
	sss1:	SSD		port map(BCD => BCD(3 downto 0), ss => ss3_c);
	sss2:	SSD		port map(BCD => BCD(7 downto 4), ss => ss2_c);
	sss3:	SSD		port map(BCD => BCD(11 downto 8), ss => ss1_c);

	process(clock,reset)
	begin
		if(reset = '1') then
			a_reg <= (others=>'0');
			b_reg <= (others=>'0');
			ss1 <= (others=>'0');
			ss2 <= (others=>'0');
			ss3 <= (others=>'0');
		elsif(rising_edge(clock))then
			a_reg <= a;
			b_reg <= b;
			ss1 <= ss1_c;
			ss2 <= ss2_c;
			ss3 <= ss3_c;
		end if;
	end process;
		
end multiplier_no_sdc_Beh; 
		

