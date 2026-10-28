onerror {resume}
radix define States {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate  -group tb /add_sub_tb/clk
add wave -noupdate  -group tb /add_sub_tb/reset




# Lab 5 - Waveform Script

# Clock and Reset
add wave -divider "CLOCK AND RESET"
add wave sim:/add_sub_tb/clk
add wave sim:/add_sub_tb/reset

# Switches and Button
add wave -divider "INPUTS"
add wave -radix unsigned sim:/add_sub_tb/sw
add wave sim:/add_sub_tb/next_btn
add wave sim:/add_sub_tb/uut/next_pulse

# FSM Signals
add wave -divider "STATE MACHINE"
add wave -radix binary sim:/add_sub_tb/leds
add wave -radix binary sim:/add_sub_tb/uut/disp_sel
add wave sim:/add_sub_tb/uut/load_a
add wave sim:/add_sub_tb/uut/load_b

# Operand Registers
add wave -divider "OPERANDS"
add wave -radix unsigned sim:/add_sub_tb/uut/a_reg
add wave -radix unsigned sim:/add_sub_tb/uut/b_reg

# Arithmetic
add wave -divider "ARITHMETIC"
add wave sim:/add_sub_tb/uut/add_sub_sel
add wave -radix unsigned sim:/add_sub_tb/uut/result_sig

# Display MUX
add wave -divider "DISPLAY SELECTION"
add wave -radix unsigned sim:/add_sub_tb/uut/result_padded

# Decimal Digits
add wave -divider "BCD OUTPUTS"
add wave -radix unsigned sim:/add_sub_tb/uut/hundreds
add wave -radix unsigned sim:/add_sub_tb/uut/tens
add wave -radix unsigned sim:/add_sub_tb/uut/ones

# Seven-Segment Outputs
add wave -divider "SEVEN SEGMENT"
add wave -radix binary sim:/add_sub_tb/a_bcd
add wave -radix binary sim:/add_sub_tb/b_bcd
add wave -radix binary sim:/add_sub_tb/result_bcd


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {53 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {525 ns}
