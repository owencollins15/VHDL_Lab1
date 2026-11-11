-------------------------------------------------------------------------------
-- Owen Collins
-- calculator top level
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity calculator is
    port (
        clk     : in std_logic;
        reset_n   : in std_logic;
        execute : in std_logic;
        switch  : in std_logic_vector(7 downto 0);
        op      : in std_logic_vector(1 downto 0);

        led     : out std_logic_vector(2 downto 0);
        bcd_0   : out std_logic_vector(6 downto 0);
        bcd_1   : out std_logic_vector(6 downto 0);
        bcd_2   : out std_logic_vector(6 downto 0)
    );
end calculator;

architecture rtl of calculator is

    signal reset : std_logic;
    signal execute_pressed : std_logic;

    -- Synchronized inputs
    signal b_sync       : std_logic_vector(7 downto 0);
    signal op_in        : std_logic_vector(7 downto 0);
    signal op_sync      : std_logic_vector(7 downto 0);
    signal execute_en   : std_logic;

    -- FSM control
    signal load_inputs  : std_logic;
    signal mem_we       : std_logic;
    signal update_addr  : std_logic;

    -- Operand registers
    signal a_reg        : std_logic_vector(7 downto 0);
    signal b_reg        : std_logic_vector(7 downto 0);
    signal op_reg       : std_logic_vector(1 downto 0);

    -- ALU
    signal alu_b        : std_logic_vector(7 downto 0);
    signal alu_out      : std_logic_vector(7 downto 0);
    signal alu_result   : std_logic_vector(7 downto 0);

    -- Memory
    signal mem_out      : std_logic_vector(7 downto 0);
    signal mem_addr     : std_logic_vector(1 downto 0);

    signal latest_addr  : unsigned(1 downto 0) := "00";
    signal write_addr   : unsigned(1 downto 0) := "01";

    -- Display
    signal binary_12    : std_logic_vector(11 downto 0);
    signal ones         : std_logic_vector(3 downto 0);
    signal tens         : std_logic_vector(3 downto 0);
    signal hundreds     : std_logic_vector(3 downto 0);

begin

reset <= not reset_n;
execute_pressed <= not execute;

    -- Input synchronization

    op_in <= "000000" & op;

    b_sync_inst : synchronizer_8bit
        port map (
            clk      => clk,
            reset    => reset,
            async_in => switch,
            sync_out => b_sync
        );

    op_sync_inst : synchronizer_8bit
        port map (
            clk      => clk,
            reset    => reset,
            async_in => op_in,
            sync_out => op_sync
        );

    execute_inst : rising_edge_synchronizer
        port map (
            clk   => clk,
            reset => reset,
            input => execute_pressed,
            edge  => execute_en
        );


    -- FSM

    fsm_inst : entity work.fsm
        port map (
            clk           => clk,
            reset         => reset,
            execute_pulse => execute_en,
            load_inputs   => load_inputs,
            mem_we        => mem_we,
            update_addr   => update_addr,
            led           => led
        );


    -- Operand registers

    reg_inst : entity work.operand_registers
        port map (
            clk         => clk,
            reset       => reset,
            load_inputs => load_inputs,
            mem_out     => mem_out,
            sw_sync     => b_sync,
            op_sync     => op_sync(1 downto 0),
            a_reg       => a_reg,
            b_reg       => b_reg,
            op_reg      => op_reg
        );


    -- ALU
    -- Protect professor's divider when B = 0

    alu_b <= x"01" when b_reg = x"00" else b_reg;

    alu_inst : alu
        port map (
            reset  => reset,
            a      => a_reg,
            b      => alu_b,
            op     => op_reg,
            result => alu_out
        );

    alu_result <= a_reg when
                    b_reg = x"00" and
                    (op_reg = "00" or op_reg = "01")
                  else x"00" when b_reg = x"00"
                  else alu_out;


    -- Memory address control

    process(clk, reset)
    begin
        if reset = '1' then
            latest_addr <= "00";
            write_addr  <= "01";

        elsif rising_edge(clk) then

            if update_addr = '1' then

                latest_addr <= write_addr;

                case write_addr is
                    when "01" =>
                        write_addr <= "10";

                    when "10" =>
                        write_addr <= "11";

                    when others =>
                        write_addr <= "01";
                end case;

            end if;
        end if;
    end process;

    -- Select memory address
    mem_addr <= std_logic_vector(write_addr)
                when mem_we = '1'
                else std_logic_vector(latest_addr);


    -- Result memory

    memory_inst : memory
        generic map (
            addr_width => 2,
            data_width => 8
        )
        port map (
            clk  => clk,
            we   => mem_we,
            addr => mem_addr,
            din  => alu_result,
            dout => mem_out
        );


    -- Binary to BCD conversion

    binary_12 <= "0000" & mem_out;

    bcd_inst : entity work.double_dabble
        port map (
            result_padded => binary_12,
            ones      => ones,
            tens      => tens,
            hundreds  => hundreds
        );


    -- Seven segment displays

    hex0_inst : seven_seg
        port map (
            bcd           => ones,
            seven_seg_out => bcd_0
        );

    hex1_inst : seven_seg
        port map (
            bcd           => tens,
            seven_seg_out => bcd_1
        );

    hex2_inst : seven_seg
        port map (
            bcd           => hundreds,
            seven_seg_out => bcd_2
        );

end rtl;


