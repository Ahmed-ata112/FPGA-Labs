library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;

package myPackage is
  type truthTable is array (natural range <>, natural range <>) of std_logic;
  type z_state_array is array (natural range <>) of std_logic_vector (9 downto 0);
  procedure print;

  function read return z_state_array;

end package;

package body myPackage is

  procedure print is
    variable out_line : line;
    file out_file : text open WRITE_MODE is "testBench_result.txt";
  begin
    write(out_line, "****Simulation ended and FORTUNATELY, it works as expected****" & LF);
    writeline(out_file, out_line);
  end procedure;

  function read return z_state_array is
    
    variable in_line : line;
    variable expected_z_state : z_state_array(0 to 37);
    file in_file : text open READ_MODE is "expected_out.txt";
  begin
    for i in 0 to 37 loop
        readline(in_file, in_line);
        read(in_line, expected_z_state(i));
    end loop;
    return expected_z_state;
  end function;
end package body;