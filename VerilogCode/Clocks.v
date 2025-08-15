module clocks(input CLOCK_50, output wire Clock_Input, output wire Clock_Calc, output wire Clock_Write);
	reg counter [2:0] = 3'b100;
	
	always @(posedge CLOCK_50) begin
		{Clock_Input, Clock_Calc, Clock_Write} <= counter;
		case(counter)
			'b100: cnt <= 'b001;
			'b010: cnt <= 'b100;
			'b001: cnt <= 'b010
		endcase
	end
endmodule
