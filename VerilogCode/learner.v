module learner (
    input wire [8:0] walt,
    input wire x_j,
    input wire x_in,
    output wire [8:0] wneu
);

    wire [7:0] mag_a = walt[7:0];
    wire sign_a = walt[8];

    reg [7:0] mag_b = 8'd7;
    wire sign_b = x_j ^ x_in;

    wire [7:0] mag_res = (sign_a ^ sign_b) ? ((mag_a > mag_b) ? mag_a - mag_b : mag_b - mag_a) : mag_a + mag_b;
    wire sign_res = (sign_a ^ sign_b) ? ((mag_a> mag_b) ? sign_a : sign_b) : sign_a;

    assign wneu = {sign_res, mag_res};
endmodule