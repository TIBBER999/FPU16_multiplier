

#include <stdio.h>
#include <xparameters.h>
#include <xil_io.h>
#include <xil_printf.h>
#include <xtime_l.h>
#include <stdint.h>

#define BASE_ADDR 0x40000000 // Base address for MM2C interface
#define C_ADDR_CTRL 0x00     // Control register address
#define C_ADDR_OP_A 0x04     // Operand A address
#define C_ADDR_OP_B 0x08     // Operand B address
#define C_ADDR_FPU_RESULT 0x0C // FPU result address
#define XTIME_CLK_FREQ_HZ 100000000 // Example for a 100 MHz clock

// Function prototypes
void sendToPL(int a, int b) ;
float fpuMultiplication(float a, float b);
float decode(uint16_t float16_value);
unsigned int float32_to_shifted_uint32(float value) ;
float shifted_uint32_to_float32(unsigned int half_value);



XTime start, end;
XTime start2, end2;

int main() {
    float opA, opB; // User Inputs
    double plTime, psTime;
    while(1){

    // Take user input for operands
    printf("Enter Operand A (float): ");
    //fflush(stdout); // Flush the output buffer to ensure the prompt is displayed
    scanf("%f", &opA);

    printf("\nEnter Operand B (float): ");
    //fflush(stdout); // Flush the output buffer to ensure the prompt is displayed
    scanf("%f", &opB);

    // Print operands
    printf("\nUsing user-defined operands:\n");
    printf("Operand A: %0.4f\n", opA);
    printf("Operand B: %0.4f\n", opB);

    uint32_t opA_16 = float32_to_shifted_uint32 (opA);
    uint32_t opB_16 = float32_to_shifted_uint32 (opB);
    //printf("converted A, B (decimals): %X, %X", opA_16, opB_16);

    // Measure time and send to PL (FPGA)
    XTime_GetTime(&start2);

    sendToPL(opA_16, opB_16);
    XTime_GetTime(&end2);
    plTime = (double)(end2 - start2) * 1000000.0 / XTIME_CLK_FREQ_HZ; // Convert to microseconds

    // Perform FPU multiplication on PS (Processor) 
    /*
    XTime_GetTime(&start);
    float psResult = fpuMultiplication(opA, opB);
    XTime_GetTime(&end);
    psTime = (double)(end - start) * 1000000.0 / XTIME_CLK_FREQ_HZ; // Convert to microseconds
*/
    // Get the result from PL (FPGA)
    float plResult = *(float*)(BASE_ADDR + C_ADDR_FPU_RESULT);
    // result from function
    unsigned int func_result = Xil_In32(BASE_ADDR+C_ADDR_FPU_RESULT);
    //unsigned short fp32_decoded = (func_result & 0x7fffffff)>>16; //right shift it to eliminate all the LSB 0s
    //float converted = decode((unsigned short) 10);
    // Print results
    float ps_result = shifted_uint32_to_float32 (func_result);

    //printf("\nFPU Result from PL: %f\n", plResult);
    printf("Time taken for PL FPU multiplication: %0.2f microseconds\n", plTime);
    printf("FPU Result from PL: %f\n", ps_result);
    //printf("FPU Result from converted: %f\n", converted);
    //printf("Time taken for PS FPU multiplication: %0.2f microseconds\n", psTime);
    //printf("**********************************************************\n");
    }

    return 0;
}

void sendToPL(int a, int b) {
    XTime_GetTime(&start2);
    // Send data to PL via MM2C interface
    Xil_Out32(BASE_ADDR + C_ADDR_OP_A, *((uint32_t*)&a)); // Correct casting to uint32_t for operand A
    Xil_Out32(BASE_ADDR + C_ADDR_OP_B, *((uint32_t*)&b)); // Correct casting to uint32_t for operand B
	
    XTime_GetTime(&end2);
}

unsigned int float32_to_shifted_uint32(float value) {
    uint32_t bits = *((uint32_t*)&value); // Ensure value is properly aligned

    // Extract components
    uint32_t sign = (bits >> 31) & 0x1;
    int32_t exponent = ((bits >> 23) & 0xFF) - 127;
    uint32_t mantissa = bits & 0x007FFFFF;

    uint32_t half_sign = sign << 15;
    uint32_t half_exponent;
    uint32_t half_mantissa;

    // Handle special cases for half-precision representation
    if (exponent == 128) { 
        half_exponent = 31; // Inf or NaN
        half_mantissa = (mantissa != 0) ? 0x200 : 0; 
    } else if (exponent > 15) { 
        half_exponent = 31; // Overflow to Inf
        half_mantissa = 0; 
    } else if (exponent >= -14) { 
        half_exponent = exponent + 15; 
        half_mantissa = mantissa >> 13; 
    } else if (exponent >= -24) { 
        half_exponent = 0; 
        half_mantissa = (mantissa | 0x800000) >> (14 - exponent); 
    } else { 
        half_exponent = 0; 
        half_mantissa = 0; 
    }

    unsigned int half = (half_sign | (half_exponent << 10) | (half_mantissa & 0x3FF))<<16;
    
    // Shift the 16-bit half into the upper 16 bits of uint32_t and return
    return half;
}

float shifted_uint32_to_float32(unsigned int half_value) {
    // Extract the half-precision components from the upper 16 bits
    uint32_t half = (half_value >> 16) & 0xFFFF; // Get the upper 16 bits
    uint32_t sign = (half >> 15) & 0x1; // Extract the sign bit
    uint32_t half_exponent = (half >> 10) & 0x1F; // Extract the exponent
    uint32_t half_mantissa = half & 0x3FF; // Extract the mantissa

    // Initialize 32-bit float components
    uint32_t bits = 0;

    // Handle special cases
    if (half_exponent == 0x1F) { // Inf or NaN
        bits = (sign << 31) | (0xFF << 23) | (half_mantissa ? 0x7FFFFF : 0); // Set mantissa if NaN
    } else if (half_exponent == 0) { // Zero or subnormal
        bits = (sign << 31); // Zero
    } else { // Normalized
        // Adjust exponent from half-precision to single-precision
        int32_t exponent = (int32_t)half_exponent - 15 + 127; // Convert bias

        // Assemble the new 32-bit float
        bits = (sign << 31) | (exponent << 23) | (half_mantissa << 13);
    }

    // Convert bits back to float
    float result;
    *((uint32_t*)&result) = bits; // Use pointer casting for assignment

    return result;
}