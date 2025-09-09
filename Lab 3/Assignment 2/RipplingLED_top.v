`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:52:08 01/27/2024
// Design Name:   RipplinLED
// Module Name:   /users/btech/dhruv22/Desktop/CS220/Lab3_2/RipplingLED/RipplingLED_top.v
// Project Name:  RipplingLED
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RipplinLED
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// This text fixture assumes SHIFT_TIME = 5 in RipplingLED.v
module RipplingLED_top;

	// Inputs
	reg clk;

	// Outputs
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	RipplinLED uut (
		.clk(clk), 
		.led(led)
	);
	always @(led) begin
		$display("time : %d, led = %b", $time, led);
	end
	initial begin
		forever begin
		clk=0;
		#2
		clk=1;
		#2
		clk=0;
		end
	end
	
 	initial begin
		#100
		$finish;
	end
      
endmodule

