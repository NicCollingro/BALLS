`default_nettype none

module tb_FPGA;
reg clk;
reg key0 = 1;
reg key1 = 1;
wire [7:0] led;

FPGA balls
(
    .CLOCK_50(clk),
    .key0(key0),
    .key1(key1),
    .led(led)
);

localparam CLK_PERIOD = 2;
always #(CLK_PERIOD/2) clk=~clk;

integer i;
initial begin
    $dumpfile("tb_FPGA.vcd");
    $dumpvars(0, tb_FPGA);
    for (i = 0; i < 16; i = i + 1) begin
        $dumpvars(0, balls.weight_mod.weights[i]); // dump memory contents
        $dumpvars(0, balls.weight_mod.neurons[i]); // dump memory contents
    end
end

/*
    #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);
*/

/*
    #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);
*/

initial begin
    #0 clk <= 0;

    #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

    #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key1 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key1 <= 1;
    wait(balls.fsm == 0);

        #(CLK_PERIOD) key0 <= 0;
    wait(balls.fsm == 1);
    #(CLK_PERIOD) key0 <= 1;
    wait(balls.fsm == 0);

    $finish(2);
end

endmodule
`default_nettype wire