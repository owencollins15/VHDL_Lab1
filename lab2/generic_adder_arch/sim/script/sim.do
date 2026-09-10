vlib work 
vcom -93 -work work ../../src/full_adder_single_bit_arch/src/full_adder_single_bit_arch.vhd 
vcom -93 -work work ../../src/generic_adder_arch.vhd 
vcom -93 -work work ../src/generic_adder_tb.vhd 
vsim -voptargs=+acc generic_adder_tb 
do wave.do 
run 6 us 