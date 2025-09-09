`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:51 02/24/2024 
// Design Name: 
// Module Name:    input 
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
module seven_bit_adder(y,clk,rot_event,rot_dir,z,ovf);
reg [6:0]a;
reg [6:0]b;
reg cin;
wire sign;
input [3:0]y;
input clk, rot_event, rot_dir;
output wire [6:0]z;
output wire ovf;
wire cout;
reg prev_rot_event;
initial prev_rot_event = 1;
reg [3:0]count;
initial count=0;

reg s;
always @(posedge clk) begin
	prev_rot_event<=rot_event;
	if(prev_rot_event==0 && rot_event==1) begin 
		if(rot_dir==1) begin
			if(count==0) begin
				a[3:0]<=y[3:0];
				count=count+1;
			end
			else if(count==1) begin
				a[6:4]<=y[2:0];
				count=count+1;
			end
			else if(count==2) begin
				b[3:0]<=y[3:0];
				count=count+1;
			end
			else if(count==3) begin
				b[6:4]<=y[2:0];
				count=count+1;
			end
			else if(count==4) begin
				s<=y[0];
				count=count+1;
			end
		end
	end
end
wire [6:0]x;
assign sign = s;
assign x[6]=b[6]^sign;
assign x[5]=b[5]^sign;
assign x[4]=b[4]^sign;
assign x[3]=b[3]^sign;
assign x[2]=b[2]^sign;
assign x[1]=b[1]^sign;
assign x[0]=b[0]^sign;
wire[5:0] carry;

full_add_sub FA0 (a[0],x[0],sign,z[0],carry[0]);
full_add_sub FA1 (a[1],x[1],carry[0],z[1],carry[1]);
full_add_sub FA2 (a[2],x[2],carry[1],z[2],carry[2]);
full_add_sub FA3 (a[3],x[3],carry[2],z[3],carry[3]);
full_add_sub FA4 (a[4],x[4],carry[3],z[4],carry[4]);
full_add_sub FA5 (a[5],x[5],carry[4],z[5],carry[5]);
full_add_sub FA6 (a[6],x[6],carry[5],z[6],cout);

assign ovf=cout^carry[5];
endmodule
