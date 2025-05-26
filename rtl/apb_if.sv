module apb_if (
    output wire PREADY,
    output wire IRQ,
    output wire sys_clk,
    output wire sys_rst,
    output wire gpio_we,
    output wire [31:0] gpio_addr,
    output reg [31:0] PRDATA,
    output reg [31:0] gpio_dat_i,

    input wire PCLK,
    input wire PRESETn,
    input wire PSEL,
    input wire PENABLE,
    input wire PWRITE,
    input wire [31:0] PWDATA,
    input wire [31:0] PADDR,
    input wire [31:0] gpio_dat_o,
    input wire gpio_int_o
);

  apb_fsm fs1 (
      .PCLK(PCLK),
      .PENABLE(PENABLE),
      .PSEL(PSEL),
      .PRESETn(PRESETn),
      .PREADY(PREADY)
  );

  //write logic 
  always @(*) begin
    if (!PRESETn) begin
      gpio_dat_i <= 'b0;
    end else begin
      if (PWRITE && PREADY) begin
        gpio_dat_i <= PWDATA;
      end else begin
        gpio_dat_i <= 'b0;
      end
    end
  end

  //read logic 
  always @(*) begin
    if (!PRESETn) begin
      PRDATA <= 'b0;
    end else begin
      if (!PWRITE && PREADY) begin
        PRDATA <= gpio_dat_o;
      end else begin
        PRDATA <= 'b0;
      end
    end
  end

  assign sys_clk = PCLK;
  assign sys_rst = PRESETn;
  assign gpio_we = (PREADY && PWRITE) ? 1'b1 : 1'b0;
  assign gpio_addr = PADDR;
  assign IRQ = gpio_int_o;

endmodule
