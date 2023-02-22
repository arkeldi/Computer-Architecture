`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest_v;

   initial //This initial block used to dump all wire/reg values to dump file
     begin
       $dumpfile("ALUTest.vcd");
       $dumpvars(0,ALUTest_v);
     end


	task passTest;
		input [64:0] actualOut, expectedOut;
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
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
		
		
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'h0, 4'h0}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "AND 0x1234,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hFFFFFFFFFFFFFFFF, 4'h0}; #40; passTest({Zero, BusW}, 65'h1234, "AND 0x1234,0xFFFFFFFFFFFFFFFF", passed);
		{BusA, BusB, ALUCtrl} = {64'hE, 64'h7, 4'h0}; #40; passTest({Zero, BusW}, 65'h6, "AND 0xE,0x7", passed);
		{BusA, BusB, ALUCtrl} = {64'h0123456789ABCDEF, 64'h1111111111111111, 4'h0}; #40; passTest({Zero, BusW}, 65'h101010101010101, "AND 0x0123456789ABCDEF,0x1111111111111111", passed);	
		
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h1}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "OR 0x0,0x0", passed);	
		{BusA, BusB, ALUCtrl} = {64'hFFFFFFFFFFFFFFFF, 64'h0, 4'h1}; #40; passTest({Zero, BusW}, 65'hFFFFFFFFFFFFFFFF, "OR 0x0,0xFFFFFFFFFFFFFFFF", passed);	
		{BusA, BusB, ALUCtrl} = {64'h0123456789ABCDEF, 64'h1111111111111111, 4'h1}; #40; passTest({Zero, BusW}, 65'h1133557799BBDDFF, "OR 0x123456789ABCDEF,0x1111111111111111", passed);	
		
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h2}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "ADD 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h0, 64'hABCDEF0123456789, 4'h2}; #40; passTest({Zero, BusW}, 65'hABCDEF0123456789, "ADD 0x0,0xABCDEF0123456789", passed);		
		{BusA, BusB, ALUCtrl} = {64'hFFFF0000FFFF0000, 64'h0000111100001111, 4'h2}; #40; passTest({Zero, BusW}, 65'hFFFF1111FFFF1111, "ADD 0xFFFF0000FFFF0000,0x0000111100001111", passed);	
		
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h6}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "SUB 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'hABCD, 64'h1, 4'h6}; #40; passTest({Zero, BusW}, 65'hABCC, "SUB 0xABCD,0x1", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFFFFFFFFFFFFFF, 64'h0, 4'h6}; #40; passTest({Zero, BusW}, 65'hFFFFFFFFFFFFFFFF, "SUB 0xFFFFFFFFFFFFFFFF,0x0", passed);
		
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h7}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "PassB 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'hA, 64'hB, 4'h7}; #40; passTest({Zero, BusW}, 65'hB, "PassB 0xA,0xB", passed);
		{BusA, BusB, ALUCtrl} = {64'hABCDEF, 64'h1234567890, 4'h7}; #40; passTest({Zero, BusW}, 65'h1234567890, "PassB 0xABCDEF,0x1234567890", passed);
		

		allPassed(passed, 17);
	end
      
endmodule

