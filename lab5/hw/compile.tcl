# Owen Collins
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "add_sub"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY add_sub
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_add_sub_8bit.vhd
set_global_assignment -name VHDL_FILE ../../src/synchronizer_8bit.vhd
set_global_assignment -name VHDL_FILE ../../src/add_sub.vhd
set_global_assignment -name VHDL_FILE ../../src/fsm.vhd
set_global_assignment -name VHDL_FILE ../../src/op_reg.vhd

set_location_assignment PIN_AF14 -to clk
# Active-high reset: SW9
set_location_assignment PIN_AE12 -to reset
# Next button: KEY0
set_location_assignment PIN_AA14 -to next_btn
# 8-bit slide switches: SW0-SW7
set_location_assignment PIN_AB12 -to {sw[0]}
set_location_assignment PIN_AC12 -to {sw[1]}
set_location_assignment PIN_AF9  -to {sw[2]}
set_location_assignment PIN_AF10 -to {sw[3]}
set_location_assignment PIN_AD11 -to {sw[4]}
set_location_assignment PIN_AD12 -to {sw[5]}
set_location_assignment PIN_AE11 -to {sw[6]}
set_location_assignment PIN_AC9  -to {sw[7]}
# State LEDs: LEDR0-LEDR3
set_location_assignment PIN_V16 -to {leds[0]}
set_location_assignment PIN_W16 -to {leds[1]}
set_location_assignment PIN_V17 -to {leds[2]}
set_location_assignment PIN_V18 -to {leds[3]}
# Hundreds display: HEX2
set_location_assignment PIN_AB23 -to {a_bcd[0]}
set_location_assignment PIN_AE29 -to {a_bcd[1]}
set_location_assignment PIN_AD29 -to {a_bcd[2]}
set_location_assignment PIN_AC28 -to {a_bcd[3]}
set_location_assignment PIN_AD30 -to {a_bcd[4]}
set_location_assignment PIN_AC29 -to {a_bcd[5]}
set_location_assignment PIN_AC30 -to {a_bcd[6]}
# Tens display: HEX1
set_location_assignment PIN_AJ29 -to {b_bcd[0]}
set_location_assignment PIN_AH29 -to {b_bcd[1]}
set_location_assignment PIN_AH30 -to {b_bcd[2]}
set_location_assignment PIN_AG30 -to {b_bcd[3]}
set_location_assignment PIN_AF29 -to {b_bcd[4]}
set_location_assignment PIN_AF30 -to {b_bcd[5]}
set_location_assignment PIN_AD27 -to {b_bcd[6]}
# Ones display: HEX0
set_location_assignment PIN_AE26 -to {result_bcd[0]}
set_location_assignment PIN_AE27 -to {result_bcd[1]}
set_location_assignment PIN_AE28 -to {result_bcd[2]}
set_location_assignment PIN_AG27 -to {result_bcd[3]}
set_location_assignment PIN_AF28 -to {result_bcd[4]}
set_location_assignment PIN_AG28 -to {result_bcd[5]}
set_location_assignment PIN_AH28 -to {result_bcd[6]}

execute_flow -compile
project_close