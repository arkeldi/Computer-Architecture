`timescale 1ns / 1ps



`define STRLEN 32
module SignExtenderTest_v;

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [25:0] Imm;
	reg [1:0] Ctrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusImm;

	// Instantiate the Unit Under Test (UUT)
	SignExtender uut (
		.BusImm(BusImm), 
		.Imm(Imm), 
		.Ctrl(Ctrl)
	);

	initial begin
		// Initialize Inputs
		Imm = 0;
		Ctrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		//{Imm, Ctrl} = {25'h1234, 2'b0}; #40; passTest({BusImm}, 64'h0ABCD1234, "I: 0x0", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
		
		
		{Imm, Ctrl} = {26'h0, 2'b00}; #40; passTest({BusImm}, 64'h0, "I: 0x0", passed);
		{Imm, Ctrl} = {26'h3FFFFFF, 2'b00}; #40; passTest({BusImm}, 64'hFFF, "I: 0x3FFFFFF", passed);

		
		{Imm, Ctrl} = {26'h0, 2'b01}; #40; passTest({BusImm}, 64'h0, "D: 0x0", passed);
		{Imm, Ctrl} = {26'h3FFFFFF, 2'b01}; #40; passTest({BusImm}, 64'hFFFFFFFFFFFFFFFF, "D: 0x3FFFFFF", passed);
		
		
		{Imm, Ctrl} = {26'h0, 2'b10}; #40; passTest({BusImm}, 64'h0, "B: 0x0", passed);
		{Imm, Ctrl} = {26'h3FFFFFF, 2'b10}; #40; passTest({BusImm}, 64'hFFFFFFFFFFFFFFFC, "B: 0x3FFFFFF", passed);
		
		
		{Imm, Ctrl} = {26'h0, 2'b11}; #40; passTest({BusImm}, 64'h0, "CB: 0x0", passed);
		{Imm, Ctrl} = {26'h3FFFFFF, 2'b11}; #40; passTest({BusImm}, 64'hFFFFFFFFFFFFFFFC, "CB: 0x3FFFFFF", passed);
		
		

		allPassed(passed, 8);
	end
      
endmodule
