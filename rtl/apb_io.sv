module apb_io (
    input wire [31:0] out_pad,
    output wire [31:0] in_pad,
    inout wire [31:0] io_pad,
    input wire [31:0] oen_padoe,
    input wire ext_clk_pad_i,

    output wire gpio_eclk
);

  assign io_pad[0]  = oen_padoe[0] ? out_pad[0] : 1'bz;
  assign io_pad[1]  = oen_padoe[1] ? out_pad[1] : 1'bz;
  assign io_pad[2]  = oen_padoe[2] ? out_pad[2] : 1'bz;
  assign io_pad[3]  = oen_padoe[3] ? out_pad[3] : 1'bz;
  assign io_pad[4]  = oen_padoe[4] ? out_pad[4] : 1'bz;
  assign io_pad[5]  = oen_padoe[5] ? out_pad[5] : 1'bz;
  assign io_pad[6]  = oen_padoe[6] ? out_pad[6] : 1'bz;
  assign io_pad[7]  = oen_padoe[7] ? out_pad[7] : 1'bz;
  assign io_pad[8]  = oen_padoe[8] ? out_pad[8] : 1'bz;
  assign io_pad[9]  = oen_padoe[9] ? out_pad[9] : 1'bz;
  assign io_pad[10] = oen_padoe[10] ? out_pad[10] : 1'bz;
  assign io_pad[11] = oen_padoe[11] ? out_pad[11] : 1'bz;
  assign io_pad[12] = oen_padoe[12] ? out_pad[12] : 1'bz;
  assign io_pad[13] = oen_padoe[13] ? out_pad[13] : 1'bz;
  assign io_pad[14] = oen_padoe[14] ? out_pad[14] : 1'bz;
  assign io_pad[15] = oen_padoe[15] ? out_pad[15] : 1'bz;
  assign io_pad[16] = oen_padoe[16] ? out_pad[16] : 1'bz;
  assign io_pad[17] = oen_padoe[17] ? out_pad[17] : 1'bz;
  assign io_pad[18] = oen_padoe[18] ? out_pad[18] : 1'bz;
  assign io_pad[19] = oen_padoe[19] ? out_pad[19] : 1'bz;
  assign io_pad[20] = oen_padoe[20] ? out_pad[20] : 1'bz;
  assign io_pad[21] = oen_padoe[21] ? out_pad[21] : 1'bz;
  assign io_pad[22] = oen_padoe[22] ? out_pad[22] : 1'bz;
  assign io_pad[23] = oen_padoe[23] ? out_pad[23] : 1'bz;
  assign io_pad[24] = oen_padoe[24] ? out_pad[24] : 1'bz;
  assign io_pad[25] = oen_padoe[25] ? out_pad[25] : 1'bz;
  assign io_pad[26] = oen_padoe[26] ? out_pad[26] : 1'bz;
  assign io_pad[27] = oen_padoe[27] ? out_pad[27] : 1'bz;
  assign io_pad[28] = oen_padoe[28] ? out_pad[28] : 1'bz;
  assign io_pad[29] = oen_padoe[29] ? out_pad[29] : 1'bz;
  assign io_pad[30] = oen_padoe[30] ? out_pad[30] : 1'bz;
  assign io_pad[31] = oen_padoe[31] ? out_pad[31] : 1'bz;

  assign in_pad[0]  = ~oen_padoe[0] ? io_pad[0] : 1'bz;
  assign in_pad[1]  = ~oen_padoe[1] ? io_pad[1] : 1'bz;
  assign in_pad[2]  = ~oen_padoe[2] ? io_pad[2] : 1'bz;
  assign in_pad[3]  = ~oen_padoe[3] ? io_pad[3] : 1'bz;
  assign in_pad[4]  = ~oen_padoe[4] ? io_pad[4] : 1'bz;
  assign in_pad[5]  = ~oen_padoe[5] ? io_pad[5] : 1'bz;
  assign in_pad[6]  = ~oen_padoe[6] ? io_pad[6] : 1'bz;
  assign in_pad[7]  = ~oen_padoe[7] ? io_pad[7] : 1'bz;
  assign in_pad[8]  = ~oen_padoe[8] ? io_pad[8] : 1'bz;
  assign in_pad[9]  = ~oen_padoe[9] ? io_pad[9] : 1'bz;
  assign in_pad[10] = ~oen_padoe[10] ? io_pad[10] : 1'bz;
  assign in_pad[11] = ~oen_padoe[11] ? io_pad[11] : 1'bz;
  assign in_pad[12] = ~oen_padoe[12] ? io_pad[12] : 1'bz;
  assign in_pad[13] = ~oen_padoe[13] ? io_pad[13] : 1'bz;
  assign in_pad[14] = ~oen_padoe[14] ? io_pad[14] : 1'bz;
  assign in_pad[15] = ~oen_padoe[15] ? io_pad[15] : 1'bz;
  assign in_pad[16] = ~oen_padoe[16] ? io_pad[16] : 1'bz;
  assign in_pad[17] = ~oen_padoe[17] ? io_pad[17] : 1'bz;
  assign in_pad[18] = ~oen_padoe[18] ? io_pad[18] : 1'bz;
  assign in_pad[19] = ~oen_padoe[19] ? io_pad[19] : 1'bz;
  assign in_pad[20] = ~oen_padoe[20] ? io_pad[20] : 1'bz;
  assign in_pad[21] = ~oen_padoe[21] ? io_pad[21] : 1'bz;
  assign in_pad[22] = ~oen_padoe[22] ? io_pad[22] : 1'bz;
  assign in_pad[23] = ~oen_padoe[23] ? io_pad[23] : 1'bz;
  assign in_pad[24] = ~oen_padoe[24] ? io_pad[24] : 1'bz;
  assign in_pad[25] = ~oen_padoe[25] ? io_pad[25] : 1'bz;
  assign in_pad[26] = ~oen_padoe[26] ? io_pad[26] : 1'bz;
  assign in_pad[27] = ~oen_padoe[27] ? io_pad[27] : 1'bz;
  assign in_pad[28] = ~oen_padoe[28] ? io_pad[28] : 1'bz;
  assign in_pad[29] = ~oen_padoe[29] ? io_pad[29] : 1'bz;
  assign in_pad[30] = ~oen_padoe[30] ? io_pad[30] : 1'bz;
  assign in_pad[31] = ~oen_padoe[31] ? io_pad[31] : 1'bz;
  assign gpio_eclk  = ext_clk_pad_i;

endmodule
