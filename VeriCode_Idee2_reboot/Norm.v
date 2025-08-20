/*
module norm (
    input wire[199:0] weights_packed,
    output reg signed [9:0] result
);
    // unpacking weights
    wire signed [9:0] weights [0:19];
    genvar j;
    for (j = 0; j<20; j = j + 1) begin : unpacking_weights
        assign weights[j] = weights_packed[(j*10) +: 10];
    end

    reg signed [29:0] sumquad;
    integer i;

    always @(*) begin
        sumquad = 30'd0;
        for (i = 0; i < 20; i = i + 1) begin
            sumquad = sumquad + weights[i] * weights[i];
        end
    end

    wire [9:0] out;
    sqrt squid(.in(sumquad[29:15]), .out(out));

    always @(*) begin
        result = {1'b0, out[3:0], 5'b00000}; //ich runde einfach auf weil die letzten 5 bit sind meine kommazahlen allso MSD signed -> 0 also 0 xxxx 00000 
    end //tamam
endmodule


module sqrt(
  input  wire[14:0] in,
  output wire[9:0] out
);

  assign out =   (in >= 1024) ? 32
               : (in >= 961) ? 31
               : (in >= 900) ? 30
               : (in >= 841) ? 29
               : (in >= 784) ? 28
               : (in >= 729) ? 27
               : (in >= 676) ? 26
               : (in >= 625) ? 25
               : (in >= 576) ? 24
               : (in >= 529) ? 23
               : (in >= 484) ? 22
               : (in >= 441) ? 21
               : (in >= 400) ? 20
               : (in >= 361) ? 19
               : (in >= 324) ? 18
               : (in >= 289) ? 17
               : (in >= 256) ? 16
               : (in >= 225) ? 15
               : (in >= 196) ? 14
               : (in >= 169) ? 13
               : (in >= 144) ? 12
               : (in >= 121) ? 11
               : (in >= 100) ? 10
               : (in >=  81) ?  9
               : (in >=  64) ?  8
               : (in >=  49) ?  7
               : (in >=  36) ?  6
               : (in >=  25) ?  5
               : (in >=  16) ?  4
               : (in >=   9) ?  3
               : (in >=   4) ?  2
               : (in >=   1) ?  1
               : 0;
endmodule
*/

module norm (
    input wire [199:0] weights_packed,
    output wire [9:0] result
);
    wire signed [9:0] weights [0:19];

    genvar j;
    for (j = 0; j < 20; j = j + 1) begin : unpacking_weights
        assign weights[j] = weights_packed[(j*10) +: 10];
    end

    wire signed [19:0] sq_w [0:19];
    for (j = 0; j < 20; j = j + 1) begin : squares
        assign sq_w[j] = weights[j] * weights[j];
    end

    wire signed [19:0] sums [0:19];
    assign sums[0] = sq_w[0];
    for (j = 1; j < 20; j = j + 1) begin : sum_chain
        assign sums[j] = sums[j-1] + sq_w[j];
    end

    wire [8:0] norm_res;
    sqrt rooter (
        .in(sums[19][18:0]),
        .out(norm_res)
    );

    assign result = {1'b0, norm_res};
endmodule

module sqrt(
  input  wire[18:0] in,
  output wire[8:0] out
);

  assign out =   (in >= 1764) ? 42
               : (in >= 1681) ? 41
               : (in >= 1600) ? 40
               : (in >= 1521) ? 39
               : (in >= 1444) ? 38
               : (in >= 1369) ? 37
               : (in >= 1296) ? 36
               : (in >= 1225) ? 35
               : (in >= 1156) ? 34
               : (in >= 1089) ? 33
               : (in >= 1024) ? 32
               : (in >= 961) ? 31
               : (in >= 900) ? 30
               : (in >= 841) ? 29
               : (in >= 784) ? 28
               : (in >= 729) ? 27
               : (in >= 676) ? 26
               : (in >= 625) ? 25
               : (in >= 576) ? 24
               : (in >= 529) ? 23
               : (in >= 484) ? 22
               : (in >= 441) ? 21
               : (in >= 400) ? 20
               : (in >= 361) ? 19
               : (in >= 324) ? 18
               : (in >= 289) ? 17
               : (in >= 256) ? 16
               : (in >= 225) ? 15
               : (in >= 196) ? 14
               : (in >= 169) ? 13
               : (in >= 144) ? 12
               : (in >= 121) ? 11
               : (in >= 100) ? 10
               : (in >=  81) ?  9
               : (in >=  64) ?  8
               : (in >=  49) ?  7
               : (in >=  36) ?  6
               : (in >=  25) ?  5
               : (in >=  16) ?  4
               : (in >=   9) ?  3
               : (in >=   4) ?  2
               : (in >=   1) ?  1
               : 0;
endmodule