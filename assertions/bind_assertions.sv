bind apb_top gpio_assertions assert_inst (
    .PCLK(PCLK),
    .PRESETn(PRESETn),
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),
    .PREADY(PREADY),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA),
    .IRQ(IRQ),
    .io_pad(io_pad),
    .aux_in(aux_in),
    .ext_clk_pad_i(ext_clk_pad_i),
    .rgpio_oe(i1.reg_instance.rgpio_oe),
    .rgpio_out(i1.reg_instance.rgpio_out),
    .rgpio_in(i1.reg_instance.rgpio_in),
    .rgpio_inte(i1.reg_instance.rgpio_inte),
    .rgpio_ptrig(i1.reg_instance.rgpio_ptrig),
    .rgpio_eclk(i1.reg_instance.rgpio_eclk),
    .rgpio_nec(i1.reg_instance.rgpio_nec),
    .rgpio_ctrl(i1.reg_instance.rgpio_ctrl),
    .rgpio_ints(i1.reg_instance.rgpio_ints),
    .rgpio_aux(i1.reg_instance.rgpio_aux)
);
