library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.hexas_pck.all;
entity part1_tb is
end;

architecture bench of part1_tb is

    component part1
        port(
            N0   : in  std_logic_vector(3 downto 0);
            N1   : in  std_logic_vector(3 downto 0);
            HEX0 : out std_logic_vector(6 downto 0);
            HEX1 : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Clock period
    constant clk_period : time := 10 ns;
    -- Generics

    -- Ports
    signal N0   : std_logic_vector(3 downto 0);
    signal N1   : std_logic_vector(3 downto 0);
    signal HEX0 : std_logic_vector(6 downto 0);
    signal HEX1 : std_logic_vector(6 downto 0);

    FILE output_file : TEXT OPEN READ_MODE IS "output_file.txt";

begin

    part1_inst : part1
        port map(
            N0   => N0,
            N1   => N1,
            HEX0 => HEX0,
            HEX1 => HEX1
        );

    process
        FILE output_file : TEXT OPEN WRITE_MODE IS "output_file.txt";

    begin
        for i in 0 to 9 loop
            for j in 0 to 9 loop
                -- N0 <= std_logic_vector(to_unsigned(i, 4));
                N0 <= integer_to_std_vector(i, 4);
                N1 <= integer_to_std_vector(j, 4);

                wait for clk_period / 4;
                report "at time : " & time'image(now) & " HEX0 = " & to_hstring(HEX0) & " and HEX1= " & to_hstring(HEX1) severity NOTE;
                assert HEX0 = NOT hex_array(i) report "at time : " & time'image(now) & " HEX0 NOT VALID" severity ERROR;
                assert HEX1 = NOT hex_array(j) report "at time : " & time'image(now) & " HEX1 NOT VALID" severity ERROR;

                
                write(output_file, "#time: " & time'image(now) & LF);
                write(output_file, "N0  = " & to_string(N0) & "  N1  = " & to_string(N1) & LF);
                write(output_file, "HEX0 = " & to_string(HEX0) & "  HEX1 = " & to_string(HEX1) & LF);

            end loop;
        end loop;
        wait;
    end process;

end;
