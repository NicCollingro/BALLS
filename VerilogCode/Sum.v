module Sum(input reg [19:0] N, input reg[19:0] weigths, output reg [20:0] Sum);
	Sum <= Sum + N*weigths;
endmodule
