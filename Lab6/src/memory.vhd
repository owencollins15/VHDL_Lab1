-------------------------------------------------------------------------------
--  Owen Collins
-- memory
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
   generic(
	addr_width : integer := 2;
   data_width : integer := 8
	);
	
	 port (
      clk               : in std_logic;
      we                : in std_logic;
      addr              : in std_logic_vector(addr_width - 1 downto 0);
      din               : in std_logic_vector(data_width - 1 downto 0);
      dout              : out std_logic_vector(data_width - 1 downto 0)
    );
end memory;


architecture beh of memory is


   type memory_type is array (
        0 to 3) of std_logic_vector(data_width-1 downto 0);

    -- Initialize all memory addresses to zero
    signal mem : memory_type := (
        others => (others => '0')
    );

begin

    -- Synchronous memory write
    process(clk)
    begin
        if rising_edge(clk) then

            if we = '1' then
                mem(to_integer(unsigned(addr))) <= din;
            end if;

        end if;
    end process;

    -- Asynchronous memory read
    dout <= mem(to_integer(unsigned(addr)));

end beh;
