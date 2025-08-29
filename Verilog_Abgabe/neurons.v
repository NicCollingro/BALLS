module neurons(
    input wire rst,
    input wire [1:0] xin,
    input wire update_clk,
    output wire [39:0] xalt_packed
);
    reg signed [1:0] xalt [0:19];

    generate
    genvar j;
    for (j = 0; j < 20; j = j + 1) begin : xalt_packing
        assign xalt_packed[j*2 +: 2] = xalt[j];
    end
    endgenerate

    integer i;
    always @(posedge rst or posedge update_clk) begin
        if (rst) begin
            for (i = 0; i < 20; i = i + 1) begin
                xalt[i] <= 2'b01;
            end
        end else begin
            for (i = 10; i >= 0; i = i - 1) begin
                if (i == 0) begin
                    xalt[i] <= xin;
                end else begin
                    xalt[i] <= xalt[i-1];
                end
            end
        end
    end
endmodule