`define GPIO_RGPIO_IN 32'h0
`define GPIO_RGPIO_OUT 32'h4
`define GPIO_RGPIO_OE 32'h8
`define GPIO_RGPIO_INTE 32'hc
`define GPIO_RGPIO_PTRIG 32'h10
`define GPIO_RGPIO_AUX 32'h14
`define GPIO_RGPIO_CTRL 32'h18
`define GPIO_RGPIO_INTS 32'h1c
`define GPIO_RGPIO_ECLK 32'h20
`define GPIO_RGPIO_NEC 32'h24

`define GPIO_RGPIO_CTRL_INTE 1'b0
`define GPIO_RGPIO_CTRL_INTS 1'b1


module register (
    input wire sys_clk,
    input wire gpio_eclk,
    input wire sys_rst,
    input wire [31:0] gpio_dat_i,
    input wire [31:0] gpio_addr,
    input wire gpio_we,
    input wire [31:0] in_pad_i,
    input wire [31:0] aux_i,

    output wire [31:0] out_pad_o,
    output reg gpio_inta_o,
    output reg [31:0] gpio_dat_o,
    output wire [31:0] oen_padoe_o
);

  reg [31:0] rgpio_aux;

  reg [31:0] rgpio_out;

  reg [31:0] rgpio_oe;

  reg [31:0] rgpio_inte;

  reg [31:0] rgpio_ptrig;

  reg [31:0] rgpio_eclk;

  reg [31:0] rgpio_nec;

  reg [ 1:0] rgpio_ctrl;

  reg [31:0] rgpio_in;

  reg [31:0] rgpio_ints;



  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_out <= 32'h0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_OUT)) begin
      rgpio_out <= gpio_dat_i;
    end else begin
      rgpio_out <= rgpio_out;
    end
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_inte <= 32'h0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_INTE)) begin
      rgpio_inte <= gpio_dat_i;
    end else begin
      rgpio_inte <= rgpio_inte;
    end
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_oe <= 32'h0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_OE)) begin
      rgpio_oe <= gpio_dat_i;
    end else begin
      rgpio_oe <= rgpio_oe;
    end
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_ptrig <= 32'h0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_PTRIG)) begin
      rgpio_ptrig <= gpio_dat_i;
    end else begin
      rgpio_ptrig <= rgpio_ptrig;
    end
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_aux <= 32'h0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_AUX)) begin
      rgpio_aux <= gpio_dat_i;
    end else begin
      rgpio_aux <= rgpio_aux;
    end
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_eclk <= 32'h0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_ECLK)) begin
      rgpio_eclk <= gpio_dat_i;
    end else begin
      rgpio_eclk <= rgpio_eclk;
    end
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_nec <= 32'h0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_NEC)) begin
      rgpio_nec <= gpio_dat_i;
    end else rgpio_nec <= rgpio_nec;
  end

  /*
  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_ctrl <= 2'b0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_CTRL)) begin
      rgpio_ctrl <= gpio_dat_i[1:0];
    end else begin
      if (rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE]) begin
        rgpio_ctrl <= rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] | gpio_inta_o;
      end else begin
        rgpio_ctrl <= rgpio_ctrl;
      end
    end
  end
*/

  /*
  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) rgpio_ctrl <= 2'b0;

    else if (gpio_we && (gpio_addr == `GPIO_RGPIO_CTRL)) begin
      rgpio_ctrl <= gpio_dat_i[1:0];
    end else begin
      if (rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE] && |rgpio_ints) begin
        rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] <= 1'b1;
        rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE] <= rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE];
      end
    end
  end
  */
 //working
  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) begin
      rgpio_ctrl <= 2'b0;
    end else if (gpio_we && (gpio_addr == `GPIO_RGPIO_CTRL)) begin
      rgpio_ctrl <= gpio_dat_i[1:0];
    end else if (rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE]) begin
      if (|rgpio_ints) begin
        rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] <= 1'b1;
      end else begin
        rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] <= 1'b0;
      end
      rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE] <= rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE];
    end
  end
  /*
  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) begin
      rgpio_ctrl <= 2'b0;
    end else if (gpio_addr == `GPIO_RGPIO_CTRL && gpio_we) begin
      rgpio_ctrl <= gpio_dat_i[1:0];
    end else if (rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE]) begin
      rgpio_ctrl <= {
        rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE], rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] | gpio_inta_o
      };
    end else rgpio_ctrl <= rgpio_ctrl;
  end
  */
