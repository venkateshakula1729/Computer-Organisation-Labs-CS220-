`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:37:53 01/21/2024 
// Design Name: 
// Module Name:    seven_bit_adder 
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
module seven_bit_adder(PB1,PB2,PB3,PB4,Y,z,carry);
input PB1;
input PB2;
input PB3;
input PB4;
input [3:0]Y;
reg [6:0] A;
reg [6:0] B;
output [7:0]z;
wire [7:0]z;
output[5:0] carry;
wire [5:0] carry;
always @(posedge PB1) begin
	A[3:0] <= Y[3:0];
end
always @(posedge PB2) begin
	A[6:4] <= Y[2:0];
end
always @(posedge PB3) begin
	B[3:0] <= Y[3:0];
end
always @(posedge PB4) begin
	B[6:4] <= Y[2:0];
end
full_adder FA0 (A[0],B[0],1'b0,z[0],carry[0]);
full_adder FA1 (A[1],B[1],carry[0],z[1],carry[1]);
full_adder FA2 (A[2],B[2],carry[1],z[2],carry[2]);
full_adder FA3 (A[3],B[3],carry[2],z[3],carry[3]);
full_adder FA4 (A[4],B[4],carry[3],z[4],carry[4]);
full_adder FA5 (A[5],B[5],carry[4],z[5],carry[5]);
full_adder FA6 (A[6],B[6],carry[5],z[6],z[7]);
endmodule
