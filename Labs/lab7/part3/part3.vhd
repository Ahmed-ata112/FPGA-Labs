
library ieee;
use ieee.std_logic_1164.all;
entity part3 is
    port(
        clk   : in  std_logic;
        w     : in  std_logic;
        reset : in  std_logic;
        z     : out std_logic
    );
end part3;

architecture rtl of part3 is
    signal ones_regs       : std_logic_vector(3 downto 0) := "0000";
    signal zeros_regs      : std_logic_vector(3 downto 0) := "1111";
    signal ones_regs_next  : std_logic_vector(3 downto 0) := "0000";
    signal zeros_regs_next : std_logic_vector(3 downto 0) := "1111";

begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '0') then
                -- reset regs to appropriate values
                ones_regs  <= "0000";
                zeros_regs <= "1111";
            else
                ones_regs  <= ones_regs_next;
                zeros_regs <= zeros_regs_next;
            end if;
        end if;
    end process;
    ones_regs_next  <= w & ones_regs(3 downto 1);
    zeros_regs_next <= w & zeros_regs(3 downto 1);

    z <= '1' when (ones_regs = "1111" or zeros_regs = "0000") else '0';

end architecture;
