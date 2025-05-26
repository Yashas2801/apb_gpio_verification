`timescale 1ns / 10ps

interface interface_apb (
    input bit PCLK
);
  bit PRESETn;
  bit PSEL;
  bit PENABLE;
  bit PWRITE;
  bit PREADY;
  bit [31:0] PADDR;
  bit [31:0] PWDATA;
  bit [31:0] PRDATA;
  bit IRQ;

  clocking drv_cb @(posedge PCLK);
    default input #1 output #0;
    output PRESETn;
    output PSEL;
    output PENABLE;
    output PWRITE;
    input PREADY;
    output PADDR;
    output PWDATA;
    input PRDATA;
    input IRQ;
  endclocking

  clocking mon_cb @(posedge PCLK);
    default input #1 output #0;
    input PRESETn;
    input PSEL;
    input PENABLE;
    input PWRITE;
    input PREADY;
    input PADDR;
    input PWDATA;
    input PRDATA;
    input IRQ;
  endclocking

  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);

endinterface
