module S2(in, out);
  input [5:0] in;
  output reg [3:0] out;
  
  always @ (*) begin
    case (in)
      0 : out = 15;
      1 : out = 3;
      2 : out = 1;
      3 : out = 13;
      4 : out = 8;
      5 : out = 4;
      6 : out = 14;
      7 : out = 7;
      8 : out = 6;
      9 : out = 15;
      10 : out = 11;
      11 : out = 2;
      12 : out = 3;
      13 : out = 8;
      14 : out = 4;
      15 : out = 14;
      16 : out = 9;
      17 : out = 12;
      18 : out = 7;
      19 : out = 0;
      20 : out = 2;
      21 : out = 1;
      22 : out = 13;
      23 : out = 10;
      24 : out = 12;
      25 : out = 6;
      26 : out = 0;
      27 : out = 9;
      28 : out = 5;
      29 : out = 11;
      30 : out = 10;
      31 : out = 5;
      32 : out = 0;
      33 : out = 13;
      34 : out = 14;
      35 : out = 8;
      36 : out = 7;
      37 : out = 10;
      38 : out = 11;
      39 : out = 1;
      40 : out = 10;
      41 : out = 3;
      42 : out = 4;
      43 : out = 15;
      44 : out = 13;
      45 : out = 4;
      46 : out = 1;
      47 : out = 2;
      48 : out = 5;
      49 : out = 11;
      50 : out = 8;
      51 : out = 6;
      52 : out = 12;
      53 : out = 7;
      54 : out = 6;
      55 : out = 12;
      56 : out = 9;
      57 : out = 0;
      58 : out = 3;
      59 : out = 5;
      60 : out = 2;
      61 : out = 14;
      62 : out = 15;
      63 : out = 9;
    endcase
  end
endmodule
