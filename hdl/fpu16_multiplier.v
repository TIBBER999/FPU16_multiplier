`timescale 1ns / 1ps

module fpu16_multiplier (
    input wire        clk, 
    input wire        rst_n,
    input wire [15:0] a, // First operand
    input wire [15:0] b, // Second operand
    output reg [15:0] result // Result of multiplication
);

    wire sign_a, sign_b, sign_result;
    wire [4:0] exp_a, exp_b;
    wire [9:0] mant_a, mant_b;
    wire [21:0] mant_result;
    wire [5:0] exp_result;
	wire zero_a, zero_b, infinity_a, infinity_b, nan_a, nan_b;
	reg [4:0] flag;

    // Extract fields
    assign sign_a = a[15];
    assign sign_b = b[15];
    assign exp_a = a[14:10];
    assign exp_b = b[14:10];
    assign mant_a = a[9:0]; // Implicit leading 1
    assign mant_b = b[9:0]; // Implicit leading 1
	
	assign zero_a = (exp_a == 5'b0) && (mant_a == 10'b0);
	assign zero_b = (exp_b == 5'b0) && (mant_b == 10'b0);
	assign infinity_a = (exp_a == 5'b11111) && (mant_a == 10'b0);
	assign infinity_b = (exp_b == 5'b11111) && (mant_b == 10'b0);
	assign nan_a = (exp_a == 5'b11111) && (mant_a != 10'b0);
	assign nan_b = (exp_b == 5'b11111) && (mant_b != 10'b0);
	
    // Multiply mantissas
    assign mant_result = {1'b1, mant_a} * {1'b1, mant_b};

    // Add exponents and adjust for bias (2^4-1)
    assign exp_result = (exp_a + exp_b ) - 5'd15;

    // Determine the sign of the result
    assign sign_result = sign_a ^ sign_b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result <= 16'b0;
			flag <= 5'b0;
        end else begin
            if (zero_a || zero_b) begin 
                result <= 16'b0; // Result is zero
				flag <= 5'b0;
            end else if (infinity_a && !infinity_b) begin
				result[15] <= sign_result;
				result[14:10] <= 5'd31;
				result[9:0] <= 10'd0;
				flag <= 5'b1;
            end else if (!infinity_a && infinity_b) begin
				result[15] <= sign_result;
				result[14:10] <= 5'd31;
				result[9:0] <= 10'd0;
				flag <= 5'd2;
            end else if (nan_a || nan_b) begin // Result is NaN
				result[15] <= sign_result;
				result[14:10] <= 5'd31;
				result[9:0] <= 10'b10_0000_0000;
				flag <= 5'd3;
            end else if (exp_result >= 5'd31) begin //Overflow: result is infinity
				result[15] <= sign_result;
				result[14:10] <= 5'd31;
				result[9:0] <= 10'd0;
				flag <= 5'd4;
            end else if (exp_result <= 5'd0) begin // Underflow: result is zero
				result[15] <= sign_result;
				result[14:10] <= 5'd0;
				result[9:0] <= 10'd0;
				flag <= 5'd5;
            end else if (mant_result[21]) begin //normalization
				result[15] <= sign_result;
				result[14:10] <= exp_result+1'b1;
				result[9:0] <= mant_result[20:11];
				flag <= 5'd6;
            end else begin
				result[15] <= sign_result;
				result[14:10] <= exp_result;
				result[9:0] <= mant_result[19:10];
				flag <= 5'd7;
            end
        
        end
    end

endmodule
