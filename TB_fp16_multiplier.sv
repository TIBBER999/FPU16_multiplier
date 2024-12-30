`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2024 10:56:23 AM
// Design Name: 
// Module Name: TB_fp16_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB_fp16_multiplier(

    );
	string test = "";
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

        // Test cases
        // 1. Zero * Non-Zero 
        a = 16'b0000000000000000; // 0.0
        b = 16'b0100000000000000; // 1.0
        #20;
		if (result != 16'd0) begin 
            $display("Zero * Non-Zero"); 
			$stop;
        end
        
        // 2. Non-Zero * Zero
        a = 16'b0100000000000000; // 1.0
        b = 16'b1000000000000000; // 0.0
        #20;
		if (result != 16'b0000000000000000) begin 
            $display("Non-Zero * Zero"); 
			$stop;
        end
        
        // 3. Non-Zero * Non-Zero (positive)
        a = 16'b0011111000000000; // 1.5
        b = 16'b0011111000000000; // 1.5
        #20;
		if (result != 16'b0100000010000000) begin 
            $display("Non-Zero * Non-Zero (positive)"); 
			$stop;
        end
        
        // 4. Non-Zero * Non-Zero (negative)
        a = 16'b1011111000000000; // -1.5
        b = 16'b0011111000000000; // 1.5 
        #20;
		if (result != 16'b1100000010000000) begin 
            $display("Non-Zero * Non-Zero (neg)"); 
			$stop;
        end
        
        // 5. Infinity * Non-Zero
        a = 16'b1111111000000000; // Infinity
        b = 16'b0011111000000000; // 1.5
        #20;
		if (result != 16'b1111111000000000) begin 
            $display("Infinity * Non-Zero (neg NaN)"); 
			$stop;
        end
        
        // 6. Non-Zero * Infinity
        a = 16'b0011111000000000; // 1.5
        b = 16'b0111111000000000; // Infinity
        #20;
		if (result != 16'b0111111000000000) begin 
            $display("Non-Zero * Infinity (pos NaN)"); 
			$stop;
        end
        
        // 7. NaN * Non-Zero
        a = 16'b1111111000000001; // NaN
        b = 16'b0011111000000000; // 1.5
        #20;
		if (result[15:10] != 6'b111111) begin 
            $display("NaN * Non-Zero"); 
			$stop;
        end
        
        // 8. Non-Zero * NaN
        a = 16'b0011111000000000; // 1.5
        b = 16'b1111111000000001; // NaN
        #20;
		if (result[15:10] != 6'b111111) begin 
            $display("Non-Zero * NaN"); 
			$stop;
        end
        
        // 9. Overflow 
        a = 16'b0111100000000000; // 64.0
        b = 16'b0111100000000000; // 64.0
        #20;
		if (result != 16'b0111110000000000) begin 
            $display("Overflow"); 
			$stop;
        end
        
        // 10. Underflow
        a = 16'b0000000000000000; // 2^-14
        b = 16'b0000000000000000; // 2^-14
        #20;
		if (result != 16'b0000000000000000) begin 
            $display("Underflow"); 
			$stop;
        end
		
		// 11. Infinity * Non-Zero
        a = 16'b1111110000000000; // Infinity
        b = 16'b0011111000000000; // 1.5
        #20;
		if (result != 16'b1111110000000000) begin 
            $display("Infinity * Non-Zero (neg infinity)"); 
			$stop;
        end
        
        // 12. Non-Zero * Infinity
        a = 16'b0011111000000000; // 1.5
        b = 16'b0111110000000000; // Infinity
        #20;
		if (result != 16'b0111110000000000) begin 
            $display("Non-Zero * Infinity (pos infinity)"); 
			$stop;
        end
		$stop;
	end ;

endmodule 
	/*
	initial begin
	clk = 1; #5 clk = 0;
	forever
		begin 
	
		#5 clk = 1; #5 clk = 0 ;
		end
	end 
	
	initial begin 
		rst_n = 1'b0;
		input_a = {1'b1, 5'b11111, 10'b0};
		input_b = {1'b1, 5'b01111, 10'b0};
		fpu16_result(input_a, input_b, task_result);
		# 20 
		rst_n = 1'b1;
		//pos infinity  
		test = "pos infinity";
		input_a = {1'b1, 5'b11111, 10'b0};
		input_b = {1'b1, 5'b01111, 10'b0};
		fpu16_result(input_a, input_b, task_result);
        #10
        if (result != task_result) begin 
            $display("pos infinity wrong"); 
			$stop;
        end 
        //neg infinity 
		test = "neg infinity";
        input_a = {1'b1, 5'b01111, 10'b0};
		input_b = {1'b0, 5'b11111, 10'b0};
		fpu16_result(input_a, input_b, task_result);
        #10
        if (result != task_result) begin 
            $display("neg infinity wrong"); 
			$stop;
        end 
        //pos zero
		test = "pos zero";
        input_a = {1'b1, 5'b00000, 10'b0};
		input_b = {1'b1, 5'b01111, 10'b0};
		fpu16_result(input_a, input_b, task_result);
        #10
        if (result != task_result) begin 
            $display("pos zero wrong"); 
			$stop;
        end 
        //neg zero
		test = "neg zero";
        input_a = {1'b0, 5'b00001, 10'b0};
		input_b = {1'b1, 5'b00000, 10'b0};
		fpu16_result(input_a, input_b, task_result);
        #10
        if (result != task_result) begin 
            $display("neg zero wrong"); 
			$stop;
        end 
		//pos NaN
		test = "pos Nan";
        input_a = {1'b1, 5'b11111, 10'b101};
		input_b = {1'b1, 5'b01111, 10'b0};
		fpu16_result(input_a, input_b, task_result);
        #10
        if (result != task_result) begin 
            $display("pos NaN wrong"); 
			$stop;
        end 
        //neg Nan
		test = "neg Nan";
        input_a = {1'b0, 5'b00000, 10'b0};
		input_b = {1'b1, 5'b11111, 10'b101};
		fpu16_result(input_a, input_b, task_result);
        #10
        if (result != task_result) begin 
            $display("neg NaN wrong"); 
			$stop;
        end 
        //random value multiplications 
        repeat (10)
        begin 
            input_a = {$random}%65535;
            input_b = {$random}%65535;
            fpu16_result(input_a, input_b, task_result);
            #10
            if (result != task_result) begin 
                $display("Random  wrong"); 
			    $stop;
            end 
        end 

	end 
	
	task fpu16_result(input [15:0] input_a, input [15:0] input_b, output [15:0] result);
		
		reg sign_a, sign_b, sign_result;
		reg [4:0] exp_a, exp_b;
		reg [9:0] mant_a, mant_b;
		reg [19:0] mant_result;
		reg [5:0] exp_result;
		reg [3:0] inc;
		reg zero_a, zero_b, infinity_a, infinity_b, nan_a, nan_b;
	
		// Extract fields
		assign sign_a = input_a[15];
		assign sign_b = input_b[15];
		assign exp_a = input_a[14:10];
		assign exp_b = input_b[14:10];
		assign mant_a = {1'b1, input_a[9:0]}; // Implicit leading 1
		assign mant_b = {1'b1, input_b[9:0]}; // Implicit leading 1
		
		assign zero_a = ((exp_a == 5'd0) && (mant_a == 10'd0));
		assign zero_b = ((exp_b == 5'b0) && (mant_b == 10'b0));
		assign infinity_a = ((exp_a == 5'b11111) && (mant_a == 10'b0));
		assign infinity_b = ((exp_b == 5'b11111) && (mant_b == 10'b0));
		assign nan_a = ((exp_a == 5'b11111) && (mant_a != 10'b0));
		assign nan_b = ((exp_b == 5'b11111) && (mant_b != 10'b0));
		
		// Multiply mantissas
		assign mant_result = mant_a * mant_b;
	
		// Add exponents and adjust for bias
		assign exp_result = (exp_a + exp_b ) - 5'd15;
	
		// Determine the sign of the result
		assign sign_result = sign_a ^ sign_b;

		// if either number is zero, the result is zero
		if (zero_a || zero_b) begin 
            result <= 16'b0; // Result is zero
        end else if (infinity_a && !infinity_b) begin
            result <= {sign_result, 5'd31, 10'd0}; // Result is infinity
        end else if (!infinity_a && infinity_b) begin
            result <= {sign_result, 5'd31, 10'd0}; // Result is infinity
        end else if (nan_a || nan_b) begin
            result <= {1'b0, 5'd31, 10'b1}; // Result is NaN
        end else if (exp_result >= 5'd31) begin
            result <= {sign_result, 5'd31, 10'd0}; // Overflow: result is infinity
        end else if (exp_result <= 5'd0) begin
            result <= {sign_result, 5'd0, 10'd0}; // Underflow: result is zero
        end else if (mant_result[19]) begin
            result <= {sign_result, exp_result + 1, mant_result[18:9]}; // Shift right by 1 bit and increment exponent
        end else begin
            result <= {sign_result, exp_result, mant_result[17:8]};
        end
				
		//// Handle special cases (simplified)
		//if (exp_result >= 5'd31 && ((mant_a == 10'b0) ||(mant_b == 10'b0))) begin
		//	result <= {sign_result, 5'd31, 10'd0}; // Overflow: result is infinity
		//	inc = 1'b1;
		//end else if (exp_result <= 5'd0) begin
		//	result <= {sign_result, 5'd0, 10'd0}; // Underflow: result is zero
		//	inc = 4'd2;
		//end else if (exp_result >= 5'd31 && ((mant_a != 10'b0) ||(mant_b != 10'b0))) begin 
		//	result <= {sign_result, 5'd31, 10'b1};
		//	inc = 4'd3;
		//end else if (mant_result[19]) begin
		//	result <= {sign_result, exp_result + 1, mant_result[18:9]}; // Shift right by 1 bit and increment exponent
		//	inc = 4'd4;
		//end else begin
		//	inc = 4'd5;
		//	result <= {sign_result, exp_result, mant_result[17:8]};
		//end 
	endtask
	
endmodule
*/