`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:34:39 07/03/2018 
// Design Name: 
// Module Name:    Timer 
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
module Timer(clk, reset, parm_Value, enable, startTimer, expired);
	input clk, reset, startTimer, enable;
	input[3:0] parm_Value;
	output expired;
	
	reg expired;
	
	reg[3:0] time_parm;
	
	always @ (posedge clk)
	begin
		expired <= 0;
		
		if(reset)
			begin
				expired <= 0;
			end
		else if(startTimer)
			begin
				expired <= 0;
				if(parm_Value == 4'b0000)
					begin
						expired <= 1;
					end
				else
					begin
					time_parm <= parm_Value;
					end
			end
		else if (enable)
			begin
				expired <= (time_parm==4'b0010);

				time_parm <= time_parm - 1;
			end
	end

endmodule
