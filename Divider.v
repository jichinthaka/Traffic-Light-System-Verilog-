`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:17:17 07/03/2018 
// Design Name: 
// Module Name:    Divider 
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
module Divider(clk, reset, enable);
	input clk, reset/*, startTimer*/;
	output enable;
	
	reg enable;
	
	reg[24:0] clkCycleCount = 25'b0;
	
	// values used to determine when 1s is up
	//parameter CLK_COUNT_AFTER_ONE_SECOND = 25'd26_999_999 ;
	parameter CLK_COUNT_AFTER_ONE_SECOND = 25'd2;
	parameter CLK_COUNT_ZERO = 25'b0 ;
	
	always @ (posedge clk)
	begin
		enable = 0;
		
		if(clkCycleCount==CLK_COUNT_AFTER_ONE_SECOND ||
		   reset==1)
			clkCycleCount <= CLK_COUNT_ZERO;
		else
			clkCycleCount <= clkCycleCount + 1;
		
		/*if(startTimer)
			begin
				clkCycleCount <= CLK_COUNT_ZERO;
			end*/
		
		if ( clkCycleCount == CLK_COUNT_AFTER_ONE_SECOND )
			begin
				enable = 1;
				clkCycleCount <= CLK_COUNT_ZERO;
			end		
	end
endmodule
