module norm (
    input wire [179:0] weights,
    output wire [10:0] norm
);
    wire [14:0] sums [19:0];
    genvar i;
    generate
        wire [7:0] base0 = weights[7:0];
        wire [15:0] square0 = base0 * base0;
        assign sums[0] = square0;

        for (i = 1; i<20; i = i+1) begin : sq_sum
            wire [7:0] base = weights[9*i+7 -: 8];
            wire [14:0] square = base * base;
            wire [14:0] res = sums[i-1] +square;
            assign sums[i] = res;
        end
    endgenerate

    wire [9:0] mag_norm;
    sqrt norm_val (
        .in(sums[19]),
        .out(mag_norm)
    );
    assign norm = {1'b0, mag_norm};
endmodule