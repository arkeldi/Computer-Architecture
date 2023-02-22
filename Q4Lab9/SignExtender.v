


module SignExtender(BusImm, Imm, Ctrl); 

	output [63:0] BusImm;
	input [25:0] Imm;
	input [2:0] Ctrl;
	
	
	reg [63:0] result;
	
	
	always @(*)
	begin
		case(Ctrl)
			3'b000: begin //I type 
				result = {{52{1'b0}}, Imm[21:10]}; end
			3'b001: begin //D
				result = {{55{Imm[20]}}, Imm[20:12]}; end
			3'b010: begin // B
				result = {{36{Imm[25]}}, Imm[25:0], 2'b00}; end
			3'b011: begin //CB
				result = {{43{Imm[23]}}, Imm[23:5], 2'b00}; end
			3'b100: begin
				result = {{48{1'b0}}, Imm[20:5]}; end
			3'b101: begin
				result = {{32{1'b0}}, Imm[20:5], {16{1'b0}}}; end
			3'b110: begin
				result = {{16{1'b0}}, Imm[20:5], {32{1'b0}}}; end
			3'b111: begin
				result = {Imm[20:5], {48{1'b0}}}; end
		endcase
	end
	
	assign BusImm = result;
	
endmodule
