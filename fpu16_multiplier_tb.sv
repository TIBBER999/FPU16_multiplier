
    `timescale 1ns / 1ps

    module fpu16_multiplier_tb;

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

        a = 16'b1100111101000110;
        b = 16'b1101010010001101;  
        #10;
        if (result !== 16'b0110100000100011) begin 
            $display("Random0 wrong"); 
            $stop;
        end
        
        a = 16'b1100010100100100;
        b = 16'b0100110110010000;  
        #10;
        if (result !== 16'b1101011100100110) begin 
            $display("Random1 wrong"); 
            $stop;
        end
        
        a = 16'b0101010011001101;
        b = 16'b1101010100000001;  
        #10;
        if (result !== 16'b1110111000000001) begin 
            $display("Random2 wrong"); 
            $stop;
        end
        
        a = 16'b0101010111000110;
        b = 16'b0101010111101011;  
        #10;
        if (result !== 16'b0111000001000101) begin 
            $display("Random3 wrong"); 
            $stop;
        end
        
        a = 16'b0101011000101101;
        b = 16'b0101000001011000;  
        #10;
        if (result !== 16'b0110101010110101) begin 
            $display("Random4 wrong"); 
            $stop;
        end
        
        a = 16'b1101001011111100;
        b = 16'b0101001101001101;  
        #10;
        if (result !== 16'b1110101001100000) begin 
            $display("Random5 wrong"); 
            $stop;
        end
        
        a = 16'b0101010111000011;
        b = 16'b1100101011100111;  
        #10;
        if (result !== 16'b1110010011111001) begin 
            $display("Random6 wrong"); 
            $stop;
        end
        
        a = 16'b0101000000101001;
        b = 16'b1100110000001100;  
        #10;
        if (result !== 16'b1110000000110101) begin 
            $display("Random7 wrong"); 
            $stop;
        end
        
        a = 16'b1101000110101110;
        b = 16'b0100100101000111;  
        #10;
        if (result !== 16'b1101111101111110) begin 
            $display("Random8 wrong"); 
            $stop;
        end
        
        a = 16'b0101010100110001;
        b = 16'b0101000100100110;  
        #10;
        if (result !== 16'b0110101010101111) begin 
            $display("Random9 wrong"); 
            $stop;
        end
        
        $display ("ALL PASS");
        $stop;
    end ;

endmodule 

