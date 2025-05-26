interface interface_io(input bit PCLK);
	bit [31:0]io_pad;
	bit ext_clk_pad_i;
	
	clocking drv_cb@(posedge PCLK);
		default input #1 output #0;
		inout io_pad;
		output ext_clk_pad_i;
	endclocking

	clocking mon_cb@(posedge PCLK);
		default input #1 output #0;
		inout io_pad;
		input ext_clk_pad_i;
	endclocking

	modport DRV_MP(clocking drv_cb);
	modport MON_MP(clocking mon_cb);
endinterface
