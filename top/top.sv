`timescale 1ns / 10ps
module top;
  import GPIO_pkg::*;
  import uvm_pkg::*;

  bit PCLK;
  bit ext_clk_pad_i;
  always #5 PCLK = ~PCLK;
  always #15 ext_clk_pad_i = ~ext_clk_pad_i;

  apb_top i1 (
      .PCLK(PCLK),
      .PRESETn(intf_apb.PRESETn),
      .PSEL(intf_apb.PSEL),
      .PENABLE(intf_apb.PENABLE),
      .PWRITE(intf_apb.PWRITE),
      .PADDR(intf_apb.PADDR),
      .PWDATA(intf_apb.PWDATA),
      .PRDATA(intf_apb.PRDATA),
      .IRQ(intf_apb.IRQ),
      .PREADY(intf_apb.PREADY),
      .aux_in(intf_aux.aux_in),
      .io_pad(intf_io.io_pad),
      .ext_clk_pad_i(ext_clk_pad_i)
  );

  interface_apb intf_apb (PCLK);
  interface_aux intf_aux (PCLK);
  interface_io intf_io (PCLK);

  initial begin
    uvm_config_db#(virtual interface_apb)::set(null, "*", "vif_apb", intf_apb);
    uvm_config_db#(virtual interface_aux)::set(null, "*", "vif_aux", intf_aux);
    uvm_config_db#(virtual interface_io)::set(null, "*", "vif_io", intf_io);

    run_test;
  end

endmodule
