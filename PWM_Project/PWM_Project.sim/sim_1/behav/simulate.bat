@echo off
set xv_path=D:\\Programs\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim main_pwm_tb_behav -key {Behavioral:sim_1:Functional:main_pwm_tb} -tclbatch main_pwm_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
