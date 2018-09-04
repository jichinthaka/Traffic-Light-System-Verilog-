`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:10:05 07/05/2018
// Design Name:   FiniteStateMachine
// Module Name:   /home/imesh/Semester 7/HDL/0/Traffic_Light/TestFSM.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FiniteStateMachine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestFSM;

	// Inputs
	reg clk;
	reg reset;
	reg trafficSensor;
	reg pendingWalk;
	reg reprogram;
	reg expired;

	// Outputs
	wire startTimer;
	wire [1:0] timeParameter;
	wire resetWalk;
	wire [6:0] lightSignal;
	wire [2:0] state;

	// Instantiate the Unit Under Test (UUT)
	FiniteStateMachine uut (
		.clk(clk), 
		.reset(reset), 
		.trafficSensor(trafficSensor), 
		.pendingWalk(pendingWalk), 
		.reprogram(reprogram), 
		.expired(expired), 
		.startTimer(startTimer), 
		.timeParameter(timeParameter), 
		.resetWalk(resetWalk), 
		.lightSignal(lightSignal),
		.state(state)
	);

	initial begin
		forever #10 clk = ~clk;
	end
	
	initial begin
		forever begin
			#80 expired = 1;
			#20 expired = 0;
		end
	end

	initial begin
		// Initialize Inputs
		trafficSensor = 0;
		pendingWalk = 0;
		reprogram = 0;
		expired = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 0;
		
		#(19 * 2 * 10)
		
		#250 pendingWalk = 1;
		#170 pendingWalk = 0;
		
		#160 trafficSensor = 1;
		#100 trafficSensor = 0;
		
		#200 trafficSensor = 1;
		#100 trafficSensor = 0;
		
		#100 reprogram = 1;
		#100 reprogram = 0;
		
	end
      
endmodule

