module weight_module (
    input wire learn_clock,
    input wire rst,
    input wire signed [1:0] xin,
    input wire [39:0] xalt,
    output wire [199:0] weights_packed
);
    // IMPORTANT: Braucht mindestens 8 Bruchbits für's lernen
    reg signed [9:0] weights [0:19];

    generate
    genvar j;
    for (j = 0; j<20; j = j + 1) begin : packing_weights
        wire signed [9:0] debug = weights[j];
        assign weights_packed[(j*10) +:10] = weights[j];
    end

    wire signed[1:0] neurons [0:19];
    for (j = 0; j < 20; j = j + 1) begin : unpack_neurons
       assign neurons[j] = xalt[j*2 +: 2];
    end
    endgenerate

    integer i;
    reg signed [3:0] const = 4'd7;
    always @(posedge learn_clock or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 20; i = i + 1) begin
                weights[i] <= 0;
            end
        end else begin
            for (i = 0; i < 20; i = i + 1) begin
                weights[i] <= weights[i] + xin * neurons[i] * const;
            end
        end
    end
endmodule