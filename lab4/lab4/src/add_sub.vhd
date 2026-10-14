-------------------------------------------------------------------------------
-- Lab 4 - Add / Subtract Top Level
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity add_sub is
  port (
    clk        : in  std_logic;
    reset      : in  std_logic;

    a          : in  std_logic_vector(2 downto 0);
    b          : in  std_logic_vector(2 downto 0);

    add_btn    : in  std_logic;
    sub_btn    : in  std_logic;

    a_bcd      : out std_logic_vector(6 downto 0);
    b_bcd      : out std_logic_vector(6 downto 0);
    result_bcd : out std_logic_vector(6 downto 0)
  );
end add_sub;


architecture structural of add_sub is


  -- synchronized switch inputs
  signal a_sync : std_logic_vector(2 downto 0);
  signal b_sync : std_logic_vector(2 downto 0);

  -- button enable signals
  signal add_en : std_logic;
  signal sub_en : std_logic;

  -- operation selector
  -- '0' = addition
  -- '1' = subtraction
  signal add_sub_sel : std_logic;

  -- arithmetic result
  signal result_sig : std_logic_vector(3 downto 0);
  signal result     : std_logic_vector(3 downto 0);

  -- 4-bit versions of A and B for seven segment displays
  signal a_display : std_logic_vector(3 downto 0);
  signal b_display : std_logic_vector(3 downto 0);


begin



  a_sync_inst : entity work.synchronizer_3bit
    port map (
      clk      => clk,
      reset    => reset,
      async_in => a,
      sync_out => a_sync
    );


 

  b_sync_inst : entity work.synchronizer_3bit
    port map (
      clk      => clk,
      reset    => reset,
      async_in => b,
      sync_out => b_sync
    );


  add_btn_inst : entity work.rising_edge_synchronizer
    port map (
      clk       => clk,
      reset     => reset,
      async_in  => add_btn,
      sync_edge => add_en
    );


  sub_btn_inst : entity work.rising_edge_synchronizer
    port map (
      clk       => clk,
      reset     => reset,
      async_in  => sub_btn,
      sync_edge => sub_en
    );


  ---------------------------------------------------------------------------
  -- OPERATION CONTROL
  --
  -- Add button      -> add_sub_sel = '0'
  -- Subtract button -> add_sub_sel = '1'
  ---------------------------------------------------------------------------

  op_ctrl : process(reset, clk)
  begin

    if reset = '1' then

      add_sub_sel <= '0';

    elsif rising_edge(clk) then

      if add_en = '1' then

        add_sub_sel <= '0';

      elsif sub_en = '1' then

        add_sub_sel <= '1';

      end if;

    end if;

  end process;


  ---------------------------------------------------------------------------
  -- ADD / SUBTRACT ARITHMETIC BLOCK
  ---------------------------------------------------------------------------

  arithmetic_inst : entity work.generic_add_sub
    port map (
      a       => a_sync,
      b       => b_sync,
      add_sub => add_sub_sel,
      result  => result_sig
    );




  result <= result_sig;


  a_display <= '0' & a_sync;
  
  b_display <= '0' & b_sync;




  a_display_inst : entity work.seven_seg
  port map (
    clk           => clk,
    reset         => reset,
    bcd           => a_display,
    seven_seg_out => a_bcd
  );


b_display_inst : entity work.seven_seg
  port map (
    clk           => clk,
    reset         => reset,
    bcd           => b_display,
    seven_seg_out => b_bcd
  );


result_display_inst : entity work.seven_seg
  port map (
    clk           => clk,
    reset         => reset,
    bcd           => result,
    seven_seg_out => result_bcd
  );


end structural;
