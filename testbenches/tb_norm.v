`include "../VerilogCode/norm.v"
`default_nettype none

module tb_norm;

wire [179:0] weights_bus;
genvar j;
for (j = 0; j < 20; j = j+1) begin: weights
    reg [8:0] weight = 0;
end
for (j = 0; j < 20; j = j + 1) begin
    assign weights_bus[8+(j*9):0+(j*9)] = weights[j].weight;
end

wire [10:0] norm;

norm nromer
(
    .weights(weights_bus),
    .norm(norm)
);

initial begin
    $dumpfile("normvars.vcd");
    $dumpvars;
    $dumpvars(0, nromer.sums[17], nromer.sums[0]);
end

initial begin
    #1 weights[19].weight = 13; weights[18].weight = 11; weights[17].weight = 12; weights[16].weight = 10; weights[15].weight = 8;
    #15 $finish;
end

endmodule
`default_nettype wire