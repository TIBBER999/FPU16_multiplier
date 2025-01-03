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

# Implementations:
The role of the 16 bit floating point multiplier(fp16) is to multiply 2 floating points (a, b) and compute its product. The 16 bits floating points representation follows the IEEE 754-2008 standard. According to the standard when the two floating points multiply, its signage is determined by the XOR of the MSB of a and b(a<sub>sign</sub> ^ b<sub>sign</sub>), its exponent is the summation of the two exponents subtracting a bias of 15<sub>10</sub> (a<sub>exp</sub> + b<sub>exp</sub> - 15<sub>10</sub>), and lastly its mantissa is the multiplication of their respective mantissa with a leading 1 as its MSB ({1'b1, a<sub>man</sub>} * {b<sub>man</sub>}).

The following tool can be used to help understand 16 bits floating point multiplication with detailed steps in the calculation:

https://numeral-systems.com/ieee-754-multiply/

https://weitz.de/ieee/

fp16 exponent and mantissa

![image](https://github.com/TIBBER999/Deepmentor_task/blob/main/img/b22592916ffccc87101c4eac9d6722f4.png)


The block diagram of the design in conjuction with the ZYNQ7 processor is shown below
![image](https://github.com/TIBBER999/Deepmentor_task/blob/main/img/block%20diagram.png)

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

Almost all modern uses follow the IEEE 754-2008 standard, where the 16-bit base-2 format is referred to as binary16, and the exponent uses 5 bits. This can express values in the range ±65,504, with the minimum value above 1 being 1 + 1/1024. 

![image](picture or gif url)


