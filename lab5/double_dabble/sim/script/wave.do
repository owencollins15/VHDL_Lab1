onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /double_dabble_tb/output
add wave -noupdate /double_dabble_tb/clk
add wave -noupdate /double_dabble_tb/reset
add wave -noupdate -radix decimal /double_dabble_tb/uut/result_padded
add wave -noupdate -radix decimal /double_dabble_tb/uut/ones
add wave -noupdate -radix decimal /double_dabble_tb/uut/tens
add wave -noupdate -radix decimal /double_dabble_tb/uut/hundreds
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {417112 ps} 0}
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
WaveRestoreZoom {400250 ps} {505250 ps}
