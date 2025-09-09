`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:18 01/27/2024 
// Design Name: 
// Module Name:    five_four_bit 
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
module five_four_bit(PB1,PB2,PB3,PB4,ROT_CENTER,N,ans);
input PB1,PB2,PB3,PB4,ROT_CENTER;
input [3:0] N;
output [6:0] ans;
reg [6:0] sum;
reg [3:0] X;
reg [3:0] Y;
reg [3:0] Z;
reg [3:0] W;
reg [3:0] V;

always @(posedge PB1) begin
	X[3:0] <=#2 N[3:0];
end
always @(posedge PB2) begin
	Y[3:0] <=#2 N[3:0];
end
always @(posedge PB3) begin
	Z[3:0] <=#2 N[3:0];
end
always @(posedge PB4) begin
	W[3:0] <=#2 N[3:0];
end
always @(posedge ROT_CENTER) begin
	V[3:0] <=#2 N[3:0];
end

wire [4:0] A;
wire [4:0] B;
wire [5:0] C;
wire [6:0] ans;
wire [5:0] temp;
assign temp[5] = 0;
assign temp[4] = 0;
assign temp[3:0] = V[3:0]; 
four_bit_adder FB0(X,Y,A);
four_bit_adder FB1(Z,W,B);
five_bit_adder FB2(A,B,C);
six_bit_adder FB3(C,temp,ans);

endmodule
