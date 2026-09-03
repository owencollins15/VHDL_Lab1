-------------------------------------------------------------------------------
-- Dr. Kaputa
-- single bit full adder [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_beh is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_beh;

architecture beh of full_adder_single_bit_beh is

signal x : std_logic_vector(1 downto 0);
signal av: std_logic_vector(1 downto 0);
signal bv: std_logic_vector(1 downto 0);
signal cinv: std_logic_vector(1 downto 0);

begin
  av <= "0" & a;
  bv <= "0" & b;
  cinv <= "0" & cin;
  x  <= std_logic_vector (unsigned(av) + unsigned(bv) + unsigned(cinv));
  sum  <= x(0);
  cout <= x(1);
end beh; 