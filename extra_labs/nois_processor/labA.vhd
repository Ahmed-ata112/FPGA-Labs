LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY labA IS
PORT (
CLOCK_50 : IN STD_LOGIC;
KEY : IN STD_LOGIC_VECTOR (0 DOWNTO 0);
SW : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
LEDR : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END labA;
ARCHITECTURE labA_rtl OF labA IS
COMPONENT nios_system
PORT (
SIGNAL clk_clk: IN STD_LOGIC;
SIGNAL reset_reset_n : IN STD_LOGIC;
SIGNAL switches_export : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL leds_export : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END COMPONENT;
BEGIN
NiosII : nios_system
PORT MAP(
clk_clk => CLOCK_50,
reset_reset_n => KEY(0),
switches_export => SW(7 DOWNTO 0),
leds_export => LEDR(7 DOWNTO 0)
);
END labA_rtl;