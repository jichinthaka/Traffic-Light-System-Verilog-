`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:42 07/03/2018 
// Design Name: 
// Module Name:    FiniteStateMachine 
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
module FiniteStateMachine(clk ,reset , trafficSensor , pendingWalk ,reprogram , expired ,startTimer , timeParameter , resetWalk , lightSignal, state);
	 input clk ;
	input reset , trafficSensor , pendingWalk , reprogram , expired ;

	output startTimer ;
	output [1:0] timeParameter ;

	output resetWalk ;

	output [6:0] lightSignal;
	output [2:0] state;

	reg startTimer ;
	reg startTimer_trigered;
	reg [1:0] timeParameter;
	reg resetWalk ;
	reg [6:0] lightSignal;

	parameter ON = 1'b0 ;
	parameter OFF = 1'b1 ;
	

	parameter START_MAIN_GREEN = 0;
	parameter CONT_MAIN_GREEN_NO_TRAFFIC = 1;
	parameter CONT_MAIN_GREEN_TRAFFIC = 2;
	parameter MAIN_YELLOW = 3;
	parameter PEDESTRIAN_WALK = 4;
	parameter START_SIDE_GREEN = 5;
	parameter CONT_SIDE_GREEN_TRAFFIC = 6;
	parameter SIDE_YELLOW = 7;
	
	reg [2:0] state;

	parameter RED_MAIN 		= 7'b0000001;
	parameter YELLOW_MAIN 	= 7'b0000010;
	parameter GREEN_MAIN 	= 7'b0000100;
	parameter RED_SIDE 		= 7'b0001000;
	parameter YELLOW_SIDE 	= 7'b0010000;
	parameter GREEN_SIDE 	= 7'b0100000;
	parameter WALK 			= 7'b1000000;

	parameter BASE_SELECT = 2'b00 ;
	parameter EXT_SELECT = 2'b01 ;
	parameter YEL_SELECT = 2'b10 ;

	always @ ( posedge clk )
	begin
		startTimer <= 0;
		resetWalk <= 0;
		
		if(startTimer_trigered)
			begin
				startTimer <= 1;
				startTimer_trigered <= 0;
			end

		if ( reset || reprogram )
			begin
			startTimer_trigered <= 1;
			timeParameter <= BASE_SELECT ;
			state <= START_MAIN_GREEN ;
			end
		else if (~ expired )
			begin
			case ( state )
				START_MAIN_GREEN, CONT_MAIN_GREEN_NO_TRAFFIC, CONT_MAIN_GREEN_TRAFFIC :
					lightSignal <= GREEN_MAIN | RED_SIDE;

				MAIN_YELLOW :
					lightSignal <= YELLOW_MAIN | RED_SIDE;

				PEDESTRIAN_WALK :
					lightSignal <= RED_MAIN | RED_SIDE | WALK;

				START_SIDE_GREEN, CONT_SIDE_GREEN_TRAFFIC :
					lightSignal <= RED_MAIN | GREEN_SIDE;

				SIDE_YELLOW :
					lightSignal <= RED_MAIN | YELLOW_SIDE;

				default :
					lightSignal <= 7'b0000000;
			endcase
		end
		else if (expired)
			begin
			startTimer_trigered <= 1;

			case ( state )
				START_MAIN_GREEN :
					begin
						if ( trafficSensor )
							begin
								timeParameter <= EXT_SELECT ;
								state <= CONT_MAIN_GREEN_TRAFFIC ;
							end
						else
							begin
								timeParameter <= BASE_SELECT ;
								state <= CONT_MAIN_GREEN_NO_TRAFFIC ;
							end
					end

				CONT_MAIN_GREEN_NO_TRAFFIC,CONT_MAIN_GREEN_TRAFFIC :
					begin
						timeParameter <= YEL_SELECT ;
						state <= MAIN_YELLOW ;
					end

				MAIN_YELLOW :
					begin
						if ( pendingWalk )
							begin
								timeParameter <= EXT_SELECT ;
								state <= PEDESTRIAN_WALK ;
							end
						else
							begin
								timeParameter <= BASE_SELECT ;
								state <= START_SIDE_GREEN ;
							end
					end

				PEDESTRIAN_WALK :
					begin
						timeParameter <= BASE_SELECT ;
						state <= START_SIDE_GREEN ;

						resetWalk <= 1;
					end

				START_SIDE_GREEN :
					begin
						if ( trafficSensor )
							begin
								timeParameter <= EXT_SELECT ;
								state <= CONT_SIDE_GREEN_TRAFFIC ;
							end
						else
							begin
								timeParameter <= YEL_SELECT ;
								state <= SIDE_YELLOW ;

							end
					end

				CONT_SIDE_GREEN_TRAFFIC :
					begin
						timeParameter <= YEL_SELECT ;
						state <= SIDE_YELLOW ;
					end

				SIDE_YELLOW :
					begin
						timeParameter <= BASE_SELECT ;
						state <= START_MAIN_GREEN ;
					end

				default :
					begin
						state <= 8 ; // to debug the starting delay
					end
			endcase
		end
	end
endmodule
