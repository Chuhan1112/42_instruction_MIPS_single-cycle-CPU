# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.cache/wt [current_project]
set_property parent.project_path D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/vivado1/Exper2019/signal_V_Test/sorting/sorting.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files c:/Users/Administrator/Desktop/zch/4.28.coe
read_verilog -library xil_defaultlib {
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/EXT.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/FPGA/MIO_BUS.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/FPGA/Multi_CH32.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/ctrl_encode_def.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/NPC.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/PC.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/RF.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/alu.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/FPGA/clk_div.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/ctrl.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/dm.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/mux.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/signal/sccpu.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/FPGA/seg7x16.v
  D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/imports/zch/FPGA/SCPU_Top.v
}
read_ip -quiet d:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/ip/imem/imem.xci
set_property used_in_implementation false [get_files -all d:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/ip/imem/imem_ooc.xdc]
set_property is_locked true [get_files d:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/sources_1/ip/imem/imem.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/constrs_1/imports/zch/Nexys4DDR_CPU.xdc
set_property used_in_implementation false [get_files D:/vivado1/Exper2019/signal_V_Test/sorting/sorting.srcs/constrs_1/imports/zch/Nexys4DDR_CPU.xdc]


synth_design -top IP2SOC_Top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef IP2SOC_Top.dcp

catch { report_utilization -file IP2SOC_Top_utilization_synth.rpt -pb IP2SOC_Top_utilization_synth.pb }
