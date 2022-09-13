library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_textio.all;
use std.textio.ALL;
entity part3_tb is
end;

architecture bench of part3_tb is

    component part3
        port(
            A    : in  std_logic_vector(3 downto 0);
            B    : in  std_logic_vector(3 downto 0);
            P    : out std_logic_vector(7 downto 0);
            HEX0 : out std_logic_vector(7 - 1 downto 0);
            HEX1 : out std_logic_vector(7 - 1 downto 0);
            HEX2 : out std_logic_vector(7 - 1 downto 0);
            HEX3 : out std_logic_vector(7 - 1 downto 0)
        );
    end component;

    -- Clock period
    constant clk_period : time := 5 ns;
    -- Generics

    -- Ports
    signal A    : std_logic_vector(3 downto 0);
    signal B    : std_logic_vector(3 downto 0);
    signal P    : std_logic_vector(7 downto 0);
    signal HEX0 : std_logic_vector(7 - 1 downto 0);
    signal HEX1 : std_logic_vector(7 - 1 downto 0);
    signal HEX2 : std_logic_vector(7 - 1 downto 0);
    signal HEX3 : std_logic_vector(7 - 1 downto 0);

    -- files

begin

    part3_inst : part3
        port map(
            A    => A,
            B    => B,
            P    => P,
            HEX0 => HEX0,
            HEX1 => HEX1,
            HEX2 => HEX2,
            HEX3 => HEX3
        );

    process
        FILE in_file          : TEXT OPEN READ_MODE IS "input_file.txt";
        FILE output_file      : TEXT OPEN READ_MODE IS "output_file.txt";
        FILE results_out_file : TEXT OPEN WRITE_MODE IS "results_file.txt";
        variable in_line      : LINE;
        variable in_line2     : LINE;
        variable aa, bb       : std_logic_vector(3 downto 0);
        variable cc           : std_logic_vector(7 downto 0);
    begin
        while NOT ENDFILE(in_file) LOOP
            readline(in_file, in_line);
            readline(output_file, in_line2);
            hread(in_line, aa);
            hread(in_line, bb);
            hread(in_line2, cc);        --it reads with respect to the size of the vector

            A <= aa;
            B <= bb;

            wait for clk_period / 2;    -- to get the result -> the input must face a wait statement
            write(results_out_file, to_hstring(P) & LF);
            report to_hstring(P) & "  and C = " & to_hstring(cc);
            wait for clk_period;
        END LOOP;

        wait;
    end process;
end;
