library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_top is
  generic (
    max_count       : integer := 25000000
  );
  port (
    clk             : in  std_logic;
    reset           : in  std_logic;
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );
end counter_top;

architecture beh of counter_top is

-- components
component generic_counter is
  generic (
    max_count       : integer := 9
  );
  port (
    clk             : in  std_logic;
    reset           : in  std_logic;
    output          : out std_logic
  );
end component;

component generic_adder_beh is
  generic (
    bits            : integer := 4
  );
  port (
    a               : in  std_logic_vector(bits-1 downto 0);
    b               : in  std_logic_vector(bits-1 downto 0);
    cin             : in  std_logic;
    sum             : out std_logic_vector(bits-1 downto 0);
    cout            : out std_logic
  );
end component;

component seven_seg is
  port (
    clk             : in  std_logic;
    reset           : in  std_logic;
    bcd             : in  std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );
end component;


-- signals
signal enable       : std_logic;
signal sum           : std_logic_vector(3 downto 0) := "0000";
signal sum_sig       : std_logic_vector(3 downto 0);
signal adder_out     : std_logic_vector(3 downto 0);

begin

-- generic Counter, generates the enable pulse
counter_inst: generic_counter
  generic map (
    max_count => max_count
  )
  port map (
    clk       => clk,
    reset     => reset,
    output    => enable
  );

-- adder, adds 1 to the current count
adder_inst: generic_adder_beh
  generic map (
    bits => 4
  )
  port map (
    a     => sum,
    b     => "0001",
    cin   => '0',
    sum   => adder_out,
    cout  => open
  );

-- wrap 9 back around to 0
sum_sig <= "0000" when sum = "1001" else adder_out;

-- register
process(clk, reset)
begin
  if (reset = '1') then
    sum <= "0000";

  elsif (clk'event and clk = '1') then
    if (enable = '1') then
      sum <= sum_sig;
    end if;
  end if;
end process;

-- seven segment decoder
seven_seg_inst: seven_seg
  port map (
    clk            => clk,
    reset          => reset,
    bcd            => sum,
    seven_seg_out  => seven_seg_out
  );

end beh;


