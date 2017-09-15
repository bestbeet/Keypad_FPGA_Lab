`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:23:23 11/01/2016 
// Design Name: 
// Module Name:    ch1 
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
module keypad(clk,column,row,display,common);
	input clk;
	input[2:0] column;
	output[3:0] row;
	output[6:0] display;
	output common;
	parameter s1 = 2'b00;
	parameter s2 = 2'b01;
	parameter s3 = 2'b10;
	parameter s4 = 2'b11;
	reg[3:0] row;
	reg[6:0] display;
	reg com;
	reg[1:0] state = s1;
	reg [31:0] cnt;
assign common = 0;
reg sclk;
always@(posedge sclk)
	case (state)
		s1 : begin 
			row <= 4'b0010;
			case (column)
				3'b001 : display <= 7'b0110000 ; //show 1 011 000 0 
				3'b010 : display <= 7'b1101101 ; //show 2 110 110 1
				3'b100 : display <= 7'b1111001 ;	//show 3 111 100 1
			endcase
			state <= s2;
			
		end
		s2 : begin
			row <= 4'b0100 ;
			case (column)
				3'b001 : display <= 7'b0110011 ; //show 4 011 001 1
				3'b010 : display <= 7'b1011011 ; //show 5 101 101 1
				3'b100 : display <= 7'b1011111 ; //show 6 101 111 1
				endcase
				state <= s3;
				
		end
		s3 : begin 
			row <= 4'b1000;
			case (column)
				3'b001 : display <= 7'b1001111 ; //show 7 100 111 1
				3'b010 : display <= 7'b1111110 ; //show 8 111 111 0
				3'b100 : display <= 7'b1000111 ; //show 9 100 011 1
			endcase
			state <= s4;
			
		end
		s4 : begin
			row <= 4'b0001 ;
			case (column)
				3'b001 : display <= 7'b1110000 ; //show E 111 000 0
				3'b010 : display <= 7'b1111111 ; //show 0 111 111 1
				3'b100 : display <= 7'b1111011 ; //show F 111 101 1
				
			endcase
			state <= s1;
			
		end
	endcase
	
	always@(posedge clk)
		//begin if (cnt == 50) begin sclk <= ~sclk; cnt <=0; end else cnt <= cnt + 1; end
		begin if (cnt == 25000000) begin sclk <= ~sclk; cnt <=0; end else cnt <= cnt + 1; end
	
endmodule
