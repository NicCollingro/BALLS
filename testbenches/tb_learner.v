`include "../VerilogCode/learner.v"
`default_nettype none

module tb_learner;

reg [8:0] walt = 0;
reg x_j = 0;
reg x_in = 0;

wire [8:0] wneu;
learner school 
(
    .walt(walt),
    .x_j(x_j),
    .x_in(x_in),
    .wneu(wneu)
);

initial begin
    $monitor ("%b %d %b %b | %b %d", walt[8], walt[7:0], x_j, x_in, wneu[8], wneu[7:0]);
end

initial begin
    #1 walt = {1'b0, 8'd0}; x_j = 0; x_j = 0;
    #1 walt = {1'b1, 8'd0}; x_j = 0; x_j = 0;
    #1 walt = {1'b0, 8'd3}; x_j = 0; x_j = 0;
    #1 walt = {1'b0, 8'd3}; x_j = 0; x_j = 1;
    #1 walt = {1'b0, 8'd3}; x_j = 1; x_j = 0;
    #1 walt = {1'b0, 8'd3}; x_j = 1; x_j = 1;
    #1 walt = {1'b0, 8'd8}; x_j = 0; x_j = 0;
    #1 walt = {1'b0, 8'd8}; x_j = 0; x_j = 1;
    #1 walt = {1'b0, 8'd8}; x_j = 1; x_j = 0;
    #1 walt = {1'b0, 8'd8}; x_j = 1; x_j = 1;
    #1 walt = {1'b1, 8'd3}; x_j = 0; x_j = 0;
    #1 walt = {1'b1, 8'd3}; x_j = 0; x_j = 1;
    #1 walt = {1'b1, 8'd3}; x_j = 1; x_j = 0;
    #1 walt = {1'b1, 8'd3}; x_j = 1; x_j = 1;
    #1 walt = {1'b1, 8'd8}; x_j = 0; x_j = 0;
    #1 walt = {1'b1, 8'd8}; x_j = 0; x_j = 1;
    #1 walt = {1'b1, 8'd8}; x_j = 1; x_j = 0;
    #1 walt = {1'b1, 8'd8}; x_j = 1; x_j = 1;
end

endmodule
`default_nettype wire