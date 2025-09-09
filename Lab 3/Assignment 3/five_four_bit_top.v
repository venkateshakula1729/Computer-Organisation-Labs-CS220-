`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:53:00 01/27/2024
// Design Name:   five_four_bit
// Module Name:   /users/btech/pragati/Desktop/CS220Labs/Lab3_3/five_four_bit/five_four_bit_top.v
// Project Name:  five_four_bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: five_four_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module five_four_bit_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg ROT_CENTER;
	reg [3:0] N;

	// Outputs
	wire [6:0] ans;

	// Instantiate the Unit Under Test (UUT)
	five_four_bit uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.ROT_CENTER(ROT_CENTER), 
		.N(N), 
		.ans(ans)
	);
	always @(ans) begin
		$display("time : %d, ans = %b", $time,ans);
	end

	initial begin
		// Initialize Inputs
		PB1 = 1; N = 4'b1111;
		#5
		PB2 = 1; N = 4'b1111;
		#5
		PB3 = 1; N = 4'b1111;
		#5
		PB4 = 1; N = 4'b1111;
		#5
		ROT_CENTER = 1; N = 4'b1111;
		// Wait 100 ns for global reset to finish
		#100;
		$finish;
        
		// Add stimulus here

	end
      
endmodule

