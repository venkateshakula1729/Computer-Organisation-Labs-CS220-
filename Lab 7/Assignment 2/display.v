`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:25:17 03/03/2024 
// Design Name: 
// Module Name:    display 
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
module display(line1 , line2 , clk , LCD_RS , LCD_W , LCD_E , data);

input clk;
input [127:0] line1;
input [127:0] line2;
output LCD_E, LCD_W, LCD_RS;
output [3:0] data;
wire LCD_E, LCD_W, LCD_RS;
wire [3:0] data;

reg [31:0]counter;
reg [1:0] step;
reg flag;
reg e, w, rs;
reg [3:0] dr;
reg [1:0] idx;
reg [7:0] i,j,k,l;

wire[55:0] setup;
wire[7:0] brk;

initial begin
	e=0;
	w=0;
	rs=0;
	counter=500000000;
	idx=0;
	step=0;
	flag=1;
	i=55;
	j=127;
	k=7;
	l=127;
end

assign data[3:0] = dr[3:0];
assign LCD_E = e;
assign LCD_W = w;
assign LCD_RS = rs; 

assign setup=56'h333228060C0180;
assign brk=8'hC0;

always @(posedge clk) begin
	if(counter==0 && flag==1) begin
		counter = 1000000;
		if(step==2'b00) begin
			if(idx==2'b00) begin
				e=0;
				idx = idx+1;
			end
			else if(idx == 2'b01) begin
				dr[3] = setup[i];
				dr[2] = setup[i-1];
				dr[1] = setup[i-2];
				dr[0] = setup[i-3];
				idx=idx+1;	
			end
			else if(idx == 2'b10) begin
				if (i == 3) begin
					step = 2'b01;
					idx=0;
				end
				e=1;
				idx = 0;
				i = i-4;
			end
		end
		else if(step == 2'b01) begin
			if(idx==2'b00) begin
				e=0;
				idx = idx+1;
			end
			else if(idx == 2'b01) begin
				rs =1;
				w =0;
				dr[3] = line1[j];
				dr[2] = line1[j-1];
				dr[1] = line1[j-2];
				dr[0] = line1[j-3];
				idx=idx+1;
			end
			else if(idx == 2'b10) begin
				if (j==3) begin
					step = 2'b10;
					idx=0;
				end
				e=1;
				idx = 0;
				j = j-4;
			end
		end
		else if(step == 2'b10) begin 
			if(idx == 2'b00) begin
				e=0;
				idx = idx+1;
			end
			else if(idx == 2'b01) begin
				rs=0;
				w=0;
				dr[3] = brk[k];
				dr[2] = brk[k-1];
				dr[1] = brk[k-2];
				dr[0] = brk[k-3];
				idx=idx+1;
			end
			else if(idx == 2'b10) begin
				if (k==3) begin
					step = 2'b11;
					idx=0;
				end
				e=1;
				idx = 0;
				k = k-4;
			end
		end
		else if(step == 2'b11) begin
			if(idx==2'b00) begin
				e=0;
				idx = idx+1;
			end
			else if(idx == 2'b01) begin
				rs=1;
				w=0;
				dr[3] = line2[l];
				dr[2] = line2[l-1];
				dr[1] = line2[l-2];
				dr[0] = line2[l-3];
				idx=idx+1;	
			end
			else if(idx == 2'b10) begin
				if (l==3) begin
					flag=0;
				end
				e=1;
				idx = 0;
				l = l-4;
			end
		end	
	end
	else begin
		counter = counter - 1;
	end
end

endmodule