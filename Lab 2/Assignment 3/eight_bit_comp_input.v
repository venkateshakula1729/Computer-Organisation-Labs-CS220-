`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:21 01/21/2024 
// Design Name: 
// Module Name:    eight_bit_comp_input 
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
module eight_bit_comp_input(PB1, PB2, PB3, PB4, Y, l, e, g);
input PB1, PB2, PB3, PB4;
input [3:0]Y;
reg [7:0] A;
reg [7:0] B;
output [7:0] l;
output [7:0] g;
output [7:0] e;
wire [7:0] l;
wire [7:0] e;
wire [7:0] g;
always @(posedge PB1) begin
	A[3:0] <= Y[3:0];
end
always @(posedge PB2) begin
	A[7:4] <= Y[3:0];
end
always @(posedge PB3) begin
	B[3:0] <= Y[3:0];
end
always @(posedge PB4) begin
	B[7:4] <= Y[3:0];
end
one_bit_comp c0(.a(A[7]), .b(B[7]), .lin(1'b0), .ein(1'b1), .gin(1'b0), .lout(l[7]), .eout(e[7]), .gout(g[7])); 
one_bit_comp c1(.a(A[6]), .b(B[6]), .lin(l[7]), .ein(e[7]), .gin(g[7]), .lout(l[6]), .eout(e[6]), .gout(g[6]));
one_bit_comp c2(.a(A[5]), .b(B[5]), .lin(l[6]), .ein(e[6]), .gin(g[6]), .lout(l[5]), .eout(e[5]), .gout(g[5]));
one_bit_comp c3(.a(A[4]), .b(B[4]), .lin(l[5]), .ein(e[5]), .gin(g[5]), .lout(l[4]), .eout(e[4]), .gout(g[4])); 
one_bit_comp c4(.a(A[3]), .b(B[3]), .lin(l[4]), .ein(e[4]), .gin(g[4]), .lout(l[3]), .eout(e[3]), .gout(g[3])); 
one_bit_comp c5(.a(A[2]), .b(B[2]), .lin(l[3]), .ein(e[3]), .gin(g[3]), .lout(l[2]), .eout(e[2]), .gout(g[2]));
one_bit_comp c6(.a(A[1]), .b(B[1]), .lin(l[2]), .ein(e[2]), .gin(g[2]), .lout(l[1]), .eout(e[1]), .gout(g[1]));
one_bit_comp c7(.a(A[0]), .b(B[0]), .lin(l[1]), .ein(e[1]), .gin(g[1]), .lout(l[0]), .eout(e[0]), .gout(g[0]));



endmodule

