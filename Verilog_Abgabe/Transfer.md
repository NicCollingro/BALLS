

module top_level(
    input wire CLOCK_50,
    input wire key0,
    input wire key1,
    output wire [7:0] led,
    output reg GPIO_023, GPIO_021, GPIO_019, GPIO_017, GPIO_015, GPIO_013, GPIO_011, GPIO_009,
    output wire GPIO_001
);
    // flags/triggers
    reg false_prediction = 0;
    reg learn_trigger = 0;
    reg update_trigger = 0;
    reg fsm_trigger = 0;
    reg reset = 1;

    // led output
    reg [9:0] total = 0;
    reg [9:0] hits = 0;
    wire [17:0] ratio = (hits << 8)/total;
    assign led = (ratio > 255) ? 8'd255 : ratio[7:0];
    assign GPIO_001 = 0;
    

    // key input
    reg signed [1:0] xin = 2'b01;
    reg old_key0 = 1;
    reg old_key1 = 1;
    reg key0_deb = 1;
    reg key1_deb = 1;

    reg [24:0] input_cnt = 0;
    wire debounce = input_cnt[0];

    always @(posedge CLOCK_50) begin
        reset <= 1'b0;
        input_cnt <= input_cnt + 1;

//        if (debounce) begin
        old_key0 <= key0;
        old_key1 <= key1;
//        end

        fsm_trigger <= (old_key0 & ~key0 | old_key1 & ~key1) | fsm_trigger & fsm != 0;
        if (old_key0 & ~key0 & ~fsm_trigger) begin
            xin <= 2'b01;
        end
        if (old_key1 & ~key1 & ~fsm_trigger) begin
            xin <= 2'b11;
        end
    end

    // neurons
    wire [39:0] xalt_packed;
    neurons storage(
        .rst(reset),
        .xin(xin),
        .update_clk(update_trigger),
        .xalt_packed(xalt_packed)
    );

    // weight related stuff
    wire [199:0] weights_packed;
    weight_module weight_mod (
        .learn_clock(learn_trigger),
        .xin(xin),
        .rst(reset),
        .xalt(xalt_packed),
        .weights_packed(weights_packed)
    );

    // norming (output is in Q4.5 signed)
    wire signed [9:0] abs_w;
    norm normal(
        .weights_packed(weights_packed),
        .result(abs_w)
    );

    // prediction (Q4.5 format, nur sign ist relevant)
    wire signed [9:0] y;
    prediction pred (
        .weights_packed(weights_packed),
        .xalt_packed(xalt_packed),
        .y(y)
    );

    // Gamma in Q4.5 signed
    reg signed [9:0] gamma = 10'd45;

    // state machine
    reg [2:0] fsm = 0;
    always @(posedge CLOCK_50) begin

	{GPIO_009, GPIO_011, GPIO_013, GPIO_015 , GPIO_017 , GPIO_019, GPIO_021, GPIO_023} <= led;

        case (fsm)
            3'd0: begin
                // idle state, keep until triggered
                if (fsm_trigger)
                    fsm <= fsm + 1;
            end
            3'd1: begin
                // compare prediction to input
                false_prediction <= xin[1] ^ y[9];
                fsm <= fsm + 1;
            end
            3'd2: begin
                // if false, determine if learn rule is applicable and trigger learning
                if (false_prediction) begin
                    learn_trigger <= (y[9] ^ xin[1])| (y <= gamma * abs_w);
                end else begin
                    hits <= hits + 1;
                end
                total <= total + 1;
                fsm <= fsm + 1;
            end
            3'd3: begin
                // reset learn_trigger
                learn_trigger <= 0;
                fsm <= fsm + 1;
            end
            3'd4: begin
                // neuron update clock
                update_trigger <= 1'b1;
                fsm <= fsm + 1;
            end
            3'd5: begin
                update_trigger <= 1'b0;
                fsm <= fsm + 1;
            end
            default: fsm <= 0;
        endcase
    end
endmodule
