import numpy as np
import random 

f16 = np.float16("-1.234")
f161 = np.float16("-1.234")
f16m = f16*f161
print("a", bin(np.float16(f16).view('H'))[2:].zfill(16))
print("b", bin(np.float16(f161).view('H'))[2:].zfill(16))
print("b", bin(np.float16(f16m).view('H'))[2:].zfill(16))


def characters (avalue, bvalue, result_value, i):
    my_chars = f"""
        a = 16'b{avalue};
        b = 16'b{bvalue};  
        #10;
        if (result !== 16'b{result_value}) begin 
            $display("Random{i} wrong"); 
            $stop;
        end
        """
    return my_chars

dut_name = "fpu16_multiplier" 
num_tests = 50
char =""

for i in range (num_tests):
    avalue = random.uniform(-100, 100)
    bvalue = random.uniform(-100, 100)
    fa = np.float16(avalue)
    fb = np.float16(bvalue)
    fp = fa * fb
    achar = bin(np.float16(avalue).view('H'))[2:].zfill(16)
    bchar = bin(np.float16(bvalue).view('H'))[2:].zfill(16)
    fpchar = bin(np.float16(fp).view('H'))[2:].zfill(16)
    print(fa, achar, fb, bchar, fp, fpchar)

    char += characters (achar, bchar, fpchar, i)


tb_template = f"""
    `timescale 1ns / 1ps

    module TB_PY_{dut_name};

        logic clk;
        logic rst_n;
        
        logic [15:0] a, b, result, task_result;
        
        fpu16_multiplier DUT(clk, rst_n, a, b, result);
        
        
        always #5 clk = ~clk;
    
        // Test sequence
        initial begin
            clk = 0;
            rst_n = 0;
            #10 rst_n = 1;
"""

tb_end = """
        $display ("ALL PASS");
        $stop;
    end ;

endmodule 

"""
    
tb_template = tb_template + char +tb_end;    
with open(f"TB_PY_{dut_name}.sv", "w") as f:
    f.write(tb_template)    