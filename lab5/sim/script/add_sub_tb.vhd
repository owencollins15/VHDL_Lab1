--------------------------------------------------------------------------------------
-- Owen Collins
-- add_sub_tb
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_tb is
end add_sub_tb;

architecture sim of add_sub_tb is

    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    -- 8-bit switch input
    signal sw : std_logic_vector(7 downto 0)
        := (others => '0');

    -- FSM button (active low)
    signal next_btn : std_logic := '1';

    -- Seven segment displays
    signal a_bcd      : std_logic_vector(6 downto 0);
    signal b_bcd      : std_logic_vector(6 downto 0);
    signal result_bcd : std_logic_vector(6 downto 0);

    -- State LEDs
    signal leds : std_logic_vector(3 downto 0);

begin

    -- 50 MHz clock
    clk <= not clk after 10 ns;


    -- UUT
    uut : entity work.add_sub
        port map (
            clk        => clk,
            reset      => reset,
            sw         => sw,
            next_btn   => next_btn,
            a_bcd      => a_bcd,
            b_bcd      => b_bcd,
            result_bcd => result_bcd,
            leds       => leds
        );


    -- Testbench stimulus
    process

        variable a_value : integer;
        variable b_value : integer;

    begin

        -- Active-high reset
        reset <= '1';
        wait for 100 ns;

        reset <= '0';
        wait for 200 ns;


        -- Test all 4 required combinations
        for test_num in 1 to 4 loop

            -- Select A and B
            case test_num is

                when 1 =>
                    a_value := 5;
                    b_value := 2;

                when 2 =>
                    a_value := 2;
                    b_value := 5;

                when 3 =>
                    a_value := 200;
                    b_value := 100;

                when others =>
                    a_value := 100;
                    b_value := 200;

            end case;


            -- INPUT_A state
            sw <= std_logic_vector(
                to_unsigned(a_value, 8)
            );

            wait for 200 ns;

            -- Press button to store A
            next_btn <= '0';
            wait for 200 ns;
            next_btn <= '1';
            wait for 200 ns;


            -- INPUT_B state
            sw <= std_logic_vector(
                to_unsigned(b_value, 8)
            );

            wait for 200 ns;

            -- Press button to store B
            next_btn <= '0';
            wait for 200 ns;
            next_btn <= '1';
            wait for 200 ns;


            -- DISP_SUM state
            -- Observe A + B
            wait for 200 ns;

            -- Press button for subtraction
            next_btn <= '0';
            wait for 200 ns;
            next_btn <= '1';
            wait for 200 ns;


            -- DISP_DIFF state
            -- Observe A - B
            wait for 200 ns;

            -- Press button to return to INPUT_A
            next_btn <= '0';
            wait for 200 ns;
            next_btn <= '1';
            wait for 200 ns;

        end loop;


        -- End simulation
        report "Lab 5 test sequences complete";

        wait;

    end process;

end sim;


