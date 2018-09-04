`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:47:44 07/03/2018 
// Design Name: 
// Module Name:    TimeParameters 
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
module TimeParameters(clk, reset, selector, in_Value, sync_Reprogram,
						    interval, out_Value);
	input clk, sync_Reprogram, reset;
	input[1:0] selector;
	input[1:0] interval;
	input[3:0] in_Value;
	output[3:0] out_Value;

	reg[3:0] out_Value;

	// addresses for the different inputs
	parameter BASE_PARAMETER 	= 2'b00;
	parameter EXT_PARAMETER 	= 2'b01;
	parameter YEL_PARAMETER 	= 2'b10;

	// default time values
	parameter DEFAULT_BASE 	= 4'b0110;
	parameter DEFAULT_EXT 	= 4'b0011;
	parameter DEFAULT_YEL 	= 4'b0010;
	
	reg[3:0] BASE_VALUE = 4'b0110;
	reg[3:0] EXT_VALUE = 4'b0011;
	reg[3:0] YEL_VALUE = 4'b0010;

	always @ (posedge clk)
	begin
		if(reset)
			begin
				BASE_VALUE <= DEFAULT_BASE;
				EXT_VALUE <= DEFAULT_EXT;
				YEL_VALUE <= DEFAULT_YEL;
			end
		else if(sync_Reprogram)
			begin
				case(selector)
					BASE_PARAMETER: BASE_VALUE <= (in_Value !== 4'b0000) ? in_Value : DEFAULT_BASE;
					EXT_PARAMETER: EXT_VALUE <= (in_Value !== 4'b0000) ? in_Value : DEFAULT_EXT;
					YEL_PARAMETER: YEL_VALUE <= (in_Value !== 4'b0000) ? in_Value : DEFAULT_YEL;
					
					default:
						begin
							BASE_VALUE <= DEFAULT_BASE;
							EXT_VALUE <= DEFAULT_EXT;
							YEL_VALUE <= DEFAULT_YEL;
						end
				endcase
			end	
			
		case(interval)
			BASE_PARAMETER: out_Value <= BASE_VALUE;
			EXT_PARAMETER: out_Value <= EXT_VALUE;
			YEL_PARAMETER: out_Value <= YEL_VALUE;
			
			//default:
			//	out_Value <= 4'b1111;
		endcase	
	end


endmodule
