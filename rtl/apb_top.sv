module apb_top (
    input wire PCLK,
    input wire PRESETn,
    input wire PSEL,
    input wire PENABLE,
    input wire PWRITE,
    input wire [31:0] PADDR,
    input wire [31:0] PWDATA,
    output wire [31:0] PRDATA,
    output wire IRQ,
    output wire PREADY,

    input wire [31:0] aux_in,

    inout wire [31:0] io_pad,
    input wire ext_clk_pad_i
);

  wire [31:0] gpio_dat_o;
  wire [31:0] gpio_dat_i;
  wire gpio_inta_o;
  wire [31:0] gpio_addr;
  wire gpio_we;
  wire sys_rst;
  wire sys_clk;

  apb_if if_instance (
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
      .sys_clk(sys_clk),
      .sys_rst(sys_rst),
      .gpio_we(gpio_we),
      .gpio_addr(gpio_addr),
      .gpio_dat_i(gpio_dat_i),
      .gpio_dat_o(gpio_dat_o),
      .gpio_int_o(gpio_inta_o)
  );

  wire [31:0] aux_i;
  wire [31:0] out_pad_o;
  wire [31:0] oen_padoe_o;
  wire [31:0] in_pad_i;
  wire gpio_eclk;

  register reg_instance (
      .sys_clk(sys_clk),
      .sys_rst(sys_rst),
      .gpio_we(gpio_we),
      .gpio_dat_o(gpio_dat_o),
      .gpio_addr(gpio_addr),
      .gpio_dat_i(gpio_dat_i),
      .gpio_inta_o(gpio_inta_o),
      .aux_i(aux_i),
      .out_pad_o(out_pad_o),
      .oen_padoe_o(oen_padoe_o),
      .in_pad_i(in_pad_i),
      .gpio_eclk(gpio_eclk)
  );

  aux_if aux_instance (
      .sys_clk(sys_clk),
      .aux_in (aux_in),
      .sys_rst(sys_rst),
      .aux_i  (aux_i)
  );

  apb_io io_instance (
      .out_pad(out_pad_o),
      .in_pad(in_pad_i),
      .io_pad(io_pad),
      .oen_padoe(oen_padoe_o),
      .ext_clk_pad_i(ext_clk_pad_i),
      .gpio_eclk(gpio_eclk)
  );

endmodule
