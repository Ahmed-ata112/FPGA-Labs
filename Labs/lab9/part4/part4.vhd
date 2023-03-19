library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dualMem is
  port(
    write_add                          : in  std_logic_vector(4 downto 0);
    w_en, fast_Clk, rst                : in  std_logic;
    data_in                            : in  std_logic_vector(3 downto 0);
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(6 downto 0)
  );
end dualMem;

architecture arch of dualMem is
  signal rdaddress  : std_logic_vector(4 downto 0) := (others => '0');
  signal fast_count : unsigned(31 downto 0)        := (others => '0');
  signal slow_count : unsigned(4 downto 0)         := (others => '0');
  signal data_out   : std_logic_vector(3 downto 0);
  signal rst_inv    : std_logic;

  component seg_decoder
    port(
      in_decoder  : in  std_logic_vector(4 - 1 downto 0);
      out_decoder : out std_logic_vector(7 - 1 downto 0)
    );
  end component;

  component ram32x4
    port(
      aclr      : in  std_logic;
      clock     : in  std_logic;
      data      : in  std_logic_vector(3 downto 0);
      rdaddress : in  std_logic_vector(4 downto 0);
      wraddress : in  std_logic_vector(4 downto 0);
      wren      : in  std_logic;
      q         : out std_logic_vector(3 downto 0)
    );
  end component;

begin
  seg_decoder_inst0 : seg_decoder
    port map(
      in_decoder  => data_out,
      out_decoder => HEX0
    );
  seg_decoder_inst1 : seg_decoder
    port map(
      in_decoder  => data_in,
      out_decoder => HEX1
    );
  seg_decoder_inst2 : seg_decoder
    port map(
      in_decoder  => rdaddress(3 downto 0),
      out_decoder => HEX2
    );
  seg_decoder_inst3 : seg_decoder
    port map(
      in_decoder  => "000" & rdaddress(4),
      out_decoder => HEX3
    );
  seg_decoder_inst4 : seg_decoder
    port map(
      in_decoder  => write_add(3 downto 0),
      out_decoder => HEX4
    );
  seg_decoder_inst5 : seg_decoder
    port map(
      in_decoder  => "000" & write_add(4),
      out_decoder => HEX5
    );
  rst_inv <= NOT rst;
  ram32x4_inst : ram32x4
    port map(
      aclr      => rst_inv,
      clock     => fast_Clk,
      data      => data_in,
      rdaddress => rdaddress,
      wraddress => write_add,
      wren      => w_en,
      q         => data_out
    );

  process(fast_Clk)
  begin
    if rising_edge(fast_Clk) then
      if fast_count = 50000000 then
        slow_count <= slow_count + 1;
        fast_count <= (others => '0');
        rdaddress  <= std_logic_vector(resize(unsigned(rdaddress) + 1, 5));
      else
        fast_count <= fast_count + 1;
      end if;

    end if;
  end process;
end architecture;
