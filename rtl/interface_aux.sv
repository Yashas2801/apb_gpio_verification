`timescale 1ns / 10ps

interface interface_aux (
    input bit PCLK
);
  bit [31:0] aux_in;

  clocking drv_cb @(posedge PCLK);
    default input #1 output #0;
    output aux_in;
  endclocking

  clocking mon_cb @(posedge PCLK);
    default input #1 output #0;
    input aux_in;
  endclocking

  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);
endinterface
