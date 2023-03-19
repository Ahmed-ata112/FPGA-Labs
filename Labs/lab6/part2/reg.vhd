library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity reg is
  port (
    clock,reset : in std_logic;
    A : in std_logic_vector(7 downto 0);
    A_reg : out  std_logic_vector(7 downto 0)
  ) ;
end reg ; 

architecture arch of reg is

begin

    process (clock,reset)
    begin
        if  reset = '0' then 
            A_reg <= (others => '0');
        elsif rising_edge(clock) then
            A_reg <= A ;
        end if;
    end process;

end architecture ;