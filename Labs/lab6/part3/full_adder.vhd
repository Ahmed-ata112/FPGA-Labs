library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port(a    : in  STD_LOGIC;
         b    : in  STD_LOGIC;
         c    : in  STD_LOGIC;
         sum  : out STD_LOGIC;
         cout : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

begin
    sum  <= (a xor b xor c);
    cout <= (a and b) or (c and b) or (a and c);

end Behavioral;
