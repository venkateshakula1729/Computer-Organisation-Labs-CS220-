`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:43:12 01/27/2024
// Design Name:   BlinkingLED
// Module Name:   /users/btech/dhruv22/Desktop/CS220/Lab3_1/BlinkingLED/BlinkingLED_top.v
// Project Name:  BlinkingLED
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BlinkingLED
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// This text fixture assumes OFF_TIME = 5, ON_TIME = 10 in BlinkingLED.v
module BlinkingLED_top;

	// Inputs
	
	reg clk;

	// Outputs
	wire led0;

	// Instantiate the Unit Under Test (UUT)
	BlinkingLED uut (
		.clk(clk), 
		.led0(led0)
	);
	always @(led0) begin
		$display("time : %d, I am high", $time);
	end
	initial begin
	forever begin
		clk = 0;
		#2
		clk = 1;
		#2	
		clk = 0;
	end
	end
	initial begin
		#100
		$finish;
	end
      
endmodule

