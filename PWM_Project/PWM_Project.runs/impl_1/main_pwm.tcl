proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.cache/wt [current_project]
  set_property parent.project_path E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.xpr [current_project]
  set_property ip_repo_paths e:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.cache/ip [current_project]
  set_property ip_output_repo e:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.cache/ip [current_project]
  add_files -quiet E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.runs/synth_1/main_pwm.dcp
  read_xdc E:/Uni/ENEL373/Labs/lab_a02_group_18/PWM_Project/PWM_Project.srcs/constrs_1/imports/Simple_VHDL_modules_RTL_Schematic_examples/Nexys4DDR_Master.xdc
  link_design -top main_pwm -part xc7a100tcsg324-3
  write_hwdef -file main_pwm.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force main_pwm_opt.dcp
  report_drc -file main_pwm_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force main_pwm_placed.dcp
  report_io -file main_pwm_io_placed.rpt
  report_utilization -file main_pwm_utilization_placed.rpt -pb main_pwm_utilization_placed.pb
  report_control_sets -verbose -file main_pwm_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force main_pwm_routed.dcp
  report_drc -file main_pwm_drc_routed.rpt -pb main_pwm_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file main_pwm_timing_summary_routed.rpt -rpx main_pwm_timing_summary_routed.rpx
  report_power -file main_pwm_power_routed.rpt -pb main_pwm_power_summary_routed.pb -rpx main_pwm_power_routed.rpx
  report_route_status -file main_pwm_route_status.rpt -pb main_pwm_route_status.pb
  report_clock_utilization -file main_pwm_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force main_pwm.mmi }
  write_bitstream -force main_pwm.bit 
  catch { write_sysdef -hwdef main_pwm.hwdef -bitfile main_pwm.bit -meminfo main_pwm.mmi -file main_pwm.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

