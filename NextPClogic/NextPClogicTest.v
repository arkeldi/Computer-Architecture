`define STRLEN 32
module NextPClogicTest_v;
   
   
   initial //This initial block used to dump all wire/reg values to dump file
     begin
       $dumpfile("NextPClogicTest.vcd");
       $dumpvars(0,NextPClogicTest_v);
     end

   task passTest;
      input [63:0] actualOut, expectedOut;
      input [`STRLEN*8:0] testType;
      inout [7:0] 	  passed;
      
      if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
      else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
   endtask
   
   task allPassed;
      input [7:0] passed;
      input [7:0] numTests;
      
      if(passed == numTests) $display ("All tests passed");
      else $display("Some tests failed");
   endtask

   // Inputs
   reg [63:0] 	  CurrentPC;
   reg [63:0] 	  SignExtImm64;
   reg            Branch;
   reg            ALUZero;
   reg            Uncondbranch;
   reg [7:0] 	  passed;

   // Outputs
   wire [63:0] 	  NextPC;


   // Instantiate the Unit Under Test (UUT)
   NextPClogic uut (
		     .NextPC(NextPC), 
		     .CurrentPC(CurrentPC), 
		     .SignExtImm64(SignExtImm64), 
		     .Branch(Branch), 
		     .ALUZero(ALUZero), 
		     .Uncondbranch(Uncondbranch)
		     );

   initial begin
      // Initialize Inputs
      CurrentPC = 0;
	  SignExtImm64 = 0;
      Branch = 0;
      ALUZero = 0;
      Uncondbranch = 0;
      passed = 0;
      
      #10;

      // Test cases for all control inputs
      {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b0,1'b0,1'b0}; #40; passTest(NextPC, 64'h8, "", passed);
	  {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b0,1'b0,1'b1}; #40; passTest(NextPC, 64'hc, "", passed);
	  {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b0,1'b1,1'b0}; #40; passTest(NextPC, 64'h8, "", passed);
	  {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b0,1'b1,1'b1}; #40; passTest(NextPC, 64'hc, "", passed);
	  {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b1,1'b0,1'b0}; #40; passTest(NextPC, 64'h8, "", passed);
	  {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b1,1'b0,1'b1}; #40; passTest(NextPC, 64'hc, "", passed);
	  {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b1,1'b1,1'b0}; #40; passTest(NextPC, 64'hc, "", passed);
	  {CurrentPC,SignExtImm64,Branch,ALUZero,Uncondbranch} = {64'h4,64'h8, 1'b1,1'b1,1'b1}; #40; passTest(NextPC, 64'hc, "", passed);
      

      allPassed(passed, 8);
   end
   
endmodule
