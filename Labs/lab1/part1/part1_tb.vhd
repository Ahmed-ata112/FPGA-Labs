library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity part1_tb is
end;

architecture bench of part1_tb is

  component part1
      port (
      SW : in std_logic_vector(3 downto 0);
      LEDR : out std_logic_vector(3 downto 0)
    );
  end component;

  subtype ShortVector is STD_LOGIC_VECTOR(3 downto 0);
  -- Ports
  signal SW : ShortVector := "0000";
  signal LEDR : ShortVector;

begin

  DUT : part1
    port map (
      SW => SW,
      LEDR => LEDR
    );

    -- self_checking : process is
    -- variable i : integer := 0;
    -- begin
    --     while i < 15 loop
    --         report "i=" & integer'image(i);
    --         SW <= std_logic_vector(unsigned(SW) + 1);
    --         i := i + 1;
    --         assert LEDR = SW
    --             report "OUTPUT VALUE IS WRONG"
    --             severity  error;
    --         report "OUTPUT VALUE IS CORRECT FOR " & "i=" & integer'image(i);
    --         WAIT FOR 100 NS;

    --     end loop;
    --     wait;

    -- end process;

--using test vectors
file_io : process 
    file in_file : TEXT OPEN READ_MODE IS "in_values.txt";    
    file out_file : TEXT OPEN WRITE_MODE IS "out_values.txt";    
    variable out_line : line ;
    variable in_line : line ;
    variable number : std_logic_vector(3 downto 0);
    begin
        while not endfile(in_file) loop
            readline(in_file,in_line);
              -- Skip empty lines and single-line comments
            if in_line.all'length = 0 or in_line.all(1) = '#' then
                next;
            end if;
            hread(in_line,number); 
            SW <= number;
            WAIT FOR 100 NS;
            hwrite(out_line,LEDR);
            writeline(out_file,out_line);
            assert LEDR = SW
                report "OUTPUT VALUE IS WRONG"
                severity  error;
            report "OUTPUT VALUE IS CORRECT FOR " & "input=" & to_hstring(number) severity note ;           
        end loop; 
        report "SIMULATION DONE";
        wait;
    end process;

end;
