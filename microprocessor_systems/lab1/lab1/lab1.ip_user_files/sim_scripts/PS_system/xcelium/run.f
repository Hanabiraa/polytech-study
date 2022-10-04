-makelib xcelium_lib/xilinx_vip -sv \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "F:/Programms/XILINX/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../lab1.srcs/sources_1/bd/PS_system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_5 -sv \
  "../../../../lab1.srcs/sources_1/bd/PS_system/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/processing_system7_vip_v1_0_7 -sv \
  "../../../../lab1.srcs/sources_1/bd/PS_system/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/PS_system/ip/PS_system_processing_system7_0_0/sim/PS_system_processing_system7_0_0.v" \
  "../../../bd/PS_system/sim/PS_system.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

