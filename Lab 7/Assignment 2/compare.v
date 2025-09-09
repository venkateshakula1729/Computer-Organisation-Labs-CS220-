`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:25:28 03/03/2024 
// Design Name: 
// Module Name:    compare 
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
module compare(A,B,C,D,z);
input [2:0]A;
input [2:0]B;
input [2:0]C;
input [2:0]D;
output reg [2:0]z;
always @(A,B,C,D) begin
	if(A<B) begin
		if(A<C)begin
			if(A<D) begin
				z<=A;
			end
			else begin
				z<=D;
			end
		end
		else begin
			if(C<D) begin
				z<=C;
			end
			else begin
				z<=D;
			end
		end
	end
	else begin
		if(B<C)begin
			if(B<D) begin
				z<=B;
			end
			else begin
				z<=D;
			end
		end
		else begin
			if(C<D) begin
				z<=C;
			end
			else begin
				z<=D;
			end
		end
	end
end
endmodule
