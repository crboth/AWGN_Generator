@echo off
set xv_path=D:\\Programs\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto cc2eef7c02354758abac02fe123d5b30 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot AWGN_tb_behav xil_defaultlib.AWGN_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
