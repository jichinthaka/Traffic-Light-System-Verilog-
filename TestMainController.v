`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:52:42 07/04/2018
// Design Name:   MainController
// Module Name:   D:/Semester 7/Hardware Discription Language/0/Traffic_Light/TestMainController.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MainController
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestMainController;

	// Inputs
	reg clk;
	reg reset;
	reg trafficSensor;
	reg walkRequest;
	reg reprogram;
	reg [1:0] timeSelector;
	reg [3:0] timeValue;

	// Outputs
	wire redMain;
	wire yellowMain;
	wire greenMain;
	wire redSide;
	wire yellowSide;
	wire greenSide;
	wire walkLight;
	//wire dividerEnable;
	//wire resetSync;
	//wire resetDebounce;
	//wire [2:0] state;
	//wire [3:0] out_Value_TimeParm;
	//wire [1:0] interval;
	//wire startTimer;

	// Instantiate the Unit Under Test (UUT)
	MainController uut (
		.clk(clk), 
		.reset(reset), 
		.trafficSensor(trafficSensor), 
		.walkRequest(walkRequest), 
		.reprogram(reprogram), 
		.timeSelector(timeSelector), 
		.timeValue(timeValue), 
		.redMain(redMain), 
		.yellowMain(yellowMain), 
		.greenMain(greenMain), 
		.redSide(redSide), 
		.yellowSide(yellowSide), 
		.greenSide(greenSide), 
		.walkLight(walkLight)/*,
		.dividerEnable(dividerEnable),
		.resetSync(resetSync),
		.resetDebounce(resetDebounce),
		.state(state),
		.out_Value_TimeParm(out_Value_TimeParm),
		.interval(interval),
		.startTimer(startTimer)*/
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 0;
		trafficSensor = 0;
		walkRequest = 0;
		reprogram = 0;
		timeSelector = 0;
		timeValue = 0;

		// Wait 100 ns for global reset to finish
		//#50;
        
		forever #10 clk = ~clk;

	end
	
	initial begin
		$display("....Starting test of MainController ...");
		#100;
		reset = 1;
		#20
		reset = 0;
		
		$display("....Starting to check regular operation with default values...");
		#(3270)
		$display("....Finish checking regular operation with default values...");
		
		#0 walkRequest = 1;
		#170 walkRequest = 0;
		
		#460 trafficSensor = 1;
		#100 trafficSensor = 0;
		
		#630 trafficSensor = 1;
		#100 trafficSensor = 0;
		
		#500;
		timeSelector = 2'b00;
		timeValue = 4'd3;
		
		#100 reprogram = 1;
		#20 reprogram = 0;
		
		#50;
		timeSelector = 2'b01;
		timeValue = 4'd2;
		
		#100 reprogram = 1;
		#20 reprogram = 0;
		
		#50;
		timeSelector = 2'b10;
		timeValue = 4'd3;
		
		#100 reprogram = 1;
		#20 reprogram = 0;
		
		/*#50;
		reset = 1;
		#20
		reset = 0;*/
		
	end
      
endmodule

