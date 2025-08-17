module norm (
    input wire [179:0] weights,
    output wire [8:0] norm
);
    wire [7:0] sums [17:0]
    generate
        genvar i;
        for (i = 0; i < 20; i) begin : squares
            wire [15:0] square_val = weights[7+(i*10):0+(i*10)] * weights[7+(i*10):0+(i*10)];
        end
        assign sums[0] = (squares[0].square_val + squares[1].square_val < 255) ?
            squares[0].square_val + squares[1].square_val :
                16'b255;
        for (i = 0; i < 18; i) begin : squares
            assign sums[i] = (sums[i] + squares[i+1].square_val < 255) ?
                sums[i] + squares[i+1].square_val :
                    16'b255;
        end
    endgenerate

    wire [7:0] mag_norm;
    sqrt norm_val (
        .in(sums[17]),
        .out(mag_norm)
    );
    assign norm = {1'b0, mag_norm};
endmodule