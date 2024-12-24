# Deepmentor_task

# Delieverables
1. Half-precision floating-point(f16)乘法器設計
⚫ Design Verilog 檔案
⚫ Design 說明文件
⚫ Testbench
2. FPGA 測試流程和結果
⚫ 流程說明文件
⚫ 專案啟動腳本(tcl): 從 source code 建立 viado 專案的流程說明，以及使
用 vitis 測試 IP 的流程說明
⚫ Vivado 合成結果 report: timing, resource
3. FPGA 執行成果截圖

# Requirements:
1. Should implement subnormal numbers as input and output.
2. No need to support infinity and NaN.
3. Should implement f16 golden function in FPU_Multiplier.c, and verify the result
from PL.


# FPGA guide: 
https://www.makarenalabs.com/from-pynq-to-bare-metal-the-full-guide/ 
https://caslab.ee.ncku.edu.tw/dokuwiki/_media/course:logic_system_practice:pynq_usage.pdf 

# half-precision floating point format:
https://en.wikipedia.org/wiki/Half-precision_floating-point_format

