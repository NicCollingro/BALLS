module sqrt(
  input  wire[7:0] in,
  output wire[7:0] out
);

  assign out =   (in >= 225) ? 15
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
