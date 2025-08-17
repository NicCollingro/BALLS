module FPGA (
    input wire CLOCK_50,
    input wire k1,           //GPIO idk
    input wire k2,           //GPIO idk
    output wire [7:0] led   //GP i still dont know
);

// variablen die wir brauchen 
reg [7:0] regled;
reg check = 1'd0;
reg halt = 1'd0;
reg xin = 1'd0;
reg [2:0] cycle = 3'd0;
reg signed [9:0] weights[19:0];
reg [19:0] xalt = 20'd0; //0 heißt positiv da 1 signed ist  
reg signed [19:0] y = 20'd0;
reg [9:0] einsN = 10'b0000000010;
reg [9:0] gamma = 10'b0000101101; //ungefähr 1,4 als decimalzahl
wire signed[9:0] result;
reg signed [19:0] yhelp;
integer i;
//mit MSB signed 4bit >= 1 und die letzten 4 bit <1 
//nach komma funktioniert mit binährzahl hier 0110 also 6 / 16 bzw 0110 /1111 <- hier kommt die 16 her weil 16 möglichkeiten

// moddule 
norm worm(.weights(weights), .result(result));
// knopfdruck mit debounce (maybe weiß noch nicht)
always @(negedge k1) begin //oder posedge wenn k1 standard high ist
    if (check == 1'd0) begin     // ^ <- XOR
        halt <= 1;
        xin <= 1'd1;
    end
end

always @(negedge k2) begin //beidesmal input überschreiben 
    if (check == 1'd0) begin 
        halt <= 1;
        xin <= 1'd0;
    end
end

// sollt man noch zu einem ADALINE modul machen ist aber nicht so wichtig 

always @(posedge CLOCK_50) begin
    case (cycle)
        3'd0: begin if (halt == 1'd1) begin
                check <= 1;
                cycle <= cycle + 3'd1;
            end
        end
        3'd1: begin if (gamma*result >= y && y[9] ^ xin == 1'd0) begin
             // hier passiert die Formel check bedingung   
                for (i = 0; i < 20; i = i + 1) begin
                    if (xin ^ xalt[i] == 0) weights[i] = weights[i] + einsN;
                    else weights[i] = weights[i] - einsN;
                    end
                cycle <= cycle + 1'd1;
                xalt <={xalt[18:0],xin};
            end    
            else begin
                xalt <={xalt[18:0],xin}; // Bitshift tamam WICHTIG shift nach links sodass die
                check <= 0;              // durchiteration passt du bastard
                halt <= 0;
                cycle <= 3'd0;
            end
        end
        3'd2: begin // mathe magie 101
            yhelp <= 20'd0;
            for (i = 0; i < 20; i = i + 1) begin
                if (xalt[i] == 0) yhelp = yhelp + weights[i];
                else yhelp = yhelp - weights[i];   
            end
            y <= yhelp;
            
            cycle <= cycle + 1'd1;
        end
        3'd3: begin //LED kappes brauch noch genauigkeit
            if ( y[9] == 0) regled <= 8'b11110000;
            else begin
                regled <= 8'b00001111;
            end
            check <= 0;             
            halt <= 0;
            cycle <= 3'd0;
        end
        default: cycle <= 3'd0;
    endcase 
end

assign led = regled;
endmodule


