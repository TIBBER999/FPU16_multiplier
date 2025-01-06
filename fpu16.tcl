# STEP#1: define the output directory area.
#
set outputDir ./fpu16_output
file mkdir $outputDir
#
# STEP#2: setup design sources and constraints
#
#read_verilog [ glob ./*.v ]
#read_xdc ./ZYNQ_xdc.xdc
#
# STEP#3: run synthesis, write design checkpoint, report timing,
# and utilization estimates
#
#part number for the PYNQ board
synth_design -top zynq_pl_wrapper -part xc7z020clg400-1 
write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt
#
# Run custom script to report critical timing paths reportCriticalPaths $outputDir/post_synth_critpath_report.csv
#
# STEP#4: run logic optimization, placement and physical logic optimization,
# write design checkpoint, report utilization and timing estimates opt_design reportCriticalPaths $outputDir/post_opt_critpath_report.csv place_design report_clock_utilization -file $outputDir/clock_util.rpt
#
# Optionally run optimization if there are timing violations after placement
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] <
0} {
 puts "Found setup timing violations => running physical optimization"
 phys_opt_design
}
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt
#
# STEP#5: run the router, write the post-route design checkpoint, report the routing
# status, report timing, power, and DRC, and finally save the Verilog netlist.
#
reset_run synth_1
launch_runs synth_1 -jobs 10 -scripts_only

#
# STEP#6: generate a bitstream
#
launch_runs impl_1
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 10
wait_on_run impl_1
write_hw_platform -fixed -include_bit -force -file $outputDir/zynq_pl_wrapper.xsa