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



add wave -noupdate -radix unsigned -group tb /add_sub_tb/a
add wave -noupdate -radix unsigned -group tb /add_sub_tb/b

add wave -noupdate -group tb /add_sub_tb/add_btn
add wave -noupdate -group tb /add_sub_tb/sub_btn


add wave -noupdate -radix unsigned -group uut /add_sub_tb/uut/a_sync
add wave -noupdate -radix unsigned -group uut /add_sub_tb/uut/b_sync

add wave -noupdate -group uut /add_sub_tb/uut/add_en
add wave -noupdate -group uut /add_sub_tb/uut/sub_en

add wave -noupdate -group uut /add_sub_tb/uut/add_sub_sel

add wave -noupdate -radix unsigned -group uut /add_sub_tb/uut/result_sig
add wave -noupdate -radix unsigned -group uut /add_sub_tb/uut/result

add wave -noupdate -radix States -group bcd /add_sub_tb/a_bcd
add wave -noupdate -radix States -group bcd /add_sub_tb/b_bcd
add wave -noupdate -radix States -group bcd /add_sub_tb/result_bcd

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
