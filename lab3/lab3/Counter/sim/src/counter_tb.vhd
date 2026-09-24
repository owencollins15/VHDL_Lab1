---------------------------------------------------------------------------------------
-- Owen Collins
-- counter test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture arch of counter_tb is

component generic_adder_beh is
  generic ( bits : integer := 4 );
  port (
    a    : in  std_logic_vector(bits-1 downto 0);
    b    : in  std_logic_vector(bits-1 downto 0);
    cin  : in  std_logic;
    sum  : out std_logic_vector(bits-1 downto 0);
    cout : out std_logic
  );
end component;

component generic_counter is
  generic ( max_count : integer := 3 );
  port (
    clk    : in  std_logic;
    reset  : in  std_logic;
    output : out std_logic
  );
end component;

component seven_seg is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    bcd           : in  std_logic_vector(3 downto 0);
    seven_seg_out : out std_logic_vector(6 downto 0)
  );
end component;

constant period     : time := 20ns;
signal clk           : std_logic := '0';
signal reset         : std_logic := '1';
signal sum            : std_logic_vector(3 downto 0) := (others => '0');
signal sum_sig       : std_logic_vector(3 downto 0);
signal enable        : std_logic;
signal seven_seg_out : std_logic_vector(6 downto 0);
signal cout_unused   : std_logic;

begin

clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process;

async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process;

adder_inst: generic_adder_beh
  generic map ( bits => 4 )
  port map ( a => sum, b => "0001", cin => '0', sum => sum_sig, cout => cout_unused );

counter_inst: generic_counter
  generic map ( max_count => 3 )
  port map ( clk => clk, reset => reset, output => enable );

reg_proc: process(clk, reset)
begin
  if reset = '1' then
    sum <= (others => '0');
  elsif rising_edge(clk) then
    if enable = '1' then
      sum <= sum_sig;
    end if;
  end if;
end process;

seg_inst: seven_seg
  port map ( clk => clk, 
  reset => reset, 
  bcd => sum, 
  seven_seg_out => seven_seg_out );

end arch;
