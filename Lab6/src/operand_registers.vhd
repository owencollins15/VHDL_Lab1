-------------------------------------------------------------------------------
-- Owen Collins
-- operand registers
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity operand_registers is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        load_inputs : in std_logic;

        -- Inputs
        mem_out : in std_logic_vector(7 downto 0);
        sw_sync : in std_logic_vector(7 downto 0);
        op_sync : in std_logic_vector(1 downto 0);

        -- Registered outputs
        a_reg  : out std_logic_vector(7 downto 0);
        b_reg  : out std_logic_vector(7 downto 0);
        op_reg : out std_logic_vector(1 downto 0)
    );
end operand_registers;

architecture beh of operand_registers is

    signal a_store : std_logic_vector(7 downto 0);
    signal b_store : std_logic_vector(7 downto 0);
    signal op_store : std_logic_vector(1 downto 0);

begin

    process(clk, reset)
    begin

        if reset = '1' then
            a_store <= (others => '0');
            b_store <= (others => '0');
            op_store <= (others => '0');

        elsif rising_edge(clk) then

            if load_inputs = '1' then
                a_store <= mem_out;
                b_store <= sw_sync;
                op_store <= op_sync;
            end if;

        end if;

    end process;

    a_reg <= a_store;
    b_reg <= b_store;
    op_reg <= op_store;

end beh;


