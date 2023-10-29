
source ../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

set p_device "xc7z020clg400-2"
adi_project ant
set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 4194304"
adi_project_files ant [list \
  "system_top.v" \
  "system_constr.xdc" \
  "$ad_hdl_dir/library/common/ad_iobuf.v"]

set_property is_enabled false [get_files  *system_sys_ps7_0.xdc]
adi_project_run ant
source $ad_hdl_dir/library/axi_ad9361/axi_ad9361_delay.tcl

