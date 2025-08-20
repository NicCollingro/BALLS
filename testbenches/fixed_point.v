module tb_fixedpoint;
initial begin
    $monitor("%d %d | %d", N1, N2, N_OUT);
end

    reg [9:0] N1 = 0;
    reg [9:0] N2 = 1;
    wire [17:0] N_OUT;

    fixed_point #(
        .dec(10),
        .frac(8)
    ) FP (
        .N1(N1),
        .N2(N2),
        .N_OUT(N_OUT)
    );

initial begin
    #1 N1 = 1; N2 = 1;
    #1 N1 = 1; N2 = 2;
    #1 N1 = 353; N2 = 369;
end

endmodule
module fixed_point #(
    parameter dec = 1,
    parameter frac = 0
) (
    input wire [dec-1: 0] N1,
    input wire [dec-1: 0] N2,
    output wire [dec+frac-1:0] N_OUT
);
    assign N_OUT = ((N1<<frac)/N2);
endmodule

