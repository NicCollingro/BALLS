module LEDs(input wire enable, input wire correct);
    reg [7:0] leds;
    reg [10:0] Evaluation; 
    reg [10:0] Games;
    
    always @(posedge enable) begin
        Games <= Games + 1;
        if (correct) begin
            Evaluation <= Evaluation + 1;
        end

        if (Games == 10'd1024) begin
            leds <= 8'b11111111;
        end
    end
    
    


endmodule