vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../lab3_div.srcs/sources_1/ip/clk_wiz" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../lab3_div.srcs/sources_1/ip/clk_wiz" \
"../../../../lab3_div.srcs/sources_1/ip/clk_wiz/clk_wiz_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"

