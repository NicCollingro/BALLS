module FPGA (
    input wire CLOCK_50,
    input wire k1,           //GPIO idk
    input wire k2,           //GPIO idk
    output wire [7:0] led   //GP i still dont know
);

// variablen die wir brauchen 
reg check = 1'd0;
reg halt = 1'd0;
reg xin = 1'dx;
reg [2:0] cycle = 3'd0;
reg [9:0] weights[19:0];
reg [19:0] xalt = 20'd0; //0 heißt positiv da 1 signed ist  
reg [9:0] y = 10'd0;
reg [9:0] eins/N = 10'b0000000010;
reg [9:0] gamma = 10'b0000101101; //ungefähr 1,4 als decimalzahl
//mit MSB signed 4bit >= 1 und die letzten 4 bit <1 
//nach komma funktioniert mit binährzahl hier 0110 also 6 / 16 bzw 0110 /1111 <- hier kommt die 16 her weil 16 möglichkeiten


// knopfdruck mit debounce (maybe weiß noch nicht)
always @(negedge k1) begin //oder posedge wenn k1 standard high ist
    if (check == 1'd0) halt <= 1;    // ^ <- XOR
    xin <= 1'd1;
end

always @(negedge k2) begin //beidesmal input überschreiben 
    if (check == 1'd0) halt <= 1;
    xin <= 1'd0;
end

always @(posedge CLOCK_50) begin
    case (cycle)
        3'd0: begin if (halt == 1'd1) begin
            check <= 1:
            cycle <= cycle + 3'd1;
            end
        end
        3'd1: 

        default: cycle <= 3'd0;
    endcase 
end
endmodule

module gammanorm (
    input wire signed [9:0] weights[19:0], 
    input wire signed [9:0] gamma,          
    output reg signed [9:0] result          
);

    integer i;
    reg signed [19:0] quad;          
    reg signed [29:0] sumquad;                 

    always @(*) begin
        sumquad = 30'd0;
        for (i = 0; i < 20; i = i + 1) begin
            quad = weights[i] * weights[i]; 
            sumquad = sumquad + quad; 
        end
    end
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
