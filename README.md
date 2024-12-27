# Deepmentor_task

# Delieverables
1. Half-precision floating-point(f16)乘法器設計

i. Design Verilog 檔案

ii. Design 說明文件

iii. Testbench

2. FPGA 測試流程和結果

i. 流程說明文件

ii. 專案啟動腳本(tcl): 從 source code 建立 viado 專案的流程說明，以及使用 vitis 測試 IP 的流程說明

iii. Vivado 合成結果 report: timing, resource

3. FPGA 執行成果截圖

# Requirements:
1. Should implement subnormal numbers as input and output.
2. No need to support infinity and NaN.
3. Should implement f16 golden function in FPU_Multiplier.c, and verify the result
from PL.


# Vivado guide: 
https://caslab.ee.ncku.edu.tw/dokuwiki/_media/course:logic_system_practice:pynq_usage.pdf

# FPGA guide: 
https://www.makarenalabs.com/from-pynq-to-bare-metal-the-full-guide/ 
https://caslab.ee.ncku.edu.tw/dokuwiki/_media/course:logic_system_practice:pynq_usage.pdf 



ZYNQ for beginners: programming and connecting the PS and PL | Part 2

https://www.youtube.com/watch?v=AOy5l36DroY 

diligent tutorial on vitis: 

https://www.youtube.com/watch?v=VO5zEzZnoNU

** In order to run/debug a C program on the processor, the jumper for jtag must be disconnected.  All 4 Dip Switches must be ON..So - all 4 "ON" as in the location of the "ON" label on the dip component.
They are all active low.. so they are actually all off.. I think.. but set them to "ON" - as in towards the center of the board and you should be OK. I recall the instructions being unclear.
You should get a green light right away after turning the board on.. if it stays read something is wrong.

** note to self: 
after pressing debug on vitis check the serial connection output on mobaxterm. the output is there. Also do not click run/dubug button on the flow directly, go to the debug menu and start the C program from there instead.


# half-precision floating point format:
https://en.wikipedia.org/wiki/Half-precision_floating-point_format

