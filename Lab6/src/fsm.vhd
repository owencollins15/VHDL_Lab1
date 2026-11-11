-------------------------------------------------------------------------------
-- Owen Collins
-- fsm
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fsm is
    port (
        clk           : in std_logic;
        reset         : in std_logic;
        execute_pulse : in std_logic;

        load_inputs   : out std_logic;
        mem_we        : out std_logic;
        update_addr   : out std_logic;

        led           : out std_logic_vector(2 downto 0)
    );
end fsm;

architecture beh of fsm is

    type state_type is (
        wait_state,
        write_state,
        update_state
    );

    signal current_state : state_type := wait_state;

begin

    -- FSM with asynchronous reset
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= wait_state;

        elsif rising_edge(clk) then

            case current_state is

                when wait_state =>
                    if execute_pulse = '1' then
                        current_state <= write_state;
                    end if;

                when write_state =>
                    current_state <= update_state;

                when update_state =>
                    current_state <= wait_state;

            end case;

        end if;
    end process;


    -- Capture operands and operation
    load_inputs <= '1' when
        current_state = wait_state and
        execute_pulse = '1' and
        reset = '0'
        else '0';


    -- Enable memory write
    mem_we <= '1' when
        current_state = write_state and
        reset = '0'
        else '0';


    -- Update latest memory address
    update_addr <= '1' when
        current_state = update_state and
        reset = '0'
        else '0';


    -- State LEDs
    with current_state select
        led <=
            "001" when wait_state,
            "010" when write_state,
            "100" when update_state;

end beh;

