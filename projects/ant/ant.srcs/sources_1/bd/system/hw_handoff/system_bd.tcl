
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# sync_bits, ad_bus_mux, ad_bus_mux, sync_bits, ad_bus_mux, ad_bus_mux, util_pulse_gen

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg400-2
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: tx_fir_interpolator
proc create_hier_cell_tx_fir_interpolator { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_tx_fir_interpolator() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I aclk
  create_bd_pin -dir I active
  create_bd_pin -dir I dac_enable_0
  create_bd_pin -dir I dac_enable_1
  create_bd_pin -dir I dac_valid_0
  create_bd_pin -dir I dac_valid_1
  create_bd_pin -dir I -from 15 -to 0 data_in_0
  create_bd_pin -dir I -from 15 -to 0 data_in_1
  create_bd_pin -dir O -from 15 -to 0 data_out_0
  create_bd_pin -dir O -from 15 -to 0 data_out_1
  create_bd_pin -dir O enable_out_0
  create_bd_pin -dir O enable_out_1
  create_bd_pin -dir I load_config
  create_bd_pin -dir I -type rst out_resetn
  create_bd_pin -dir I -from 31 -to 0 pulse_width
  create_bd_pin -dir O valid_out_0
  create_bd_pin -dir O valid_out_1

  # Create instance: cdc_sync_active, and set properties
  set block_name sync_bits
  set block_cell_name cdc_sync_active
  if { [catch {set cdc_sync_active [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $cdc_sync_active eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: fir_interpolation_0, and set properties
  set fir_interpolation_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_interpolation_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {61.44} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {1} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Interpolation} \
   CONFIG.Interpolation_Rate {8} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {7.68} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_interpolation_0

  # Create instance: fir_interpolation_1, and set properties
  set fir_interpolation_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_interpolation_1 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {61.44} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {1} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Interpolation} \
   CONFIG.Interpolation_Rate {8} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {7.68} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_interpolation_1

  # Create instance: logic_and_0, and set properties
  set logic_and_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 logic_and_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $logic_and_0

  # Create instance: logic_and_1, and set properties
  set logic_and_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 logic_and_1 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $logic_and_1

  # Create instance: out_mux_0, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_0
  if { [catch {set out_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_0

  # Create instance: out_mux_1, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_1
  if { [catch {set out_mux_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_1

  # Create instance: rate_gen, and set properties
  set block_name util_pulse_gen
  set block_cell_name rate_gen
  if { [catch {set rate_gen [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $rate_gen eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.PULSE_PERIOD {7} \
   CONFIG.PULSE_WIDTH {1} \
 ] $rate_gen

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins cdc_sync_active/out_clk] [get_bd_pins fir_interpolation_0/aclk] [get_bd_pins fir_interpolation_1/aclk] [get_bd_pins rate_gen/clk]
  connect_bd_net -net active_1 [get_bd_pins active] [get_bd_pins cdc_sync_active/in_bits]
  connect_bd_net -net cdc_sync_active_out_bits [get_bd_pins cdc_sync_active/out_bits] [get_bd_pins out_mux_0/select_path] [get_bd_pins out_mux_1/select_path] [get_bd_pins rate_gen/rstn]
  connect_bd_net -net dac_enable_0_1 [get_bd_pins dac_enable_0] [get_bd_pins out_mux_0/enable_in_0] [get_bd_pins out_mux_0/enable_in_1]
  connect_bd_net -net dac_enable_1_1 [get_bd_pins dac_enable_1] [get_bd_pins out_mux_1/enable_in_0] [get_bd_pins out_mux_1/enable_in_1]
  connect_bd_net -net dac_valid_0_1 [get_bd_pins dac_valid_0] [get_bd_pins logic_and_0/Op2] [get_bd_pins out_mux_0/valid_in_0]
  connect_bd_net -net dac_valid_1_1 [get_bd_pins dac_valid_1] [get_bd_pins logic_and_1/Op2] [get_bd_pins out_mux_1/valid_in_0]
  connect_bd_net -net data_in_0_1 [get_bd_pins data_in_0] [get_bd_pins fir_interpolation_0/s_axis_data_tdata] [get_bd_pins out_mux_0/data_in_0]
  connect_bd_net -net data_in_1_1 [get_bd_pins data_in_1] [get_bd_pins fir_interpolation_1/s_axis_data_tdata] [get_bd_pins out_mux_1/data_in_0]
  connect_bd_net -net fir_interpolation_0_m_axis_data_tdata [get_bd_pins fir_interpolation_0/m_axis_data_tdata] [get_bd_pins out_mux_0/data_in_1]
  connect_bd_net -net fir_interpolation_1_m_axis_data_tdata [get_bd_pins fir_interpolation_1/m_axis_data_tdata] [get_bd_pins out_mux_1/data_in_1]
  connect_bd_net -net load_config_1 [get_bd_pins load_config] [get_bd_pins rate_gen/load_config]
  connect_bd_net -net logic_and_0_Res [get_bd_pins fir_interpolation_0/s_axis_data_tvalid] [get_bd_pins logic_and_0/Res]
  connect_bd_net -net logic_and_1_Res [get_bd_pins fir_interpolation_1/s_axis_data_tvalid] [get_bd_pins logic_and_1/Res]
  connect_bd_net -net out_mux_0_data_out [get_bd_pins data_out_0] [get_bd_pins out_mux_0/data_out]
  connect_bd_net -net out_mux_0_enable_out [get_bd_pins enable_out_0] [get_bd_pins out_mux_0/enable_out]
  connect_bd_net -net out_mux_0_valid_out [get_bd_pins valid_out_0] [get_bd_pins out_mux_0/valid_out]
  connect_bd_net -net out_mux_1_data_out [get_bd_pins data_out_1] [get_bd_pins out_mux_1/data_out]
  connect_bd_net -net out_mux_1_enable_out [get_bd_pins enable_out_1] [get_bd_pins out_mux_1/enable_out]
  connect_bd_net -net out_mux_1_valid_out [get_bd_pins valid_out_1] [get_bd_pins out_mux_1/valid_out]
  connect_bd_net -net out_resetn_1 [get_bd_pins out_resetn] [get_bd_pins cdc_sync_active/out_resetn]
  connect_bd_net -net pulse_width_1 [get_bd_pins pulse_width] [get_bd_pins rate_gen/pulse_period] [get_bd_pins rate_gen/pulse_width]
  connect_bd_net -net rate_gen_pulse [get_bd_pins logic_and_0/Op1] [get_bd_pins logic_and_1/Op1] [get_bd_pins out_mux_0/valid_in_1] [get_bd_pins out_mux_1/valid_in_1] [get_bd_pins rate_gen/pulse]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: rx_fir_decimator
proc create_hier_cell_rx_fir_decimator { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_rx_fir_decimator() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I aclk
  create_bd_pin -dir I active
  create_bd_pin -dir I -from 15 -to 0 data_in_0
  create_bd_pin -dir I -from 15 -to 0 data_in_1
  create_bd_pin -dir O -from 15 -to 0 data_out_0
  create_bd_pin -dir O -from 15 -to 0 data_out_1
  create_bd_pin -dir I enable_in_0
  create_bd_pin -dir I enable_in_1
  create_bd_pin -dir O enable_out_0
  create_bd_pin -dir O enable_out_1
  create_bd_pin -dir I -type rst out_resetn
  create_bd_pin -dir I valid_in_0
  create_bd_pin -dir I valid_in_1
  create_bd_pin -dir O valid_out_0
  create_bd_pin -dir O valid_out_1

  # Create instance: cdc_sync_active, and set properties
  set block_name sync_bits
  set block_cell_name cdc_sync_active
  if { [catch {set cdc_sync_active [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $cdc_sync_active eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: fir_decimation_0, and set properties
  set fir_decimation_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_decimation_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {61.44} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {8} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Decimation} \
   CONFIG.Interpolation_Rate {1} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {61.44} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_decimation_0

  # Create instance: fir_decimation_1, and set properties
  set fir_decimation_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_decimation_1 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {61.44} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {8} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Decimation} \
   CONFIG.Interpolation_Rate {1} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {61.44} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_decimation_1

  # Create instance: out_mux_0, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_0
  if { [catch {set out_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_0

  # Create instance: out_mux_1, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_1
  if { [catch {set out_mux_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_1

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins cdc_sync_active/out_clk] [get_bd_pins fir_decimation_0/aclk] [get_bd_pins fir_decimation_1/aclk]
  connect_bd_net -net active_1 [get_bd_pins active] [get_bd_pins cdc_sync_active/in_bits]
  connect_bd_net -net cdc_sync_active_out_bits [get_bd_pins cdc_sync_active/out_bits] [get_bd_pins out_mux_0/select_path] [get_bd_pins out_mux_1/select_path]
  connect_bd_net -net data_in_0_1 [get_bd_pins data_in_0] [get_bd_pins fir_decimation_0/s_axis_data_tdata] [get_bd_pins out_mux_0/data_in_0]
  connect_bd_net -net data_in_1_1 [get_bd_pins data_in_1] [get_bd_pins fir_decimation_1/s_axis_data_tdata] [get_bd_pins out_mux_1/data_in_0]
  connect_bd_net -net enable_in_0_1 [get_bd_pins enable_in_0] [get_bd_pins out_mux_0/enable_in_0] [get_bd_pins out_mux_0/enable_in_1]
  connect_bd_net -net enable_in_1_1 [get_bd_pins enable_in_1] [get_bd_pins out_mux_1/enable_in_0] [get_bd_pins out_mux_1/enable_in_1]
  connect_bd_net -net fir_decimation_0_m_axis_data_tdata [get_bd_pins fir_decimation_0/m_axis_data_tdata] [get_bd_pins out_mux_0/data_in_1]
  connect_bd_net -net fir_decimation_0_m_axis_data_tvalid [get_bd_pins fir_decimation_0/m_axis_data_tvalid] [get_bd_pins out_mux_0/valid_in_1]
  connect_bd_net -net fir_decimation_1_m_axis_data_tdata [get_bd_pins fir_decimation_1/m_axis_data_tdata] [get_bd_pins out_mux_1/data_in_1]
  connect_bd_net -net fir_decimation_1_m_axis_data_tvalid [get_bd_pins fir_decimation_1/m_axis_data_tvalid] [get_bd_pins out_mux_1/valid_in_1]
  connect_bd_net -net out_mux_0_data_out [get_bd_pins data_out_0] [get_bd_pins out_mux_0/data_out]
  connect_bd_net -net out_mux_0_enable_out [get_bd_pins enable_out_0] [get_bd_pins out_mux_0/enable_out]
  connect_bd_net -net out_mux_0_valid_out [get_bd_pins valid_out_0] [get_bd_pins out_mux_0/valid_out]
  connect_bd_net -net out_mux_1_data_out [get_bd_pins data_out_1] [get_bd_pins out_mux_1/data_out]
  connect_bd_net -net out_mux_1_enable_out [get_bd_pins enable_out_1] [get_bd_pins out_mux_1/enable_out]
  connect_bd_net -net out_mux_1_valid_out [get_bd_pins valid_out_1] [get_bd_pins out_mux_1/valid_out]
  connect_bd_net -net out_resetn_1 [get_bd_pins out_resetn] [get_bd_pins cdc_sync_active/out_resetn]
  connect_bd_net -net valid_in_0_1 [get_bd_pins valid_in_0] [get_bd_pins fir_decimation_0/s_axis_data_tvalid] [get_bd_pins out_mux_0/valid_in_0]
  connect_bd_net -net valid_in_1_1 [get_bd_pins valid_in_1] [get_bd_pins fir_decimation_1/s_axis_data_tvalid] [get_bd_pins out_mux_1/valid_in_0]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ddr [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr ]

  set fixed_io [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 fixed_io ]

  set iic_main [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_main ]


  # Create ports
  set enable [ create_bd_port -dir O enable ]
  set gpio_i [ create_bd_port -dir I -from 24 -to 0 gpio_i ]
  set gpio_o [ create_bd_port -dir O -from 24 -to 0 gpio_o ]
  set gpio_t [ create_bd_port -dir O -from 24 -to 0 gpio_t ]
  set powerctrl [ create_bd_port -dir O -from 1 -to 0 powerctrl ]
  set rx_clk_in [ create_bd_port -dir I rx_clk_in ]
  set rx_data_in [ create_bd_port -dir I -from 11 -to 0 rx_data_in ]
  set rx_frame_in [ create_bd_port -dir I rx_frame_in ]
  set spi0_clk_i [ create_bd_port -dir I spi0_clk_i ]
  set spi0_clk_o [ create_bd_port -dir O spi0_clk_o ]
  set spi0_csn_0_o [ create_bd_port -dir O spi0_csn_0_o ]
  set spi0_csn_1_o [ create_bd_port -dir O spi0_csn_1_o ]
  set spi0_csn_2_o [ create_bd_port -dir O spi0_csn_2_o ]
  set spi0_csn_i [ create_bd_port -dir I spi0_csn_i ]
  set spi0_sdi_i [ create_bd_port -dir I spi0_sdi_i ]
  set spi0_sdo_i [ create_bd_port -dir I spi0_sdo_i ]
  set spi0_sdo_o [ create_bd_port -dir O spi0_sdo_o ]
  set spi_clk_i [ create_bd_port -dir I spi_clk_i ]
  set spi_clk_o [ create_bd_port -dir O spi_clk_o ]
  set spi_csn_i [ create_bd_port -dir I spi_csn_i ]
  set spi_csn_o [ create_bd_port -dir O -from 0 -to 0 spi_csn_o ]
  set spi_sdi_i [ create_bd_port -dir I spi_sdi_i ]
  set spi_sdo_i [ create_bd_port -dir I spi_sdo_i ]
  set spi_sdo_o [ create_bd_port -dir O spi_sdo_o ]
  set tx_clk_out [ create_bd_port -dir O tx_clk_out ]
  set tx_data_out [ create_bd_port -dir O -from 11 -to 0 tx_data_out ]
  set tx_frame_out [ create_bd_port -dir O tx_frame_out ]
  set txnrx [ create_bd_port -dir O txnrx ]
  set up_enable [ create_bd_port -dir I up_enable ]
  set up_txnrx [ create_bd_port -dir I up_txnrx ]

  # Create instance: GND_1, and set properties
  set GND_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $GND_1

  # Create instance: GND_32, and set properties
  set GND_32 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND_32 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $GND_32

  # Create instance: VCC_1, and set properties
  set VCC_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 VCC_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $VCC_1

  # Create instance: axi_ad9361, and set properties
  set axi_ad9361 [ create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361 ]
  set_property -dict [ list \
   CONFIG.ADC_INIT_DELAY {21} \
   CONFIG.CMOS_OR_LVDS_N {1} \
   CONFIG.ID {0} \
   CONFIG.MODE_1R1T {0} \
 ] $axi_ad9361

  # Create instance: axi_ad9361_adc_dma, and set properties
  set axi_ad9361_adc_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_adc_dma ]
  set_property -dict [ list \
   CONFIG.AXI_SLICE_DEST {false} \
   CONFIG.AXI_SLICE_SRC {false} \
   CONFIG.CYCLIC {false} \
   CONFIG.DMA_2D_TRANSFER {false} \
   CONFIG.DMA_DATA_WIDTH_SRC {64} \
   CONFIG.DMA_TYPE_DEST {0} \
   CONFIG.DMA_TYPE_SRC {2} \
   CONFIG.SYNC_TRANSFER_START {false} \
 ] $axi_ad9361_adc_dma

  # Create instance: axi_ad9361_dac_dma, and set properties
  set axi_ad9361_dac_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_dac_dma ]
  set_property -dict [ list \
   CONFIG.AXI_SLICE_DEST {false} \
   CONFIG.AXI_SLICE_SRC {false} \
   CONFIG.CYCLIC {true} \
   CONFIG.DMA_2D_TRANSFER {false} \
   CONFIG.DMA_DATA_WIDTH_DEST {64} \
   CONFIG.DMA_TYPE_DEST {1} \
   CONFIG.DMA_TYPE_SRC {0} \
 ] $axi_ad9361_dac_dma

  # Create instance: axi_cmos_tx, and set properties
  set axi_cmos_tx [ create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361_cmos_tx:1.0 axi_cmos_tx ]

  # Create instance: axi_cpu_interconnect, and set properties
  set axi_cpu_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_cpu_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {7} \
 ] $axi_cpu_interconnect

  # Create instance: axi_gpio_power, and set properties
  set axi_gpio_power [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_power ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {2} \
 ] $axi_gpio_power

  # Create instance: axi_iic_main, and set properties
  set axi_iic_main [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_main ]

  # Create instance: axi_spi, and set properties
  set axi_spi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_spi ]
  set_property -dict [ list \
   CONFIG.C_NUM_SS_BITS {1} \
   CONFIG.C_SCK_RATIO {8} \
   CONFIG.C_USE_STARTUP {0} \
 ] $axi_spi

  # Create instance: cpack, and set properties
  set cpack [ create_bd_cell -type ip -vlnv analog.com:user:util_cpack2:1.0 cpack ]

  # Create instance: decim_slice, and set properties
  set decim_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 decim_slice ]

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0 ]
  set_property -dict [ list \
   CONFIG.C_DATA_DEPTH {4096} \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {14} \
   CONFIG.C_PROBE0_WIDTH {16} \
   CONFIG.C_PROBE1_WIDTH {16} \
   CONFIG.C_PROBE2_WIDTH {16} \
   CONFIG.C_PROBE3_WIDTH {16} \
 ] $ila_0

  # Create instance: interp_slice, and set properties
  set interp_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 interp_slice ]

  # Create instance: logic_or, and set properties
  set logic_or [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 logic_or ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
 ] $logic_or

  # Create instance: rx_fir_decimator
  create_hier_cell_rx_fir_decimator [current_bd_instance .] rx_fir_decimator

  # Create instance: sys_concat_intc, and set properties
  set sys_concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 sys_concat_intc ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {16} \
 ] $sys_concat_intc

  # Create instance: sys_ps7, and set properties
  set sys_ps7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 sys_ps7 ]
  set_property -dict [ list \
   CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {666.666687} \
   CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
   CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
   CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
   CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {166.666672} \
   CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {100.000000} \
   CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_CLK0_FREQ {100000000} \
   CONFIG.PCW_CLK1_FREQ {200000000} \
   CONFIG.PCW_CLK2_FREQ {10000000} \
   CONFIG.PCW_CLK3_FREQ {10000000} \
   CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
   CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
   CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
   CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
   CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
   CONFIG.PCW_DM_WIDTH {4} \
   CONFIG.PCW_DQS_WIDTH {4} \
   CONFIG.PCW_DQ_WIDTH {32} \
   CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
   CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
   CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
   CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
   CONFIG.PCW_ENET0_RESET_ENABLE {1} \
   CONFIG.PCW_ENET0_RESET_IO {MIO 46} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET1_RESET_ENABLE {0} \
   CONFIG.PCW_ENET_RESET_ENABLE {1} \
   CONFIG.PCW_ENET_RESET_SELECT {Separate reset pins} \
   CONFIG.PCW_EN_CLK1_PORT {1} \
   CONFIG.PCW_EN_EMIO_ENET0 {0} \
   CONFIG.PCW_EN_EMIO_GPIO {1} \
   CONFIG.PCW_EN_EMIO_SPI0 {1} \
   CONFIG.PCW_EN_ENET0 {1} \
   CONFIG.PCW_EN_GPIO {1} \
   CONFIG.PCW_EN_QSPI {1} \
   CONFIG.PCW_EN_RST1_PORT {1} \
   CONFIG.PCW_EN_SDIO0 {1} \
   CONFIG.PCW_EN_SPI0 {1} \
   CONFIG.PCW_EN_UART1 {1} \
   CONFIG.PCW_EN_USB0 {1} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {2} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK_CLK1_BUF {TRUE} \
   CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} \
   CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.0} \
   CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK2_ENABLE {0} \
   CONFIG.PCW_FPGA_FCLK3_ENABLE {0} \
   CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
   CONFIG.PCW_GPIO_EMIO_GPIO_IO {25} \
   CONFIG.PCW_GPIO_EMIO_GPIO_WIDTH {25} \
   CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
   CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
   CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
   CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_I2C0_RESET_ENABLE {0} \
   CONFIG.PCW_I2C1_GRP_INT_ENABLE {0} \
   CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_I2C1_RESET_ENABLE {0} \
   CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {25} \
   CONFIG.PCW_I2C_RESET_ENABLE {1} \
   CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
   CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
   CONFIG.PCW_IRQ_F2P_INTR {1} \
   CONFIG.PCW_IRQ_F2P_MODE {REVERSE} \
   CONFIG.PCW_MIO_0_DIRECTION {inout} \
   CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_0_PULLUP {enabled} \
   CONFIG.PCW_MIO_0_SLEW {slow} \
   CONFIG.PCW_MIO_10_DIRECTION {inout} \
   CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_10_PULLUP {enabled} \
   CONFIG.PCW_MIO_10_SLEW {slow} \
   CONFIG.PCW_MIO_11_DIRECTION {inout} \
   CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_11_PULLUP {enabled} \
   CONFIG.PCW_MIO_11_SLEW {slow} \
   CONFIG.PCW_MIO_12_DIRECTION {out} \
   CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_12_PULLUP {enabled} \
   CONFIG.PCW_MIO_12_SLEW {slow} \
   CONFIG.PCW_MIO_13_DIRECTION {in} \
   CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_13_PULLUP {enabled} \
   CONFIG.PCW_MIO_13_SLEW {slow} \
   CONFIG.PCW_MIO_14_DIRECTION {inout} \
   CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_14_PULLUP {enabled} \
   CONFIG.PCW_MIO_14_SLEW {slow} \
   CONFIG.PCW_MIO_15_DIRECTION {inout} \
   CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_15_PULLUP {enabled} \
   CONFIG.PCW_MIO_15_SLEW {slow} \
   CONFIG.PCW_MIO_16_DIRECTION {out} \
   CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_16_PULLUP {enabled} \
   CONFIG.PCW_MIO_16_SLEW {slow} \
   CONFIG.PCW_MIO_17_DIRECTION {out} \
   CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_17_PULLUP {enabled} \
   CONFIG.PCW_MIO_17_SLEW {slow} \
   CONFIG.PCW_MIO_18_DIRECTION {out} \
   CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_18_PULLUP {enabled} \
   CONFIG.PCW_MIO_18_SLEW {slow} \
   CONFIG.PCW_MIO_19_DIRECTION {out} \
   CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_19_PULLUP {enabled} \
   CONFIG.PCW_MIO_19_SLEW {slow} \
   CONFIG.PCW_MIO_1_DIRECTION {out} \
   CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_1_PULLUP {enabled} \
   CONFIG.PCW_MIO_1_SLEW {slow} \
   CONFIG.PCW_MIO_20_DIRECTION {out} \
   CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_20_PULLUP {enabled} \
   CONFIG.PCW_MIO_20_SLEW {slow} \
   CONFIG.PCW_MIO_21_DIRECTION {out} \
   CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_21_PULLUP {enabled} \
   CONFIG.PCW_MIO_21_SLEW {slow} \
   CONFIG.PCW_MIO_22_DIRECTION {in} \
   CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_22_PULLUP {enabled} \
   CONFIG.PCW_MIO_22_SLEW {slow} \
   CONFIG.PCW_MIO_23_DIRECTION {in} \
   CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_23_PULLUP {enabled} \
   CONFIG.PCW_MIO_23_SLEW {slow} \
   CONFIG.PCW_MIO_24_DIRECTION {in} \
   CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_24_PULLUP {enabled} \
   CONFIG.PCW_MIO_24_SLEW {slow} \
   CONFIG.PCW_MIO_25_DIRECTION {in} \
   CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_25_PULLUP {enabled} \
   CONFIG.PCW_MIO_25_SLEW {slow} \
   CONFIG.PCW_MIO_26_DIRECTION {in} \
   CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_26_PULLUP {enabled} \
   CONFIG.PCW_MIO_26_SLEW {slow} \
   CONFIG.PCW_MIO_27_DIRECTION {in} \
   CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_27_PULLUP {enabled} \
   CONFIG.PCW_MIO_27_SLEW {slow} \
   CONFIG.PCW_MIO_28_DIRECTION {inout} \
   CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_28_PULLUP {enabled} \
   CONFIG.PCW_MIO_28_SLEW {slow} \
   CONFIG.PCW_MIO_29_DIRECTION {in} \
   CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_29_PULLUP {enabled} \
   CONFIG.PCW_MIO_29_SLEW {slow} \
   CONFIG.PCW_MIO_2_DIRECTION {inout} \
   CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_2_PULLUP {disabled} \
   CONFIG.PCW_MIO_2_SLEW {slow} \
   CONFIG.PCW_MIO_30_DIRECTION {out} \
   CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_30_PULLUP {enabled} \
   CONFIG.PCW_MIO_30_SLEW {slow} \
   CONFIG.PCW_MIO_31_DIRECTION {in} \
   CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_31_PULLUP {enabled} \
   CONFIG.PCW_MIO_31_SLEW {slow} \
   CONFIG.PCW_MIO_32_DIRECTION {inout} \
   CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_32_PULLUP {enabled} \
   CONFIG.PCW_MIO_32_SLEW {slow} \
   CONFIG.PCW_MIO_33_DIRECTION {inout} \
   CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_33_PULLUP {enabled} \
   CONFIG.PCW_MIO_33_SLEW {slow} \
   CONFIG.PCW_MIO_34_DIRECTION {inout} \
   CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_34_PULLUP {enabled} \
   CONFIG.PCW_MIO_34_SLEW {slow} \
   CONFIG.PCW_MIO_35_DIRECTION {inout} \
   CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_35_PULLUP {enabled} \
   CONFIG.PCW_MIO_35_SLEW {slow} \
   CONFIG.PCW_MIO_36_DIRECTION {in} \
   CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_36_PULLUP {enabled} \
   CONFIG.PCW_MIO_36_SLEW {slow} \
   CONFIG.PCW_MIO_37_DIRECTION {inout} \
   CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_37_PULLUP {enabled} \
   CONFIG.PCW_MIO_37_SLEW {slow} \
   CONFIG.PCW_MIO_38_DIRECTION {inout} \
   CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_38_PULLUP {enabled} \
   CONFIG.PCW_MIO_38_SLEW {slow} \
   CONFIG.PCW_MIO_39_DIRECTION {inout} \
   CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_39_PULLUP {enabled} \
   CONFIG.PCW_MIO_39_SLEW {slow} \
   CONFIG.PCW_MIO_3_DIRECTION {inout} \
   CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_3_PULLUP {disabled} \
   CONFIG.PCW_MIO_3_SLEW {slow} \
   CONFIG.PCW_MIO_40_DIRECTION {inout} \
   CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_40_PULLUP {enabled} \
   CONFIG.PCW_MIO_40_SLEW {slow} \
   CONFIG.PCW_MIO_41_DIRECTION {inout} \
   CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_41_PULLUP {enabled} \
   CONFIG.PCW_MIO_41_SLEW {slow} \
   CONFIG.PCW_MIO_42_DIRECTION {inout} \
   CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_42_PULLUP {enabled} \
   CONFIG.PCW_MIO_42_SLEW {slow} \
   CONFIG.PCW_MIO_43_DIRECTION {inout} \
   CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_43_PULLUP {enabled} \
   CONFIG.PCW_MIO_43_SLEW {slow} \
   CONFIG.PCW_MIO_44_DIRECTION {inout} \
   CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_44_PULLUP {enabled} \
   CONFIG.PCW_MIO_44_SLEW {slow} \
   CONFIG.PCW_MIO_45_DIRECTION {inout} \
   CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_45_PULLUP {enabled} \
   CONFIG.PCW_MIO_45_SLEW {slow} \
   CONFIG.PCW_MIO_46_DIRECTION {out} \
   CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_46_PULLUP {enabled} \
   CONFIG.PCW_MIO_46_SLEW {slow} \
   CONFIG.PCW_MIO_47_DIRECTION {out} \
   CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_47_PULLUP {enabled} \
   CONFIG.PCW_MIO_47_SLEW {slow} \
   CONFIG.PCW_MIO_48_DIRECTION {inout} \
   CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_48_PULLUP {enabled} \
   CONFIG.PCW_MIO_48_SLEW {slow} \
   CONFIG.PCW_MIO_49_DIRECTION {inout} \
   CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_49_PULLUP {disabled} \
   CONFIG.PCW_MIO_49_SLEW {slow} \
   CONFIG.PCW_MIO_4_DIRECTION {inout} \
   CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_4_PULLUP {disabled} \
   CONFIG.PCW_MIO_4_SLEW {slow} \
   CONFIG.PCW_MIO_50_DIRECTION {inout} \
   CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_50_PULLUP {enabled} \
   CONFIG.PCW_MIO_50_SLEW {slow} \
   CONFIG.PCW_MIO_51_DIRECTION {inout} \
   CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_51_PULLUP {enabled} \
   CONFIG.PCW_MIO_51_SLEW {slow} \
   CONFIG.PCW_MIO_52_DIRECTION {out} \
   CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_52_PULLUP {enabled} \
   CONFIG.PCW_MIO_52_SLEW {slow} \
   CONFIG.PCW_MIO_53_DIRECTION {inout} \
   CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_53_PULLUP {enabled} \
   CONFIG.PCW_MIO_53_SLEW {slow} \
   CONFIG.PCW_MIO_5_DIRECTION {inout} \
   CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_5_PULLUP {disabled} \
   CONFIG.PCW_MIO_5_SLEW {slow} \
   CONFIG.PCW_MIO_6_DIRECTION {out} \
   CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_6_PULLUP {disabled} \
   CONFIG.PCW_MIO_6_SLEW {slow} \
   CONFIG.PCW_MIO_7_DIRECTION {out} \
   CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_7_PULLUP {disabled} \
   CONFIG.PCW_MIO_7_SLEW {slow} \
   CONFIG.PCW_MIO_8_DIRECTION {out} \
   CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_8_PULLUP {disabled} \
   CONFIG.PCW_MIO_8_SLEW {slow} \
   CONFIG.PCW_MIO_9_DIRECTION {inout} \
   CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_9_PULLUP {enabled} \
   CONFIG.PCW_MIO_9_SLEW {slow} \
   CONFIG.PCW_MIO_PRIMITIVE {54} \
   CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#GPIO#GPIO#GPIO#GPIO#UART 1#UART 1#GPIO#GPIO#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#ENET Reset#USB Reset#GPIO#GPIO#GPIO#GPIO#Enet 0#Enet 0} \
   CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]/HOLD_B#qspi0_sclk#gpio[7]#gpio[8]#gpio[9]#gpio[10]#gpio[11]#tx#rx#gpio[14]#gpio[15]#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#reset#reset#gpio[48]#gpio[49]#gpio[50]#gpio[51]#mdc#mdio} \
   CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
   CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
   CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_PACKAGE_NAME {clg400} \
   CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
   CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
   CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {0} \
   CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
   CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
   CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
   CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
   CONFIG.PCW_SD0_GRP_CD_ENABLE {0} \
   CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
   CONFIG.PCW_SD0_GRP_WP_ENABLE {0} \
   CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
   CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
   CONFIG.PCW_SINGLE_QSPI_DATA_MODE {x4} \
   CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_SPI0_GRP_SS0_ENABLE {1} \
   CONFIG.PCW_SPI0_GRP_SS0_IO {EMIO} \
   CONFIG.PCW_SPI0_GRP_SS1_ENABLE {1} \
   CONFIG.PCW_SPI0_GRP_SS1_IO {EMIO} \
   CONFIG.PCW_SPI0_GRP_SS2_ENABLE {1} \
   CONFIG.PCW_SPI0_GRP_SS2_IO {EMIO} \
   CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SPI0_SPI0_IO {EMIO} \
   CONFIG.PCW_SPI1_GRP_SS0_ENABLE {0} \
   CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} \
   CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} \
   CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {6} \
   CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
   CONFIG.PCW_SPI_PERIPHERAL_VALID {1} \
   CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
   CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_UART1_UART1_IO {MIO 12 .. 13} \
   CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {10} \
   CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
   CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
   CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
   CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.241} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.240} \
   CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
   CONFIG.PCW_UIPARAM_DDR_CL {7} \
   CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
   CONFIG.PCW_UIPARAM_DDR_CWL {6} \
   CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.048} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.050} \
   CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
   CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
   CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J256M16 RE-125} \
   CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
   CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
   CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RC {48.91} \
   CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
   CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
   CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {0} \
   CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
   CONFIG.PCW_USB0_RESET_ENABLE {1} \
   CONFIG.PCW_USB0_RESET_IO {MIO 47} \
   CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
   CONFIG.PCW_USB1_RESET_ENABLE {0} \
   CONFIG.PCW_USB_RESET_ENABLE {1} \
   CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
   CONFIG.PCW_USE_S_AXI_HP1 {1} \
   CONFIG.PCW_USE_S_AXI_HP2 {1} \
 ] $sys_ps7

  # Create instance: sys_rstgen, and set properties
  set sys_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rstgen ]
  set_property -dict [ list \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $sys_rstgen

  # Create instance: tx_fir_interpolator
  create_hier_cell_tx_fir_interpolator [current_bd_instance .] tx_fir_interpolator

  # Create instance: tx_upack, and set properties
  set tx_upack [ create_bd_cell -type ip -vlnv analog.com:user:util_upack2:1.0 tx_upack ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_cpu_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP0]
  connect_bd_intf_net -intf_net axi_ad9361_adc_dma_m_dest_axi [get_bd_intf_pins axi_ad9361_adc_dma/m_dest_axi] [get_bd_intf_pins sys_ps7/S_AXI_HP1]
  connect_bd_intf_net -intf_net axi_ad9361_dac_dma_m_axis [get_bd_intf_pins axi_ad9361_dac_dma/m_axis] [get_bd_intf_pins tx_upack/s_axis]
  connect_bd_intf_net -intf_net axi_ad9361_dac_dma_m_src_axi [get_bd_intf_pins axi_ad9361_dac_dma/m_src_axi] [get_bd_intf_pins sys_ps7/S_AXI_HP2]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M00_AXI [get_bd_intf_pins axi_cmos_tx/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M01_AXI [get_bd_intf_pins axi_cpu_interconnect/M01_AXI] [get_bd_intf_pins axi_iic_main/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M02_AXI [get_bd_intf_pins axi_cpu_interconnect/M02_AXI] [get_bd_intf_pins axi_gpio_power/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M03_AXI [get_bd_intf_pins axi_ad9361/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M03_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M04_AXI [get_bd_intf_pins axi_ad9361_adc_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M04_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M05_AXI [get_bd_intf_pins axi_ad9361_dac_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M05_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M06_AXI [get_bd_intf_pins axi_cpu_interconnect/M06_AXI] [get_bd_intf_pins axi_spi/AXI_LITE]
  connect_bd_intf_net -intf_net axi_iic_main_IIC [get_bd_intf_ports iic_main] [get_bd_intf_pins axi_iic_main/IIC]
  connect_bd_intf_net -intf_net cpack_packed_fifo_wr [get_bd_intf_pins axi_ad9361_adc_dma/fifo_wr] [get_bd_intf_pins cpack/packed_fifo_wr]
  connect_bd_intf_net -intf_net sys_ps7_DDR [get_bd_intf_ports ddr] [get_bd_intf_pins sys_ps7/DDR]
  connect_bd_intf_net -intf_net sys_ps7_FIXED_IO [get_bd_intf_ports fixed_io] [get_bd_intf_pins sys_ps7/FIXED_IO]

  # Create port connections
  connect_bd_net -net GND_1_dout [get_bd_pins GND_1/dout] [get_bd_pins axi_ad9361/tdd_sync] [get_bd_pins sys_concat_intc/In0] [get_bd_pins sys_concat_intc/In1] [get_bd_pins sys_concat_intc/In2] [get_bd_pins sys_concat_intc/In3] [get_bd_pins sys_concat_intc/In4] [get_bd_pins sys_concat_intc/In5] [get_bd_pins sys_concat_intc/In6] [get_bd_pins sys_concat_intc/In7] [get_bd_pins sys_concat_intc/In8] [get_bd_pins sys_concat_intc/In9] [get_bd_pins sys_concat_intc/In10] [get_bd_pins sys_concat_intc/In14] [get_bd_pins tx_fir_interpolator/load_config]
  connect_bd_net -net GND_32_dout [get_bd_pins GND_32/dout] [get_bd_pins tx_fir_interpolator/pulse_width]
  connect_bd_net -net VCC_1_dout [get_bd_pins VCC_1/dout] [get_bd_pins rx_fir_decimator/out_resetn] [get_bd_pins tx_fir_interpolator/out_resetn]
  connect_bd_net -net active_1 [get_bd_pins decim_slice/Dout] [get_bd_pins rx_fir_decimator/active]
  connect_bd_net -net active_2 [get_bd_pins interp_slice/Dout] [get_bd_pins tx_fir_interpolator/active]
  connect_bd_net -net axi_ad9361_adc_data_i0 [get_bd_pins axi_ad9361/adc_data_i0] [get_bd_pins axi_cmos_tx/adc_data_i] [get_bd_pins ila_0/probe2] [get_bd_pins rx_fir_decimator/data_in_0]
  connect_bd_net -net axi_ad9361_adc_data_i1 [get_bd_pins axi_ad9361/adc_data_i1] [get_bd_pins cpack/fifo_wr_data_2]
  connect_bd_net -net axi_ad9361_adc_data_q0 [get_bd_pins axi_ad9361/adc_data_q0] [get_bd_pins axi_cmos_tx/adc_data_q] [get_bd_pins ila_0/probe3] [get_bd_pins rx_fir_decimator/data_in_1]
  connect_bd_net -net axi_ad9361_adc_data_q1 [get_bd_pins axi_ad9361/adc_data_q1] [get_bd_pins cpack/fifo_wr_data_3]
  connect_bd_net -net axi_ad9361_adc_dma_irq [get_bd_pins axi_ad9361_adc_dma/irq] [get_bd_pins sys_concat_intc/In13]
  connect_bd_net -net axi_ad9361_adc_enable_i0 [get_bd_pins axi_ad9361/adc_enable_i0] [get_bd_pins ila_0/probe12] [get_bd_pins rx_fir_decimator/enable_in_0]
  connect_bd_net -net axi_ad9361_adc_enable_i1 [get_bd_pins axi_ad9361/adc_enable_i1] [get_bd_pins cpack/enable_2]
  connect_bd_net -net axi_ad9361_adc_enable_q0 [get_bd_pins axi_ad9361/adc_enable_q0] [get_bd_pins ila_0/probe13] [get_bd_pins rx_fir_decimator/enable_in_1]
  connect_bd_net -net axi_ad9361_adc_enable_q1 [get_bd_pins axi_ad9361/adc_enable_q1] [get_bd_pins cpack/enable_3]
  connect_bd_net -net axi_ad9361_adc_r1_mode [get_bd_pins axi_ad9361/adc_r1_mode] [get_bd_pins ila_0/probe9]
  connect_bd_net -net axi_ad9361_adc_valid_i0 [get_bd_pins axi_ad9361/adc_valid_i0] [get_bd_pins ila_0/probe6] [get_bd_pins rx_fir_decimator/valid_in_0]
  connect_bd_net -net axi_ad9361_adc_valid_q0 [get_bd_pins axi_ad9361/adc_valid_q0] [get_bd_pins ila_0/probe7] [get_bd_pins rx_fir_decimator/valid_in_1]
  connect_bd_net -net axi_ad9361_dac_dma_irq [get_bd_pins axi_ad9361_dac_dma/irq] [get_bd_pins sys_concat_intc/In12]
  connect_bd_net -net axi_ad9361_dac_enable_i0 [get_bd_pins axi_ad9361/dac_enable_i0] [get_bd_pins ila_0/probe10] [get_bd_pins tx_fir_interpolator/dac_enable_0]
  connect_bd_net -net axi_ad9361_dac_enable_i1 [get_bd_pins axi_ad9361/dac_enable_i1] [get_bd_pins tx_upack/enable_2]
  connect_bd_net -net axi_ad9361_dac_enable_q0 [get_bd_pins axi_ad9361/dac_enable_q0] [get_bd_pins ila_0/probe11] [get_bd_pins tx_fir_interpolator/dac_enable_1]
  connect_bd_net -net axi_ad9361_dac_enable_q1 [get_bd_pins axi_ad9361/dac_enable_q1] [get_bd_pins tx_upack/enable_3]
  connect_bd_net -net axi_ad9361_dac_r1_mode [get_bd_pins axi_ad9361/dac_r1_mode] [get_bd_pins ila_0/probe8]
  connect_bd_net -net axi_ad9361_dac_valid_i0 [get_bd_pins axi_ad9361/dac_valid_i0] [get_bd_pins ila_0/probe4] [get_bd_pins tx_fir_interpolator/dac_valid_0]
  connect_bd_net -net axi_ad9361_dac_valid_i1 [get_bd_pins axi_ad9361/dac_valid_i1] [get_bd_pins logic_or/Op2]
  connect_bd_net -net axi_ad9361_dac_valid_q0 [get_bd_pins axi_ad9361/dac_valid_q0] [get_bd_pins ila_0/probe5] [get_bd_pins tx_fir_interpolator/dac_valid_1]
  connect_bd_net -net axi_ad9361_enable [get_bd_ports enable] [get_bd_pins axi_ad9361/enable]
  connect_bd_net -net axi_ad9361_l_clk [get_bd_pins axi_ad9361/clk] [get_bd_pins axi_ad9361/l_clk] [get_bd_pins axi_ad9361_adc_dma/fifo_wr_clk] [get_bd_pins axi_ad9361_dac_dma/m_axis_aclk] [get_bd_pins axi_cmos_tx/clk] [get_bd_pins cpack/clk] [get_bd_pins ila_0/clk] [get_bd_pins rx_fir_decimator/aclk] [get_bd_pins tx_fir_interpolator/aclk] [get_bd_pins tx_upack/clk]
  connect_bd_net -net axi_ad9361_rst [get_bd_pins axi_ad9361/rst] [get_bd_pins cpack/reset] [get_bd_pins tx_upack/reset]
  connect_bd_net -net axi_ad9361_tx_clk_out [get_bd_ports tx_clk_out] [get_bd_pins axi_ad9361/tx_clk_out]
  connect_bd_net -net axi_ad9361_tx_data_out [get_bd_ports tx_data_out] [get_bd_pins axi_ad9361/tx_data_out]
  connect_bd_net -net axi_ad9361_tx_frame_out [get_bd_ports tx_frame_out] [get_bd_pins axi_ad9361/tx_frame_out]
  connect_bd_net -net axi_ad9361_txnrx [get_bd_ports txnrx] [get_bd_pins axi_ad9361/txnrx]
  connect_bd_net -net axi_ad9361_up_adc_gpio_out [get_bd_pins axi_ad9361/up_adc_gpio_out] [get_bd_pins decim_slice/Din]
  connect_bd_net -net axi_ad9361_up_dac_gpio_out [get_bd_pins axi_ad9361/up_dac_gpio_out] [get_bd_pins interp_slice/Din]
  connect_bd_net -net axi_cmos_tx_adc_data_i0 [get_bd_pins axi_ad9361/dac_data_i0] [get_bd_pins axi_cmos_tx/adc_data_i0] [get_bd_pins ila_0/probe0]
  connect_bd_net -net axi_cmos_tx_adc_data_q0 [get_bd_pins axi_ad9361/dac_data_q0] [get_bd_pins axi_cmos_tx/adc_data_q0] [get_bd_pins ila_0/probe1]
  connect_bd_net -net axi_gpio_power_gpio_io_o [get_bd_ports powerctrl] [get_bd_pins axi_gpio_power/gpio_io_o]
  connect_bd_net -net axi_iic_main_iic2intc_irpt [get_bd_pins axi_iic_main/iic2intc_irpt] [get_bd_pins sys_concat_intc/In15]
  connect_bd_net -net axi_spi_io0_o [get_bd_ports spi_sdo_o] [get_bd_pins axi_spi/io0_o]
  connect_bd_net -net axi_spi_ip2intc_irpt [get_bd_pins axi_spi/ip2intc_irpt] [get_bd_pins sys_concat_intc/In11]
  connect_bd_net -net axi_spi_sck_o [get_bd_ports spi_clk_o] [get_bd_pins axi_spi/sck_o]
  connect_bd_net -net axi_spi_ss_o [get_bd_ports spi_csn_o] [get_bd_pins axi_spi/ss_o]
  connect_bd_net -net cpack_fifo_wr_overflow [get_bd_pins axi_ad9361/adc_dovf] [get_bd_pins cpack/fifo_wr_overflow]
  connect_bd_net -net gpio_i_1 [get_bd_ports gpio_i] [get_bd_pins sys_ps7/GPIO_I]
  connect_bd_net -net logic_or_Res [get_bd_pins logic_or/Res] [get_bd_pins tx_upack/fifo_rd_en]
  connect_bd_net -net rx_clk_in_1 [get_bd_ports rx_clk_in] [get_bd_pins axi_ad9361/rx_clk_in]
  connect_bd_net -net rx_data_in_1 [get_bd_ports rx_data_in] [get_bd_pins axi_ad9361/rx_data_in]
  connect_bd_net -net rx_fir_decimator_data_out_0 [get_bd_pins cpack/fifo_wr_data_0] [get_bd_pins rx_fir_decimator/data_out_0]
  connect_bd_net -net rx_fir_decimator_data_out_1 [get_bd_pins cpack/fifo_wr_data_1] [get_bd_pins rx_fir_decimator/data_out_1]
  connect_bd_net -net rx_fir_decimator_enable_out_0 [get_bd_pins cpack/enable_0] [get_bd_pins rx_fir_decimator/enable_out_0]
  connect_bd_net -net rx_fir_decimator_enable_out_1 [get_bd_pins cpack/enable_1] [get_bd_pins rx_fir_decimator/enable_out_1]
  connect_bd_net -net rx_fir_decimator_valid_out_0 [get_bd_pins axi_cmos_tx/adc_valid_i] [get_bd_pins cpack/fifo_wr_en] [get_bd_pins rx_fir_decimator/valid_out_0]
  connect_bd_net -net rx_fir_decimator_valid_out_1 [get_bd_pins axi_cmos_tx/adc_valid_q] [get_bd_pins rx_fir_decimator/valid_out_1]
  connect_bd_net -net rx_frame_in_1 [get_bd_ports rx_frame_in] [get_bd_pins axi_ad9361/rx_frame_in]
  connect_bd_net -net spi0_clk_i_1 [get_bd_ports spi0_clk_i] [get_bd_pins sys_ps7/SPI0_SCLK_I]
  connect_bd_net -net spi0_csn_i_1 [get_bd_ports spi0_csn_i] [get_bd_pins sys_ps7/SPI0_SS_I]
  connect_bd_net -net spi0_sdi_i_1 [get_bd_ports spi0_sdi_i] [get_bd_pins sys_ps7/SPI0_MISO_I]
  connect_bd_net -net spi0_sdo_i_1 [get_bd_ports spi0_sdo_i] [get_bd_pins sys_ps7/SPI0_MOSI_I]
  connect_bd_net -net spi_clk_i_1 [get_bd_ports spi_clk_i] [get_bd_pins axi_spi/sck_i]
  connect_bd_net -net spi_csn_i_1 [get_bd_ports spi_csn_i] [get_bd_pins axi_spi/ss_i]
  connect_bd_net -net spi_sdi_i_1 [get_bd_ports spi_sdi_i] [get_bd_pins axi_spi/io1_i]
  connect_bd_net -net spi_sdo_i_1 [get_bd_ports spi_sdo_i] [get_bd_pins axi_spi/io0_i]
  connect_bd_net -net sys_200m_clk [get_bd_pins axi_ad9361/delay_clk] [get_bd_pins sys_ps7/FCLK_CLK1]
  connect_bd_net -net sys_concat_intc_dout [get_bd_pins sys_concat_intc/dout] [get_bd_pins sys_ps7/IRQ_F2P]
  connect_bd_net -net sys_cpu_clk [get_bd_pins axi_ad9361/s_axi_aclk] [get_bd_pins axi_ad9361_adc_dma/m_dest_axi_aclk] [get_bd_pins axi_ad9361_adc_dma/s_axi_aclk] [get_bd_pins axi_ad9361_dac_dma/m_src_axi_aclk] [get_bd_pins axi_ad9361_dac_dma/s_axi_aclk] [get_bd_pins axi_cmos_tx/s_axi_aclk] [get_bd_pins axi_cpu_interconnect/ACLK] [get_bd_pins axi_cpu_interconnect/M00_ACLK] [get_bd_pins axi_cpu_interconnect/M01_ACLK] [get_bd_pins axi_cpu_interconnect/M02_ACLK] [get_bd_pins axi_cpu_interconnect/M03_ACLK] [get_bd_pins axi_cpu_interconnect/M04_ACLK] [get_bd_pins axi_cpu_interconnect/M05_ACLK] [get_bd_pins axi_cpu_interconnect/M06_ACLK] [get_bd_pins axi_cpu_interconnect/S00_ACLK] [get_bd_pins axi_gpio_power/s_axi_aclk] [get_bd_pins axi_iic_main/s_axi_aclk] [get_bd_pins axi_spi/ext_spi_clk] [get_bd_pins axi_spi/s_axi_aclk] [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins sys_ps7/M_AXI_GP0_ACLK] [get_bd_pins sys_ps7/S_AXI_HP1_ACLK] [get_bd_pins sys_ps7/S_AXI_HP2_ACLK] [get_bd_pins sys_rstgen/slowest_sync_clk]
  connect_bd_net -net sys_cpu_reset [get_bd_pins sys_rstgen/peripheral_reset]
  connect_bd_net -net sys_cpu_resetn [get_bd_pins axi_ad9361/s_axi_aresetn] [get_bd_pins axi_ad9361_adc_dma/m_dest_axi_aresetn] [get_bd_pins axi_ad9361_adc_dma/s_axi_aresetn] [get_bd_pins axi_ad9361_dac_dma/m_src_axi_aresetn] [get_bd_pins axi_ad9361_dac_dma/s_axi_aresetn] [get_bd_pins axi_cmos_tx/s_axi_aresetn] [get_bd_pins axi_cpu_interconnect/ARESETN] [get_bd_pins axi_cpu_interconnect/M00_ARESETN] [get_bd_pins axi_cpu_interconnect/M01_ARESETN] [get_bd_pins axi_cpu_interconnect/M02_ARESETN] [get_bd_pins axi_cpu_interconnect/M03_ARESETN] [get_bd_pins axi_cpu_interconnect/M04_ARESETN] [get_bd_pins axi_cpu_interconnect/M05_ARESETN] [get_bd_pins axi_cpu_interconnect/M06_ARESETN] [get_bd_pins axi_cpu_interconnect/S00_ARESETN] [get_bd_pins axi_gpio_power/s_axi_aresetn] [get_bd_pins axi_iic_main/s_axi_aresetn] [get_bd_pins axi_spi/s_axi_aresetn] [get_bd_pins sys_rstgen/peripheral_aresetn]
  connect_bd_net -net sys_ps7_FCLK_RESET0_N [get_bd_pins sys_ps7/FCLK_RESET0_N] [get_bd_pins sys_rstgen/ext_reset_in]
  connect_bd_net -net sys_ps7_GPIO_O [get_bd_ports gpio_o] [get_bd_pins sys_ps7/GPIO_O]
  connect_bd_net -net sys_ps7_GPIO_T [get_bd_ports gpio_t] [get_bd_pins sys_ps7/GPIO_T]
  connect_bd_net -net sys_ps7_SPI0_MOSI_O [get_bd_ports spi0_sdo_o] [get_bd_pins sys_ps7/SPI0_MOSI_O]
  connect_bd_net -net sys_ps7_SPI0_SCLK_O [get_bd_ports spi0_clk_o] [get_bd_pins sys_ps7/SPI0_SCLK_O]
  connect_bd_net -net sys_ps7_SPI0_SS1_O [get_bd_ports spi0_csn_1_o] [get_bd_pins sys_ps7/SPI0_SS1_O]
  connect_bd_net -net sys_ps7_SPI0_SS2_O [get_bd_ports spi0_csn_2_o] [get_bd_pins sys_ps7/SPI0_SS2_O]
  connect_bd_net -net sys_ps7_SPI0_SS_O [get_bd_ports spi0_csn_0_o] [get_bd_pins sys_ps7/SPI0_SS_O]
  connect_bd_net -net tx_fir_interpolator_enable_out_0 [get_bd_pins tx_fir_interpolator/enable_out_0] [get_bd_pins tx_upack/enable_0]
  connect_bd_net -net tx_fir_interpolator_enable_out_1 [get_bd_pins tx_fir_interpolator/enable_out_1] [get_bd_pins tx_upack/enable_1]
  connect_bd_net -net tx_fir_interpolator_valid_out_0 [get_bd_pins logic_or/Op1] [get_bd_pins tx_fir_interpolator/valid_out_0]
  connect_bd_net -net tx_upack_fifo_rd_data_2 [get_bd_pins axi_ad9361/dac_data_i1] [get_bd_pins tx_upack/fifo_rd_data_2]
  connect_bd_net -net tx_upack_fifo_rd_data_3 [get_bd_pins axi_ad9361/dac_data_q1] [get_bd_pins tx_upack/fifo_rd_data_3]
  connect_bd_net -net up_enable_1 [get_bd_ports up_enable] [get_bd_pins axi_ad9361/up_enable]
  connect_bd_net -net up_txnrx_1 [get_bd_ports up_txnrx] [get_bd_pins axi_ad9361/up_txnrx]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x00000000 [get_bd_addr_spaces axi_ad9361_adc_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_sys_ps7_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x40000000 -offset 0x00000000 [get_bd_addr_spaces axi_ad9361_dac_dma/m_src_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] SEG_sys_ps7_HP2_DDR_LOWOCM
  create_bd_addr_seg -range 0x00010000 -offset 0x79020000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361/s_axi/axi_lite] SEG_data_axi_ad9361
  create_bd_addr_seg -range 0x00001000 -offset 0x7C400000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_adc_dma/s_axi/axi_lite] SEG_data_axi_ad9361_adc_dma
  create_bd_addr_seg -range 0x00001000 -offset 0x7C420000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9361_dac_dma/s_axi/axi_lite] SEG_data_axi_ad9361_dac_dma
  create_bd_addr_seg -range 0x00010000 -offset 0x7C460000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_cmos_tx/s_axi/axi_lite] SEG_data_axi_cmos_tx
  create_bd_addr_seg -range 0x00001000 -offset 0x41200000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_gpio_power/S_AXI/Reg] SEG_data_axi_gpio_power
  create_bd_addr_seg -range 0x00001000 -offset 0x41600000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_iic_main/S_AXI/Reg] SEG_data_axi_iic_main
  create_bd_addr_seg -range 0x00001000 -offset 0x7C430000 [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_spi/AXI_LITE/Reg] SEG_data_axi_spi


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


