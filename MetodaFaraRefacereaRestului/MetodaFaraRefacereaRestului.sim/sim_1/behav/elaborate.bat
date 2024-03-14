@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto df5ee85882dc45fe8b9e913e23b99bbe -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_behav xil_defaultlib.tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
