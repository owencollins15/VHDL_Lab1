vlib work
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../src/double_dabble_tb.vhd
vsim -voptargs=+acc double_dabble_tb
do wave.do
run 500 ns