module aux_reg (
    input wire sys_clk,
    input wire [31:0] aux_in,
    input wire sys_rst,

    output reg [31:0] aux_i
);

  always @(posedge sys_clk or negedge sys_rst) begin
    if (~sys_rst) begin
      aux_i <= 32'b0;
    end else begin
      aux_i <= aux_in;
    end
  end

endmodule
