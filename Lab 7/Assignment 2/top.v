`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:06 03/03/2024 
// Design Name: 
// Module Name:    top 
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
module top(clk,Y,PB1, PB2, PB3, PB4, LCD_E,LCD_RS, LCD_W, data);
input clk;
input PB1, PB2, PB3, PB4;
input [2:0]Y;

reg [2:0] A;
reg [2:0] B;
reg [2:0] C;
reg [2:0] D;

output wire LCD_E,LCD_RS, LCD_W;
output wire [3:0] data;

always @(posedge PB1) begin
	A[2:0] <= Y[2:0];
end
always @(posedge PB2) begin
	B[2:0] <= Y[2:0];
end
always @(posedge PB3) begin
	C[2:0] <= Y[2:0];
end
always @(posedge PB4) begin
	D[2:0] <= Y[2:0];
end
wire [2:0]z;
compare uut1(A,B,C,D,z);
reg [0:127]line1;
reg [0:127]line2;

reg [7:0]bits[0:7];
reg [15:0]separator;

initial begin
	bits[0]<=8'd48;
	bits[1]<=8'd49;
	bits[2]<=8'd50;
	bits[3]<=8'd51;
	bits[4]<=8'd52;
	bits[5]<=8'd53;
	bits[6]<=8'd54;
	bits[7]<=8'd55;
	separator[15:8]<=8'd44;
	separator[7:0]<=8'd32;
end

always @(posedge clk) begin
	line1<={bits[A], separator, bits[B], separator, bits[C], separator, bits[D], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
	if(z==A) begin
		line2<={bits[0],8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32,8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
	end
	else if(z==B) begin
		line2<={bits[1],8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32,8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
	end
	else if(z==C) begin
		line2<={bits[2],8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32,8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
	end
	else if(z==D) begin
		line2<={bits[3],8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32,8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
	end
end

display uut2(line1 , line2 , clk , LCD_RS , LCD_W , LCD_E , data);

endmodule
