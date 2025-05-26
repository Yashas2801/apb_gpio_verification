/*
`timescale 1ns / 10ps

interface interface_io (
    input bit PCLK
);
  logic [31:0] io_pad;
  bit ext_clk_pad_i;

  clocking drv_cb @(posedge PCLK);
    default input #1 output #0;
    inout io_pad;
    output ext_clk_pad_i;
  endclocking

  clocking mon_cb @(posedge PCLK);
    default input #1 output #0;
    inout io_pad;
    input ext_clk_pad_i;
  endclocking

  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);
endinterface
*/

`timescale 1ns / 10ps

interface interface_io (
    input bit PCLK
);
  tri   [31:0] io_pad;  // bidirectional data bus
  bit          ext_clk_pad_i;  // external clock input

  // io_out[i] drives io_pad[i] when io_en[i]==1, otherwise that bit is hi-Z
  logic [31:0] io_out;
  bit   [31:0] io_en;

  // Per-bit tri-state assignment
  genvar i;
  generate
    for (i = 0; i < 32; i++) begin : g_bidirectional
      assign io_pad[i] = io_en[i] ? io_out[i] : 'bz;
    end
  endgenerate

  clocking drv_cb @(posedge PCLK);
    default input #1 output #0;
    inout io_pad;  // drive or sample the entire bus
    output io_out, io_en;  // tell the DUT what to drive and when
    input ext_clk_pad_i;  // sample the external clock pin
  endclocking

  clocking mon_cb @(posedge PCLK);
    default input #1 output #0;
    input io_pad;  // monitor every bit on the bus
    input ext_clk_pad_i;  // monitor the external clock pin
  endclocking

  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);

endinterface
