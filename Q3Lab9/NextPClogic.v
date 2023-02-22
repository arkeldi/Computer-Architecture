module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
       input [63:0] CurrentPC, SignExtImm64;
       input Branch, ALUZero, Uncondbranch;
       output [63:0] NextPC;
       wire [63:0] shiftSignExt = SignExtImm64;
       wire AND0 = Branch && ALUZero; 
       wire muxControl = AND0 || Uncondbranch; 
       reg [63:0] muxOutput; 
       always @ (*)
       begin
              if(muxControl)
                     muxOutput =   CurrentPC + shiftSignExt;
              else
                     muxOutput =  CurrentPC + 4;
       end
       assign NextPC = muxOutput; // Assign next PC
endmodule
