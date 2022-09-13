library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity part3 is
  port (
     fast_Clk : in std_logic;
    Q : out std_logic_vector(31 downto 0);
	  HEX0 : out std_logic_vector(6 downto 0)
	 );
	
end part3;


architecture Behavior of part3 is
  signal fast_count : unsigned(31 downto 0) := (others => '0');
  signal slow_count : unsigned(31 downto 0) := (others => '0');
 component seg_decoder
    port (
    in_decoder : in std_logic_vector(4-1 downto 0);
    out_decoder : out std_logic_vector(7-1 downto 0)
  );
end component;
	signal HEX0_high : std_logic_vector(7-1 downto 0);
  begin
  s1 : seg_decoder port map(std_logic_vector(slow_count(3 downto 0)),HEX0_high);
  
  process (fast_Clk)
  begin
    if rising_edge(fast_Clk) then
      if fast_count = 3500 then
        slow_count <= slow_count + 1;
        fast_count <= (others => '0');
		  else
		  fast_count <= fast_count +1;
      end if;
		
    end if;
  end process;
  Q <= std_logic_vector(slow_count);
  HEX0 <= NOT HEX0_high;
end Behavior;