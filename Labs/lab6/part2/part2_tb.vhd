library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.hexas_pck.all;

entity part2_tb is
end;

architecture bench of part2_tb is

  component part2
      port (
      clock : in std_logic;
      reset : in std_logic;
      A : in std_logic_vector(7 downto 0);
      add_sub : in std_logic ;
      S : out std_logic_vector(7 downto 0);
      HEX0 : out std_logic_vector(6 downto 0);
      HEX1 : out std_logic_vector(6 downto 0);
      HEX2 : out std_logic_vector(6 downto 0);
      HEX3 : out std_logic_vector(6 downto 0);
      carry : out std_logic;
      overflow : out std_logic
    );
  end component;

  -- Clock period
  constant clk_period : time := 50 ns;
  -- Generics

  -- Ports
  signal clock : std_logic := '1';
  signal reset : std_logic;
  signal A : std_logic_vector(7 downto 0) :=X"00";
  signal add_sub : std_logic := '0';
  signal S : std_logic_vector(7 downto 0);
  signal HEX0 : std_logic_vector(6 downto 0);
  signal HEX1 : std_logic_vector(6 downto 0);
  signal HEX2 : std_logic_vector(6 downto 0);
  signal HEX3 : std_logic_vector(6 downto 0);
  signal carry : std_logic;
  signal overflow : std_logic;
  -------------CHECK FINISH SIMULATION-------------------
  shared variable  done : std_logic :='0';
  shared variable S_var : std_logic_vector(7 downto 0);

begin
  DUT : part2
    port map (
      clock => clock,
      reset => reset,
      A => A,
      add_sub => add_sub,
      S => S,
      HEX0 => HEX0,
      HEX1 => HEX1,
      HEX2 => HEX2,
      HEX3 => HEX3,
      carry => carry,
      overflow => overflow
    );

---------------------CLOCK GENERATION---------------------------
    clock <= not clock after (clk_period / 2);

-----------------------RESET------------------------------   
   reset_process : process
   begin
       reset <= '0';
       wait for clk_period/2;
       reset <= '1';
       wait;
   end process reset_process;

----------------------READING INPUT VALUES-------------------
   process 
   file in_file  : TEXT OPEN READ_MODE  IS "in_values.txt";
   variable in_line:line ;  
   variable number : std_logic_vector(7 downto 0);  
   variable operation : std_logic;
   begin
       WAIT FOR (4.5*clk_period);
       while NOT ENDFILE(in_file) loop
           readline(in_file,in_line);
           -- Skip empty lines and single-line comments
         if in_line.all'length = 0 or in_line.all(1) = '#' then
             next;
         end if;
         bread(in_line,number); -- reading input data in binary 
         read(in_line,operation); 
         A<=number;
         add_sub<= operation;
         WAIT FOR (clk_period);
       end loop;
       WAIT FOR (clk_period);
       A<=x"00"; --- TO STOP OUTPUT FROM CHANGE 
       report "SIMULATION DONE";
       done := '1';
       wait;
   end process;    

------------------------------TEST RESULT AND STORE IT IN FILE----------------------------
   process
   file out_file : TEXT OPEN WRITE_MODE IS "out_values.txt";
   variable out_line:line ;  
   variable i : integer :=0;
   begin 
   S_var:=S;
   WAIT FOR (clk_period);
   wait on S;
    i:= i+1;
    if done='0' then
      ---- writing output  carry  overflow in file      
      write(out_line,S,left,12);
      write(out_line,carry,left,5);
      write(out_line,overflow,left,5);
      writeline(out_file,out_line);
----------------------CHECK 7SEG DISPLAY-------------------------------------            
       assert NOT(hex_array(to_integer(unsigned(S_var(3 downto 0))))) = HEX2 
           report ("TEST NUMBER: "& to_string(i) & " FOR OUTPUT HEX2 IS FAILED"&LF) severity error;
       assert NOT(hex_array(to_integer(unsigned(S_var(3 downto 0))))) /= HEX2 
           report ("TEST NUMBER: "& to_string(i) & " FOR OUTPUT HEX2 IS SUCCEEDED"&LF) severity note;
       assert NOT(hex_array(to_integer(unsigned(S_var(7 downto 4))))) = HEX3 
           report ("TEST NUMBER: "& to_string(i) & " FOR OUTPUT HEX3 IS FAILED"&LF&to_string(hex_array(to_integer(unsigned(S(7 downto 4)))))) severity error;
       assert NOT(hex_array(to_integer(unsigned(S_var(7 downto 4))))) /= HEX3 
           report ("TEST NUMBER: "& to_string(i) & " FOR OUTPUT HEX3 IS SUCCEEDED"&LF&to_string(hex_array(to_integer(unsigned(S(7 downto 4)))))) severity note; 
    end if;       

   end process;
end;