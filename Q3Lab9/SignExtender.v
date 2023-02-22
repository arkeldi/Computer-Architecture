


module SignExtender(BusImm, Imm, Ctrl); 

	output [63:0] BusImm;
	input [25:0] Imm;
	input [1:0] Ctrl;
	
	
	reg [63:0] result;
	
	
	always @(*)
	begin
		case(Ctrl)
			2'b00: begin //I type 
				result = {{52{1'b0}}, Imm[21:10]}; end
			2'b01: begin //D
				result = {{55{Imm[20]}}, Imm[20:12]}; end
			2'b10: begin // B
				result = {{36{Imm[25]}}, Imm[25:0], 2'b00}; end
			2'b11: begin //CB
				result = {{43{Imm[23]}}, Imm[23:5], 2'b00}; end
		endcase
	end
	
	assign BusImm = result;
	
endmodule