/*
 //chethana logic
  always@(posedge sys_clk or negedge sys_rst)begin
    if(~sys_rst)begin
      rgpio_ctrl <= 2'b0;
    end
    else if(gpio_addr == `GPIO_RGPIO_CTRL && gpio_we)begin
      rgpio_ctrl <= gpio_dat_i[1:0];
    end
    else if(`GPIO_RGPIO_CTRL_INTE)begin
      rgpio_ctrl <= {rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] | gpio_inta_o , rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE]};
    end
    else begin
      rgpio_ctrl <= rgpio_ctrl;
    end
  end
*/
  //RGPIO_IN
  reg [31:0] pextc_sampled;
  reg [31:0] nextc_sampled;
  reg [31:0] extc_in;
  reg [31:0] in_mux;

  always @(posedge gpio_eclk or negedge sys_rst) begin
    if (~sys_rst) pextc_sampled <= 'b0;
    else begin
      pextc_sampled <= in_pad_i;
    end
  end

  always @(negedge gpio_eclk or negedge sys_rst) begin
    if (~sys_rst) nextc_sampled <= 'b0;
    else begin
      nextc_sampled <= in_pad_i;
    end
  end

  always @(pextc_sampled, nextc_sampled, in_mux, rgpio_nec) begin
    if (rgpio_nec) begin
      extc_in = nextc_sampled;
    end else begin
      extc_in = pextc_sampled;
    end
  end

  always @(extc_in, in_pad_i, rgpio_eclk) begin
    if (rgpio_eclk) begin
      in_mux = extc_in;
    end else begin
      in_mux = in_pad_i;
    end
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) begin
      rgpio_in <= 'b0;
    end else begin
      rgpio_in <= in_mux;
    end
  end

  //rgpio_ints

  wire [31:0] a;
  wire [31:0] b;
  wire [31:0] c;
  wire [31:0] d;
  wire [31:0] e;
  wire [31:0] f;

  assign a = rgpio_in ^ in_mux;
  assign b = rgpio_ptrig ~^ in_mux;
  assign c = a & b & rgpio_inte;
  assign d = c | rgpio_ints;
  assign e = (rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE]) ? d : rgpio_ints;
  assign f = ((gpio_addr == `GPIO_RGPIO_INTS) && gpio_we) ? gpio_dat_i : e;

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) begin
      rgpio_ints <= 'b0;
    end else begin
      rgpio_ints <= f;
    end
  end

  //Mux logic
  //

  reg [31:0] data_reg;
  always @(*) begin
    case (gpio_addr)
      `GPIO_RGPIO_IN: data_reg = rgpio_in;
      `GPIO_RGPIO_OUT: data_reg = rgpio_out;
      `GPIO_RGPIO_OE: data_reg = rgpio_oe;
      `GPIO_RGPIO_INTE: data_reg = rgpio_inte;
      `GPIO_RGPIO_PTRIG: data_reg = rgpio_ptrig;
      `GPIO_RGPIO_AUX: data_reg = rgpio_aux;
      `GPIO_RGPIO_CTRL: data_reg = {30'b0, rgpio_ctrl};
      `GPIO_RGPIO_INTS: data_reg = rgpio_ints;
      `GPIO_RGPIO_ECLK: data_reg = rgpio_eclk;
      `GPIO_RGPIO_NEC: data_reg = rgpio_nec;
      default: data_reg = 32'b0;
    endcase
  end

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) begin
      gpio_dat_o <= 32'b0;
    end else begin
      gpio_dat_o <= data_reg;
    end
  end

  //gpio_into_o logic

  always @(*) begin
    gpio_inta_o = (|rgpio_ints) ? rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE] : 1'b0;
  end
  //out_pad_o

  wire [31:0] w1;
  wire [31:0] w2;
  assign w1 = rgpio_out & ~rgpio_aux;
  assign w2 = aux_i & rgpio_aux;
  assign out_pad_o = w1 | w2;

  //oen_padoe_o
  assign oen_padoe_o = rgpio_oe;

endmodule
