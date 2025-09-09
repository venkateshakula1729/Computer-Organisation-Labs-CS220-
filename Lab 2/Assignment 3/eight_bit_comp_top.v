`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:47:53 01/21/2024
// Design Name:   eight_bit_comp_input
// Module Name:   /users/btech/pragati/Desktop/CS220Labs/Lab2_3/eight_bit_comp/eight_bit_comp_top.v
// Project Name:  eight_bit_comp
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: eight_bit_comp_input
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module eight_bit_comp_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg [3:0] Y;

	// Outputs
	wire [7:0] l;
	wire [7:0] e;
	wire [7:0] g;

	// Instantiate the Unit Under Test (UUT)
	eight_bit_comp_input uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.Y(Y), 
		.l(l), 
		.e(e), 
		.g(g)
	);

always @(l or g or e) begin
	$display("time = %d: l=%b, e=%b. g=%b", $time, l,e,g);
end

initial begin
	PB1 = 1; Y = 4'b0110;
	#2
	PB2 = 1; Y = 4'b0110;
	#2
	PB3 = 1; Y = 4'b0110;
	#2
	PB4 = 1; Y = 4'b0110;
	#10
	$finish;
end 
      
endmodule

