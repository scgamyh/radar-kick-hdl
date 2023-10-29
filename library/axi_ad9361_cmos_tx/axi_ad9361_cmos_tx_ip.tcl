# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip_xilinx.tcl

adi_ip_create axi_ad9361_cmos_tx
adi_ip_files axi_ad9361_cmos_tx [list \
  "$ad_hdl_dir/library/common/up_axi.v" \
  "axi_ad9361_cmos_tx.v"]
set ila_1 [create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila_1]
set_property -dict [list CONFIG.C_MONITOR_TYPE {Native}] [get_ips ila_1]
set_property -dict [list CONFIG.C_NUM_OF_PROBES {15}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE0_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE1_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE2_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE3_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE4_WIDTH {5}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE5_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE6_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE7_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE8_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE9_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE10_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE11_WIDTH {32}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE12_WIDTH {16}] [get_ips ila_1]
set_property -dict [list CONFIG.C_PROBE13_WIDTH {16}] [get_ips ila_1]
set_property -dict [list CONFIG.C_DATA_DEPTH {4096}] [get_ips ila_1]
generate_target {instantiation_template} [get_files /home/myh/Documents/antsdr/antsdr-fw_radar/hdl/projects/ant/ant.srcs/sources_1/ip/ila_1/ila_1.xci]

set cordic0 [create_ip -name cordic -vendor xilinx.com -library ip -version 6.0 -module_name cordic_0 ]
set_property -dict [list CONFIG.Functional_Selection {Translate}] [get_ips cordic_0]
set_property -dict [list CONFIG.Architectural_Configuration {Parallel}]  [get_ips cordic_0]
set_property -dict [list CONFIG.Pipelining_Mode {Optimal} ] [get_ips cordic_0]
set_property -dict [list CONFIG.Coarse_Rotation {true} ] [get_ips cordic_0]
set_property -dict [list CONFIG.Data_Format {SignedFraction} ] [get_ips cordic_0]
set_property -dict [list CONFIG.Compensation_Scaling {No_Scale_Compensation}] [get_ips cordic_0]
generate_target {instantiation_template} [get_files /home/myh/Documents/antsdr/antsdr-fw_radar/hdl/projects/ant/ant.srcs/sources_1/ip/cordic_0/cordic_0.xci]

set ram_shift_reg0 [create_ip -name c_shift_ram -vendor xilinx.com -library ip -version 12.0 -module_name ram_shift_reg0 ]
set_property -dict [list CONFIG.ShiftRegType {Fixed_Length}] [get_ips ram_shift_reg0]
set_property -dict [list CONFIG.Depth {17} ] [get_ips ram_shift_reg0]
set_property -dict [list CONFIG.DefaultDataRadix {16} ] [get_ips ram_shift_reg0]
set_property -dict [list CONFIG.DefaultData {0000}]  [get_ips ram_shift_reg0]
set_property -dict [list CONFIG.AsyncInitRadix {16} ] [get_ips ram_shift_reg0]
set_property -dict [list CONFIG.AsyncInitVal {0000}] [get_ips ram_shift_reg0]
generate_target {instantiation_template} [get_files /home/myh/Documents/antsdr/antsdr-fw_radar/hdl/projects/ant/ant.srcs/sources_1/ip/ram_shift_reg0/ram_shift_reg0.xci]

adi_ip_properties axi_ad9361_cmos_tx
set cc [ipx::current_core]

ipx::save_core $cc
