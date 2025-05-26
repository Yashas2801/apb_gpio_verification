module aux_if (
    input wire sys_clk,
    input wire [31:0] aux_in,
    input wire sys_rst,

    output wire [31:0] aux_i
);

  aux_reg i1 (
      .sys_clk(sys_clk),
      .aux_in (aux_in),
      .aux_i  (aux_i),
      .sys_rst(sys_rst)
  );


endmodule
