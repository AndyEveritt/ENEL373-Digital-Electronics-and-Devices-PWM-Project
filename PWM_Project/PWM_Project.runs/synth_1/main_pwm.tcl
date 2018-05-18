# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.cache/wt [current_project]
set_property parent.project_path E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/sources_1/new/PWM_generator.vhd
  E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/sources_1/new/multiplex_seven_seg.vhd
  E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/sources_1/new/debounce.vhd
  E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/sources_1/imports/Simple_VHDL_modules_RTL_Schematic_examples/clock_divider.vhd
  E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/sources_1/new/binary_bcd.vhd
  E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/sources_1/new/Finite_State_Machine.vhd
  E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/sources_1/imports/new/main_pwm.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/constrs_1/imports/Simple_VHDL_modules_RTL_Schematic_examples/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/constrs_1/imports/Simple_VHDL_modules_RTL_Schematic_examples/Nexys4DDR_Master.xdc]


synth_design -top main_pwm -part xc7a100tcsg324-3


write_checkpoint -force -noxdef main_pwm.dcp

catch { report_utilization -file main_pwm_utilization_synth.rpt -pb main_pwm_utilization_synth.pb }
