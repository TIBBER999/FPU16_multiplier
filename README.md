# Deepmentor_task

# Delieverables

1. Half-precision floating-point(f16)乘法器設計

i. Design Verilog 檔案

ii. Design 說明文件

iii. Testbench

2. FPGA 測試流程和結果

i. FPGA 執行成果截圖

ii. 流程說明文件

iii. 專案啟動腳本(tcl): 從 source code 建立 viado 專案的流程說明，以及使用 vitis 測試 IP 的流程說明

iiii. Vivado 合成結果 report: timing, resource



# Implementations:
The role of the 16 bit floating point multiplier(fp16) is to multiply 2 floating points (a, b) and compute its product. The 16 bits floating points representation follows the IEEE 754-2008 standard. 
According to the standard:

signage is determined by the XOR of the MSB of a and b(a<sub>sign</sub> ^ b<sub>sign</sub>)

exponent is the summation of the two exponents subtracting a bias of 15<sub>10</sub> (a<sub>exp</sub> + b<sub>exp</sub> - 15<sub>10</sub>)

mantissa is the multiplication of their respective mantissa with a leading 1 as its MSB ({1'b1, a<sub>man</sub>} * {1'b1, b<sub>man</sub>})

The following tool can be used to help understand 16 bits floating point multiplication with detailed steps in the calculation:

https://numeral-systems.com/ieee-754-multiply/

https://weitz.de/ieee/

fp16 exponent and mantissa

![image](https://github.com/TIBBER999/Deepmentor_task/blob/main/img/b22592916ffccc87101c4eac9d6722f4.png)

The block diagram of the design in conjuction with the ZYNQ7 processor is shown below
![image](https://github.com/TIBBER999/Deepmentor_task/blob/main/img/block%20diagram.png)

# Testbench
In this repository there are two testbenches for verifying the DUT (fp16 unit): 

1. TB_PY_fpu16_multiplier.sv
2. TB_fp16_multiplier.sv

The first testbench (TB_PY_fpu16_multiplier.sv) is an automated random stimulus testbench generated from the python file (Gen_Rand_Stim.py) and it aims to create a random value for both the inputs and check if the output of the DUT is coherent. Inside the Python script, I made a golden model of the fpu16 multiplier using numpy library which could confidently calculate the product of two floating points. Inside the SystemVerilog testbench, the value of the DUT and the golden reference are compared and checked.

The second testbench (TB_fp16_multiplier.sv) is a manual stimulus testbench aiming to target specific edge cases of the DUT such as values like infinity, NaN, zeros, underflow, and overflow. 

The combination of the two sets of testbench can mimic that of the industrial standard and allow reusability in similar projects in the future.

# FPGA 測試流程和結果

I will test the correctness of the system by connecting the FPGA to a host computer with a serial communication port. The FPGA will have a bistream of the DUT and a ZYNQ processing system downloaded to it, and I will be running a c program on it that allow an user to input two operands and display the result of the multiplication on the terminal. The system works correctly and fluently except that it doesn't have input checking so if the user inputs anything other than a float, it will go into an endless loop. The stability of the board raises question as the same code can be built and work and it will not work the next time.

# FPGA 執行成果截圖
Multiplying by float 1

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/a%2Bb.png)

Multiplying by float 2

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/ab_dec.png)

Multiplying by NaN

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/nan.png)

Multiplying by infinity

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/inf.png)

Multiplying by zero

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/zero.png)

# Vivado TCl


1. launch Vivado
2. create project by "File -> Project -> new"
3. Select RTL project
4. Add sources 
5. Add constraint
6. select xc7z020clg400-1 as part number 
3. create block design
4. add ZYNQ7 Processing System, AXI interconnect, Processor System Reset IPs and fpu16)multiplier and mm2c16_interface to the block design and connect it as follow:
![iamge]()
5. right click on the wrapper.bd from the "Design Sources" tab and create HDL wrapper and let vivado manage wrapper.
6. click on run synthesis
7. click on run implementation
8. click on generate Bitstream
9. export the hardware by going to "File -> Export -> Export Hardware" and and select "include bitstream". An .xsa file should be generated.

After the above steps, they will create a project with the IP blocks and perform synthesis, implementation, bitstream generation, and hardware exportation. After the scripts are performed, it will allow vitis to program the device and launch the C program.

# Vitis Unified IDE 

1. Launch vitis
2. Click "Open Workspace" and select the project directory that has been created by Vivado in the previous steps 
3. Select "Create Platform Component" 
![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/platform.png)
4. Press "Next" after naming the platform
5. Select "Hardware Design" and then browse for "zynq_pl_wrapper.xsa" that is located in $PATH_to_repo/fpu16_output/zynq_pl_wrapper.xsa
6. It will automatically select "standalone" for operating system and "ps7_corexa9_0" for processor
7. Finish the wizard.
8. You should see this screen below
9. Under "FLOW", build the platform
![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/after%20platform.png)
10. Select "File -> New Component -> Application" from the IDE,
11. Create an application 
12. select the platform you just created 
13. Press Next until the Wizard finishes
14. Import the fpu_multiplier.c into the src folder  
15. Insert $PATH_to_repo/C_header to $platform_directory/sw/standalone_ps7_cortexa9_0/include
16. Build the Application
17. Program device by clicking "Vitis -> Program Device". Make sure the connection is "Local" and the Bitstream is zynq_pl_wrapper.bit
18. press "debug" for the C program on the IDE
19. Launch MOBAXTERM or similar terminals, select "Session -> serial"
20. choose the corresponding serial port connection to the FPGA board
21. Select "115200" for Speed(bps)
22. Click on "Continue" in the IDE, and you should see a prompt on MOBAXTERM
![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/continue.png)
23. Input values for operand A & B and the project should be displayed on the terminal 

The youtube videos below are introductory videos that will walk through both the Vivado and Vitis steps.
ZYNQ for beginners: programming and connecting the PS and PL | Part 1 & Part 2

https://www.youtube.com/watch?v=_odNhKOZjEo

https://www.youtube.com/watch?v=AOy5l36DroY 

Getting Started with FPGA Design #4: Embedded C Application Basics in FPGAs

https://www.youtube.com/watch?v=VO5zEzZnoNU


The pdf from NCKU is helpful for introducing Vivado and the necessary steps required to build a project from ground up.

https://caslab.ee.ncku.edu.tw/dokuwiki/_media/course:logic_system_practice:pynq_usage.pdf

A common issue in programming the fpga is the jumper connection. In order to run/debug a C program on the processor, the jumper for jtag must be disconnected. All 4 Dip Switches must be ON. They are all active low. You should get a green light right away after turning the board on, if it stays red something is wrong.


# Vivado 合成結果 report: timing, resource
Timing 

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/Timing.png)

Power

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/power.png)

Resources 

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/resources%20.png)

Memory

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/memory.png)

Summary 

![image](https://github.com/TIBBER999/FPU16_multiplier/blob/main/img/summary.png)




