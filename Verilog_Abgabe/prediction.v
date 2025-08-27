module prediction(
    input wire [199:0] weights_packed,
    input wire [39:0] xalt_packed,
    output wire [9:0] y
);
    wire signed [9:0] weights [0:19];
    genvar j;
    for (j = 0; j < 20; j = j + 1) begin : unpacking_weights
        assign weights[j] = weights_packed[(10*j) +:10];
    end

    wire signed [1:0] xalt [0:19];
    for (j = 0; j < 20; j = j + 1) begin : unpacking_neurons
        assign xalt[j] = xalt_packed[j*2 +: 2];
    end

    wire signed [9:0] sums [0:19];
    assign sums[0] = xalt[0] * weights[0];

    for (j = 1; j < 20; j = j + 1) begin : sum_chain
        assign sums[j] = sums[j-1] + weights[j] * xalt[j];
    end

    assign y = sums[19];
endmodule