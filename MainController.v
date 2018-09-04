`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:28:59 07/04/2018 
// Design Name: 
// Module Name:    MainController 
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
module MainController(clk,
						 reset,
						 trafficSensor, walkRequest,
						 reprogram, timeSelector, timeValue,
						 redMain, yellowMain, greenMain,
						 redSide, yellowSide, greenSide,
						 walkLight/*, dividerEnable, resetSync, resetDebounce, state,
						 out_Value_TimeParm, interval,startTimer*/);
	input clk;
	input reset;

	input trafficSensor, walkRequest;
	input reprogram;
	input[1:0] timeSelector;
	input[3:0] timeValue;

	output redMain, yellowMain, greenMain;
	output redSide, yellowSide, greenSide;
	output walkLight;
	//output dividerEnable;
	//output resetSync;
	//output resetDebounce;
	//output [2:0] state;
	//output [3:0] out_Value_TimeParm;
	//output [1:0] interval;
	//output startTimer;

	wire resetSync, trafficSensorSync, walkRequestSync, reprogramSync;
	//wire resetDebounce, walkRequestDebounce, reprogramDebounce;

	wire WR_Reset, WR;
	wire startTimer, expired, dividerEnable;
	wire[3:0] out_Value_TimeParm;
	wire[1:0] interval;
	wire[6:0] lightSignal;
	
	
	// debounce and sync push - button signals
	/*
	Debouncer debounceReset(.clk(clk),
						.reset(0), .noisy(reset),
						.clean(resetDebounce));
	Debouncer debounceWalkRequest(.clk(clk),
							  .reset(0), .noisy(walkRequest),
							  .clean(walkRequestDebounce));
	Debouncer debounceReprogram(.clk(clk),
							.reset(0), .noisy(reprogram),
							.clean(reprogramDebounce));
	*/
	
	// sync external signals with clk
	Synchronizer syncReset(.clk(clk),
								   .in(reset),
								   .out(resetSync));
									
	Synchronizer syncTrafficSensor(.clk(clk),
								   .in(trafficSensor),
								   .out(trafficSensorSync));
									
	Synchronizer syncWalkRequest(.clk(clk),
								   .in(walkRequest),
								   .out(walkRequestSync));
	
	Synchronizer syncReprogram(.clk(clk),
								   .in(reprogram),
								   .out(reprogramSync));

	

	// walk register
	WalkRegister walkRegister(.clk(clk),
					.reset(resetSync),
					.WR_Sync(walkRequestSync),
					.WR_Reset(WR_Reset),
					.WR(WR));

	// FSM
	FiniteStateMachine fsm(.clk(clk),
									.reset(resetSync),
									.trafficSensor(trafficSensorSync),
									.pendingWalk(WR),
									.reprogram(reprogramSync),
									.expired(expired),
									.startTimer(startTimer),
									.timeParameter(interval),
									.resetWalk(WR_Reset),
									.lightSignal(lightSignal),
									.state(state));

	//traffic lights
	LEDs lights(.signal(lightSignal),
					.r_m(redMain),
					.y_m(yellowMain),
					.g_m(greenMain),
					.r_s(redSide),
					.y_s(yellowSide),
					.g_s(greenSide),
					.walk(walkLight));

	// time parameter storage
	TimeParameters timeParameter(.clk(clk),
						.reset(resetSync),
						.selector(timeSelector),
						.in_Value(timeValue),
						.sync_Reprogram(reprogramSync),
						.interval(interval),
						.out_Value(out_Value_TimeParm));
	
	//divider
	Divider divider(.clk(clk),
						.reset(resetSync),
						//.startTimer(startTimer),
						.enable(dividerEnable));

	// timer
	Timer timer(.clk(clk),
				.reset(resetSync),
				.parm_Value(out_Value_TimeParm),
				.enable(dividerEnable),
				.startTimer(startTimer),
				.expired(expired));

endmodule
