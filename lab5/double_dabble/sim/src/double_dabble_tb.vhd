-------------------------------------------------------------------------------
-- Dr. Kaputa
-- double_dabble test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity double_dabble_tb is
end double_dabble_tb;

architecture arch of double_dabble_tb is

component double_dabble is
  port (
    result_padded           : in  std_logic_vector(11 downto 0); 
    ones                    : out std_logic_vector(3 downto 0);
    tens                    : out std_logic_vector(3 downto 0);
    hundreds                : out std_logic_vector(3 downto 0)
  );  
end component; 

begin

uut: double_dabble  
  port map(
    result_padded       => "000111001001",
    ones                => open,
    tens                => open,
    hundreds            => open
  );
end arch;