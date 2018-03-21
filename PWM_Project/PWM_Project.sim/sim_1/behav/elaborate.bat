@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 582c66e628344eed9bc3ec90e3b630e9 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot main_pwm_behav xil_defaultlib.main_pwm -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
