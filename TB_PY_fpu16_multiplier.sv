
    `timescale 1ns / 1ps

    module TB_PY_fpu16_multiplier;

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

        a = 16'b0101010100111111;
        b = 16'b1101001100000100;  
        #10;
        if (result !== 16'b1110110010011010) begin 
            $display("Random0 wrong"); 
            $stop;
        end
        
        a = 16'b0100100110111010;
        b = 16'b0011110011001011;  
        #10;
        if (result !== 16'b0100101011011101) begin 
            $display("Random1 wrong"); 
            $stop;
        end
        
        a = 16'b1101011000110101;
        b = 16'b0101010111101111;  
        #10;
        if (result !== 16'b1111000010011011) begin 
            $display("Random2 wrong"); 
            $stop;
        end
        
        a = 16'b0101001010011010;
        b = 16'b0101010110010001;  
        #10;
        if (result !== 16'b0110110010011000) begin 
            $display("Random3 wrong"); 
            $stop;
        end
        
        a = 16'b0100101110011100;
        b = 16'b1100101011001011;  
        #10;
        if (result !== 16'b1101101001110110) begin 
            $display("Random4 wrong"); 
            $stop;
        end
        
        a = 16'b0101000110100100;
        b = 16'b0101010010010110;  
        #10;
        if (result !== 16'b0110101001111000) begin 
            $display("Random5 wrong"); 
            $stop;
        end
        
        a = 16'b1101010010111111;
        b = 16'b1101001100010111;  
        #10;
        if (result !== 16'b0110110000110101) begin 
            $display("Random6 wrong"); 
            $stop;
        end
        
        a = 16'b1101010010110100;
        b = 16'b1101010111110011;  
        #10;
        if (result !== 16'b0110111011111111) begin 
            $display("Random7 wrong"); 
            $stop;
        end
        
        a = 16'b1101000000010111;
        b = 16'b1101000110101000;  
        #10;
        if (result !== 16'b0110010111001001) begin 
            $display("Random8 wrong"); 
            $stop;
        end
        
        a = 16'b1101000110111001;
        b = 16'b1101010001010000;  
        #10;
        if (result !== 16'b0110101000101011) begin 
            $display("Random9 wrong"); 
            $stop;
        end
        
        a = 16'b0101001110001100;
        b = 16'b1100110111100100;  
        #10;
        if (result !== 16'b1110010110001111) begin 
            $display("Random10 wrong"); 
            $stop;
        end
        
        a = 16'b0100110000001110;
        b = 16'b0101010011101000;  
        #10;
        if (result !== 16'b0110010011111001) begin 
            $display("Random11 wrong"); 
            $stop;
        end
        
        a = 16'b1101010001011100;
        b = 16'b0100111011110110;  
        #10;
        if (result !== 16'b1110011110010110) begin 
            $display("Random12 wrong"); 
            $stop;
        end
        
        a = 16'b1100101001010000;
        b = 16'b0101001111000100;  
        #10;
        if (result !== 16'b1110001000100001) begin 
            $display("Random13 wrong"); 
            $stop;
        end
        
        a = 16'b0101000110011100;
        b = 16'b0100111010110000;  
        #10;
        if (result !== 16'b0110010010110000) begin 
            $display("Random14 wrong"); 
            $stop;
        end
        
        a = 16'b0100000001010111;
        b = 16'b0101010001010110;  
        #10;
        if (result !== 16'b0101100010110100) begin 
            $display("Random15 wrong"); 
            $stop;
        end
        
        a = 16'b1101010111000010;
        b = 16'b1101000111110001;  
        #10;
        if (result !== 16'b0110110001000111) begin 
            $display("Random16 wrong"); 
            $stop;
        end
        
        a = 16'b0100001100100100;
        b = 16'b1101001010101101;  
        #10;
        if (result !== 16'b1101100111110101) begin 
            $display("Random17 wrong"); 
            $stop;
        end
        
        a = 16'b1101000011010110;
        b = 16'b1101010011110000;  
        #10;
        if (result !== 16'b0110100111111000) begin 
            $display("Random18 wrong"); 
            $stop;
        end
        
        a = 16'b0101001000101100;
        b = 16'b1101011000101100;  
        #10;
        if (result !== 16'b1110110011000011) begin 
            $display("Random19 wrong"); 
            $stop;
        end
        
        a = 16'b0101001101011111;
        b = 16'b1101001100101001;  
        #10;
        if (result !== 16'b1110101010011001) begin 
            $display("Random20 wrong"); 
            $stop;
        end
        
        a = 16'b0101010010010000;
        b = 16'b0101001001000010;  
        #10;
        if (result !== 16'b0110101100100011) begin 
            $display("Random21 wrong"); 
            $stop;
        end
        
        a = 16'b1101000110101000;
        b = 16'b1101011000001110;  
        #10;
        if (result !== 16'b0110110001001000) begin 
            $display("Random22 wrong"); 
            $stop;
        end
        
        a = 16'b0101010111000000;
        b = 16'b0101010010011000;  
        #10;
        if (result !== 16'b0110111010011010) begin 
            $display("Random23 wrong"); 
            $stop;
        end
        
        a = 16'b1101001111110001;
        b = 16'b1101001010011101;  
        #10;
        if (result !== 16'b0110101010010001) begin 
            $display("Random24 wrong"); 
            $stop;
        end
        
        a = 16'b0101010010111100;
        b = 16'b1101010010011100;  
        #10;
        if (result !== 16'b1110110101110101) begin 
            $display("Random25 wrong"); 
            $stop;
        end
        
        a = 16'b0101011000110000;
        b = 16'b1011111000111001;  
        #10;
        if (result !== 16'b1101100011010000) begin 
            $display("Random26 wrong"); 
            $stop;
        end
        
        a = 16'b1100010101000111;
        b = 16'b0100111100101110;  
        #10;
        if (result !== 16'b1101100010111100) begin 
            $display("Random27 wrong"); 
            $stop;
        end
        
        a = 16'b0101010011101001;
        b = 16'b0100010101101111;  
        #10;
        if (result !== 16'b0101111010101100) begin 
            $display("Random28 wrong"); 
            $stop;
        end
        
        a = 16'b0101000010101011;
        b = 16'b1100010000001000;  
        #10;
        if (result !== 16'b1101100010110100) begin 
            $display("Random29 wrong"); 
            $stop;
        end
        
        a = 16'b1100111000010010;
        b = 16'b0101010111111110;  
        #10;
        if (result !== 16'b1110100010001100) begin 
            $display("Random30 wrong"); 
            $stop;
        end
        
        a = 16'b1101010100110011;
        b = 16'b0100110110111011;  
        #10;
        if (result !== 16'b1110011101110011) begin 
            $display("Random31 wrong"); 
            $stop;
        end
        
        a = 16'b0101010111111100;
        b = 16'b0101001010111101;  
        #10;
        if (result !== 16'b0110110100001010) begin 
            $display("Random32 wrong"); 
            $stop;
        end
        
        a = 16'b1101010101101100;
        b = 16'b0101001001000000;  
        #10;
        if (result !== 16'b1110110000111100) begin 
            $display("Random33 wrong"); 
            $stop;
        end
        
        a = 16'b0100100101010011;
        b = 16'b1101001000100000;  
        #10;
        if (result !== 16'b1110000000010100) begin 
            $display("Random34 wrong"); 
            $stop;
        end
        
        a = 16'b1101001100110111;
        b = 16'b0101001110111001;  
        #10;
        if (result !== 16'b1110101011110111) begin 
            $display("Random35 wrong"); 
            $stop;
        end
        
        a = 16'b1101010100101001;
        b = 16'b0101001101111001;  
        #10;
        if (result !== 16'b1110110011010010) begin 
            $display("Random36 wrong"); 
            $stop;
        end
        
        a = 16'b1101000011001100;
        b = 16'b1101010101001111;  
        #10;
        if (result !== 16'b0110101001011110) begin 
            $display("Random37 wrong"); 
            $stop;
        end
        
        a = 16'b1101010101110000;
        b = 16'b1101011000000100;  
        #10;
        if (result !== 16'b0111000000010111) begin 
            $display("Random38 wrong"); 
            $stop;
        end
        
        a = 16'b0100001010111111;
        b = 16'b0101001100001101;  
        #10;
        if (result !== 16'b0101100111110010) begin 
            $display("Random39 wrong"); 
            $stop;
        end
        
        a = 16'b1101010011101110;
        b = 16'b1100110110100101;  
        #10;
        if (result !== 16'b0110011011110101) begin 
            $display("Random40 wrong"); 
            $stop;
        end
        
        a = 16'b0100100001101111;
        b = 16'b1100100100100010;  
        #10;
        if (result !== 16'b1101010110110000) begin 
            $display("Random41 wrong"); 
            $stop;
        end
        
        a = 16'b0101010101100011;
        b = 16'b0101010100010010;  
        #10;
        if (result !== 16'b0110111011010100) begin 
            $display("Random42 wrong"); 
            $stop;
        end
        
        a = 16'b0101010001010110;
        b = 16'b0100110101100001;  
        #10;
        if (result !== 16'b0110010111010101) begin 
            $display("Random43 wrong"); 
            $stop;
        end
        
        a = 16'b1100011111100001;
        b = 16'b1101010000101101;  
        #10;
        if (result !== 16'b0110000000011101) begin 
            $display("Random44 wrong"); 
            $stop;
        end
        
        a = 16'b1101001111110010;
        b = 16'b1101001001011000;  
        #10;
        if (result !== 16'b0110101001001101) begin 
            $display("Random45 wrong"); 
            $stop;
        end
        
        a = 16'b0101000011000010;
        b = 16'b0101010110001011;  
        #10;
        if (result !== 16'b0110101010011000) begin 
            $display("Random46 wrong"); 
            $stop;
        end
        
        a = 16'b1101001110000110;
        b = 16'b0101010011000110;  
        #10;
        if (result !== 16'b1110110001111101) begin 
            $display("Random47 wrong"); 
            $stop;
        end
        
        a = 16'b0101010001011110;
        b = 16'b1101001000111111;  
        #10;
        if (result !== 16'b1110101011010010) begin 
            $display("Random48 wrong"); 
            $stop;
        end
        
        a = 16'b1101011000001010;
        b = 16'b0101010001101011;  
        #10;
        if (result !== 16'b1110111010101100) begin 
            $display("Random49 wrong"); 
            $stop;
        end
        
        $display ("ALL PASS");
        $stop;
    end ;

endmodule 

