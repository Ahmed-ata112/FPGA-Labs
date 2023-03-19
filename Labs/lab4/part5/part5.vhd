library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part5 is
  port (
    fast_Clk : in std_logic;
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector (7 - 1 downto 0)
  );
end part5;

architecture behavior of part5 is
  signal sw : std_logic_vector(11 downto 0);
  signal rot : std_logic_vector(11 downto 0) := "100100111111";
  signal fast_count : unsigned(31 downto 0) := (others => '0');
  signal HEX0_high, HEX1_high, HEX2_high, HEX3_high, HEX4_high, HEX5_high : std_logic_vector (7 - 1 downto 0);
  component decoder is
    port (
      in_decoder : in std_logic_vector(2 - 1 downto 0);
      out_decoder : out std_logic_vector(7 - 1 downto 0));
  end component;
  
  begin
  d0 : decoder port map(sw(11 downto 10), HEX0_high);
  d1 : decoder port map(sw(9 downto 8), HEX1_high);
  d2 : decoder port map(sw(7 downto 6), HEX2_high);
  d3 : decoder port map(sw(5 downto 4), HEX3_high);
  d4 : decoder port map(sw(3 downto 2), HEX4_high);
  d5 : decoder port map(sw(1 downto 0), HEX5_high);

  process (fast_clk) is
  begin
    if fast_Clk'event and fast_Clk = '1' then
      if fast_count = 50000000 then
        rot(11 downto 0) <= rot(1 downto 0) & rot(11 downto 2); --ROTATE LEFT 
	--	  rot(11 downto 0) <= rot(9 downto 0) & rot(11 downto 10); --ROTATE RIGHT 
  
        fast_count <= (others => '0');

        else
        fast_count <= fast_count + 1;
      end if;

    end if;
  end process;
  sw <= rot;
  HEX0 <= NOT HEX0_high; 
  HEX1 <= NOT HEX1_high; 
  HEX2 <= NOT HEX2_high; 
  HEX3 <= NOT HEX3_high; 
  HEX4 <= NOT HEX4_high; 
  HEX5 <= NOT HEX5_high; 

end behavior;