library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
use work.myPackage.all;

entity part1_tb is
end part1_tb;

architecture behavior_tb of part1_tb is
  signal clk, w, reset : std_logic := '0';
  signal z : std_logic;
  signal state_out : std_logic_vector(8 downto 0);
  signal TTb_input : truthTable(0 to 37, 0 to 1) :=
  (
  ('0', '0'),
  ('0', '1'),
  ('1', '0'),
  ('1', '0'),
  ('1', '0'),
  ('1', '0'),
  ('1', '0'),
  ('1', '1'),
  ('1', '1'),
  ('1', '1'),
  ('1', '1'),
  ('1', '1'),
  ('1', '0'),
  ('1', '1'),
  ('1', '0'),
  ('1', '1'),
  ('1', '1'),
  ('1', '0'),
  ('1', '1'),
  ('1', '1'),
  ('1', '1'),
  ('1', '0'),
  ('1', '1'),
  ('1', '1'),
  ('1', '1'),
  ('1', '1'),
  ('1', '0'),
  ('1', '0'),
  ('1', '1'),
  ('1', '0'),
  ('1', '0'),
  ('1', '0'),
  ('1', '1'),
  ('1', '0'),
  ('1', '0'),
  ('1', '0'),
  ('1', '0'),
  ('1', '1')
  );

  constant period : time := 50 ns;

  component part1
    port (
      w : in std_logic;
      clk : in std_logic;
      reset : in std_logic;
      z : out std_logic;
      state_out : out std_logic_vector(8 downto 0)
    );
  end component;
begin
  p1 : part1 port map(w, clk, reset, z, state_out);

  clk <= not clk after (period/2);

  stimulus :
  process
    variable expected_z_state : z_state_array(0 to 37);
    variable actual_z_state : std_logic_vector(9 downto 0);
    variable out_line, in_line : line;
    file out_file : text open WRITE_MODE is "out.txt";
    file in_file : text open READ_MODE is "expected_out.txt";
  begin

    expected_z_state := read;

    wait until falling_edge(clk);
    wait for period / 4;
    for i in 0 to 37 loop
      reset <= TTb_input(i, 0);
      w <= TTb_input(i, 1);

        wait until falling_edge(clk);
        actual_z_state := z & state_out;

        assert actual_z_state = expected_z_state(i)
        report("Inputs: reset=> " & std_logic'image(reset) & ",and w=> " & std_logic'image(w) & LF & "Mismatch z or state_out, expected z_state_out is:  " & to_bstring(expected_z_state(i)) & LF & "Actual outputs are  " & std_logic'image(z) & ",and " & to_bstring(state_out) & " respectively" & LF)
          severity error;
    end loop;
    print;
    wait;
  end process;

end behavior_tb;