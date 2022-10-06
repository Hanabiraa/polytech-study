#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=F:/Programms/XILINX/SDK/2019.1/bin;F:/Programms/XILINX/Vivado/2019.1/ids_lite/ISE/bin/nt64;F:/Programms/XILINX/Vivado/2019.1/ids_lite/ISE/lib/nt64:F:/Programms/XILINX/Vivado/2019.1/bin
else
  PATH=F:/Programms/XILINX/SDK/2019.1/bin;F:/Programms/XILINX/Vivado/2019.1/ids_lite/ISE/bin/nt64;F:/Programms/XILINX/Vivado/2019.1/ids_lite/ISE/lib/nt64:F:/Programms/XILINX/Vivado/2019.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='G:/polytech-study/microprocessor_systems/lab2/lab2_PS_PL/lab2_PS_PL.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log PS_system_wrapper.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source PS_system_wrapper.tcl -notrace


