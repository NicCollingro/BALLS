module weights(
    input wire [19:0] neurons,
    input wire [8:0] y,
    input wire x_in,
    input wire clk,
    input wire learn_mode,
    output wire [179:0] weight_out
);
    reg [8:0] weights [0:19];
    integer i;
    initial begin
        for (i = 0; i<20, i = i+1) begin
            weights[i] <= 0;

        end
    end

    generate
        genvar j;
        for (j = 0; j<20; j = j+1) begin : schools
            assign weight_out[8+(i*8):0+(i*8)] = weights[i];
            wire [8:0] wneu;
            learner school (
                .walt(weights[j]),
                .x_j(neurons[j]),
                .x_in(x_in),
                .wneu(wneu)
            );
        end
    endgenerate

    reg [8:0] norm_r = 0;

    // hier normer einfügen
    wire [8:0] norm_w;
    norm normer (
        .weights(weight_out),
        .norm(norm_w)
    )

    reg [8:0] gamma = {1'b0, 8'd180};

    always @(posedge clk) begin
        if (learn_mode) begin
            if ((y[8] ^ x_in) | y[7:0] <= gamma*norm_r) begin
                for (i = 0; i < 20; i = i+1) begin
                    weights[i] <= schools[i].wneu;
                end
            end
        end else begin
            norm_r <= norm_w;
        end
    end
endmodule