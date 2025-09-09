`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:23 01/27/2024 
// Design Name: 
// Module Name:    four_bit_adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module four_bit_adder(A,B,sum);
input [3:0] A;
input [3:0] B;
output [4:0] sum;
wire [4:0] sum;
wire [2:0] carry;
full_adder FA0(A[0],B[0],1'b0,sum[0],carry[0]);
full_adder FA1(A[1],B[1],carry[0],sum[1],carry[1]);
full_adder FA2(A[2],B[2],carry[1],sum[2],carry[2]);
full_adder FA3(A[3],B[3],carry[2],sum[3],sum[4]);

endmodule
