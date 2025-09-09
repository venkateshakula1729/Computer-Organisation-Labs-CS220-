`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:44 03/31/2024 
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
module top(clk, PB1, led);
input clk, PB1;
output wire [7:0] led;
reg [2:0] reg_file [0:7];

initial begin
	reg_file[0]=3'd3;
	reg_file[1]=3'd4;
	reg_file[2]=3'd7;
	reg_file[3]=3'd2;
	reg_file[4]=3'd3;
	reg_file[5]=3'd5;
	reg_file[6]=3'd0;
	reg_file[7]=3'd2;
end

reg [3:0] counter=0;
reg [7:0] Xor=0;
reg [7:0] parity=0;
reg [7:0] flag = 8'b11111111;
always @(posedge clk) begin
  	if(counter<8) begin
		  if (reg_file[counter] == 0) begin
				Xor = Xor ^ 8'b00000001;
		  end
		  else if (reg_file[counter] == 1) begin
				Xor = Xor ^ 8'b00000010;
		  end
		  else if (reg_file[counter] == 2) begin
				Xor = Xor ^ 8'b00000100;
		  end
		  else if (reg_file[counter] == 3) begin
				Xor = Xor ^ 8'b00001000;
		  end
		  else if (reg_file[counter] == 4) begin
				Xor = Xor ^ 8'b00010000;
		  end
		  else if (reg_file[counter] == 5) begin
				Xor = Xor ^ 8'b00100000;
		  end
		  else if (reg_file[counter] == 6) begin
				Xor = Xor ^ 8'b01000000;
		  end
		  else if (reg_file[counter] == 7) begin
				Xor = Xor ^ 8'b10000000;
		  end
		  counter=counter+1;
	end
	else if(counter == 8) begin
		parity[7:1] = 7'b0000000;
		parity[0] = Xor[0] ^ Xor[1] ^ Xor[2] ^ Xor[3] ^ Xor[4] ^ Xor[5] ^ Xor[6] ^ Xor[7];
		counter=9;
	end
end

assign led[7:0] = (Xor[7:0] & flag[7:0]) | (parity[7:0] & ~flag[7:0]);

always @(posedge PB1) begin
	flag[7:0] = ~flag[7:0];
end

endmodule
