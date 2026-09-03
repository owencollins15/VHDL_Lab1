----------------------------------------------------------------------------
-- Owen Collins
-- single bit full adder [structural]
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_single_bit_struct is
    port (
        a    : in  std_logic;  --inputs
        b    : in  std_logic;
        cin  : in  std_logic;
        sum  : out std_logic;  --outputs
        cout : out std_logic
    );
end full_adder_single_bit_struct;

architecture struct of full_adder_single_bit_struct is

    component and2
        port ( a, b : in std_logic; y : out std_logic );
    end component;

    component or2
        port ( a, b : in std_logic; y : out std_logic );
    end component;

    component xor2
        port ( a, b : in std_logic; y : out std_logic );
    end component;

    signal ab_xor : std_logic;  -- a xor b
    signal ab_and : std_logic;  -- a and b
    signal c_and  : std_logic;  -- (a xor b) and cin

begin

    G1: and2 port map ( a => a,      b => b,   y => ab_and );
    G2: and2 port map ( a => ab_xor, b => cin, y => c_and  );
    G3: or2  port map ( a => ab_and, b => c_and, y => cout );

    G4: xor2 port map ( a => a,      b => b,   y => ab_xor );
    G5: xor2 port map ( a => ab_xor, b => cin, y => sum    );

end struct;
