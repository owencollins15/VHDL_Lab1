library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_tb is
end add_sub_tb;


architecture sim of add_sub_tb is

  signal clk        : std_logic := '0';
  signal reset      : std_logic := '0';

  signal a          : std_logic_vector(2 downto 0) := "000";
  signal b          : std_logic_vector(2 downto 0) := "000";

  signal add_btn    : std_logic := '0';
  signal sub_btn    : std_logic := '0';

  signal a_bcd      : std_logic_vector(6 downto 0);
  signal b_bcd      : std_logic_vector(6 downto 0);
  signal result_bcd : std_logic_vector(6 downto 0);

begin

  -- 50 MHz clock
  clk <= not clk after 10 ns;


  -- uut
  uut : entity work.add_sub
    port map (
      clk        => clk,
      reset      => reset,
      a          => a,
      b          => b,
      add_btn    => add_btn,
      sub_btn    => sub_btn,
      a_bcd      => a_bcd,
      b_bcd      => b_bcd,
      result_bcd => result_bcd
    );


  process
  begin

    -- Active-high reset
    reset <= '1';
    wait for 40 ns;

    reset <= '0';
    wait for 40 ns;


    -- Press ADD button
    add_btn <= '1';
    wait for 80 ns;

    add_btn <= '0';
    wait for 80 ns;


    -- Test all ADD combinations
    for b_value in 0 to 7 loop

      for a_value in 0 to 7 loop

        a <= std_logic_vector(to_unsigned(a_value, 3));
        b <= std_logic_vector(to_unsigned(b_value, 3));

        wait for 60 ns;

      end loop;

    end loop;


    -- Press SUBTRACT button
    sub_btn <= '1';
    wait for 80 ns;

    sub_btn <= '0';
    wait for 80 ns;


    -- Test all SUBTRACT combinations
    for b_value in 0 to 7 loop

      for a_value in 0 to 7 loop

        a <= std_logic_vector(to_unsigned(a_value, 3));
        b <= std_logic_vector(to_unsigned(b_value, 3));

        wait for 60 ns;

      end loop;

    end loop;


    wait;

  end process;

end sim;

