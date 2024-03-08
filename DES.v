module f(R, K, out); //f function
  input [31:0] R;
  input [47:0] K;
  output [31:0] out;

  wire [47:0] R_E, T;
  wire [31:0] S_out;
  wire [5:0] S1_in, S2_in, S3_in, S4_in, S5_in, S6_in, S7_in, S8_in;
  wire [3:0] S1_out, S2_out, S3_out, S4_out, S5_out, S6_out, S7_out, S8_out;
  E E_inst(R, R_E);

  assign T = R_E ^ K;
  assign {S1_in, S2_in, S3_in, S4_in, S5_in, S6_in, S7_in, S8_in} = T;


  S1 S1_inst(S1_in, S1_out);
  S2 S2_inst(S2_in, S2_out);
  S3 S3_inst(S3_in, S3_out);
  S4 S4_inst(S4_in, S4_out);
  S5 S5_inst(S5_in, S5_out);
  S6 S6_inst(S6_in, S6_out);
  S7 S7_inst(S7_in, S7_out);
  S8 S8_inst(S8_in, S8_out);

  assign S_out = {S1_out, S2_out, S3_out, S4_out, S5_out, S6_out, S7_out, S8_out};
  P P_inst(S_out, out);
endmodule

module KS_left_shift(lv, in, out);
  input [4:0] lv;
  input [27:0] in;
  output [27:0] out;
  wire SEL;

  assign SEL = (lv == 'd1 || lv == 'd2 || lv == 'd9 || lv == 'd16) ? 1 : 0;
  assign out = (SEL) ? {in[26:0], in[27]} : {in[25:0], in[27:26]};
endmodule

module KS(key, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16); //key schedule
  input [63:0] key;
  output [47:0] k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16;

  wire [55:0] pc1_out;
  wire [28:1] c [0:16];
  wire [28:1] d [0:16];
  wire [48:1] k [1:16];

  PC1 pc1_inst(key, pc1_out);
  assign c[0] = pc1_out[55:28];
  assign d[0] = pc1_out[27:0];

  genvar i;
  generate
    for (i = 1; i <= 16; i = i + 1) begin : blk
      wire [5:1] lv = i;
      KS_left_shift KS_ls_inst1(lv, c[i - 1], c[i]);
      KS_left_shift KS_ls_inst2(lv, d[i - 1], d[i]);
      PC2 pc2_inst({c[i], d[i]}, k[i]);
    end
  endgenerate

  assign k1 = k[1];
  assign k2 = k[2];
  assign k3 = k[3];
  assign k4 = k[4];
  assign k5 = k[5];
  assign k6 = k[6];
  assign k7 = k[7];
  assign k8 = k[8];
  assign k9 = k[9];
  assign k10 = k[10];
  assign k11 = k[11];
  assign k12 = k[12];
  assign k13 = k[13];
  assign k14 = k[14];
  assign k15 = k[15];
  assign k16 = k[16];
endmodule

module DFF64(D, CLK, Q); //D-FF 64bit Register 
  input [63:0] D;
  input CLK;
  output reg [63:0] Q;

  always @ (posedge CLK) begin
     Q <= D;
  end
endmodule

module DES_line(in, key, out); //1 round
  input [63:0] in;
  input [47:0] key;
  output [63:0] out;
  wire [31:0] left, right, f_out;

  assign left = in[63:32];
  assign right = in[31:0];

  f f_inst(right, key, f_out);

  assign out[63:32] = right;
  assign out[31:0] = left ^ f_out;
endmodule


module DES(in, key, CLK, out); //pineline DES
  input [63:0] in, key;
  input CLK;
  output [63:0] out;

  wire [48:1] k [1:16];
  KS ks_inst(key, k[1], k[2], k[3], k[4], k[5], k[6], k[7], k[8], k[9], k[10], k[11], k[12], k[13], k[14], k[15], k[16]); //key schedule
  
  wire [63:0] ip2DL, DL1, DL2, DL3, DL4, DL5, DL6, DL7, DL8, DL9, DL10, DL11, DL12, DL13, DL14, DL15, DL16;
  wire [63:0] DL_p1, DL_p2, DL_p3, DL_p4, DL_p5, DL_p6, DL_p7, DL_p8, DL_p9, DL_p10, DL_p11, DL_p12, DL_p13, DL_p14, DL_p15, DL_p16;

  IP ip_inst(in, ip2DL);
  
  DES_line DES_line(ip2DL, k[1], DL1);
  DFF64 REG1(DL1, CLK, DL_p1);

  DES_line DES_line2(DL_p1, k[2], DL2);
  DFF64 REG2(DL2, CLK, DL_p2);

  DES_line DES_line3(DL_p2, k[3], DL3);
  DFF64 REG3(DL3, CLK, DL_p3);
  
  DES_line DES_line4(DL_p3, k[4], DL4);
  DFF64 REG4(DL4, CLK, DL_p4);
  
  DES_line DES_line5(DL_p4, k[5], DL5);
  DFF64 REG5(DL5, CLK, DL_p5);
  
  DES_line DES_line6(DL_p5, k[6], DL6);
  DFF64 REG6(DL6, CLK, DL_p6);
  
  DES_line DES_line7(DL_p6, k[7], DL7);
  DFF64 REG7(DL7, CLK, DL_p7);
  
  DES_line DES_line8(DL_p7, k[8], DL8);
  DFF64 REG8(DL8, CLK, DL_p8);
  
  DES_line DES_line9(DL_p8, k[9], DL9);
  DFF64 REG9(DL9, CLK, DL_p9);
  
  DES_line DES_line10(DL_p9, k[10], DL10);
  DFF64 REG10(DL10, CLK, DL_p10);
  
  DES_line DES_line11(DL_p10, k[11], DL11);
  DFF64 REG11(DL11, CLK, DL_p11);
  
  DES_line DES_line12(DL_p11, k[12], DL12);
  DFF64 REG12(DL12, CLK, DL_p12);
  
  DES_line DES_line13(DL_p12, k[13], DL13);
  DFF64 REG13(DL13, CLK, DL_p13);
  
  DES_line DES_line14(DL_p13, k[14], DL14);
  DFF64 REG14(DL14, CLK, DL_p14);
  
  DES_line DES_line15(DL_p14, k[15], DL15);
  DFF64 REG15(DL15, CLK, DL_p15);
  
  DES_line DES_line16(DL_p15, k[16], DL16);
  DFF64 REG16(DL16, CLK, DL_p16);
  
  IP_inv ip_inv_inst(DL_p16, out);
endmodule
