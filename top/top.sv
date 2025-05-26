`timescale 1ns/10ps
module top;
	import gpio_pkg::*;
	import uvm_pkg::*;

	bit PCLK;
	
	always #5 PCLK = ~PCLK;

  apb_top i1 (
      .PCLK(PCLK),
      .PRESETn(PRESETn),
      .PSEL(PSEL),
      .PENABLE(PENABLE),
      .PWRITE(PWRITE),
      .PADDR(PADDR),
      .PWDATA(PWDATA),
      .PRDATA(PRDATA),
      .IRQ(IRQ),
      .PREADY(PREADY),
      .aux_in(aux_in),
      .io_pad(io_pad),
      .ext_clk_pad_i(ext_clk_pad_i)
  );
	interface_apb intf_apb;	
	interface_aux intf_aux;	
	interface_io intf_io;	
	
	initial begin
		uvm_config_db#(virtual interface_apb)::set(null,"*","vif_apb",intf_apb);
		uvm_config_db#(virtual interface_aux)::set(null,"*","vif_aux",intf_aux);
		uvm_config_db#(virtual interface_io)::set(null,"*","vif_io",intf_io);

	run_test;
	end	

endmodule
