module apb_fsm (
    input wire PCLK,
    input wire PENABLE,
    input wire PSEL,
    input wire PRESETn,

    output reg PREADY
);

  parameter IDLE = 2'b00;
  parameter SETUP = 2'b01;
  parameter ENABLE = 2'b10;

  reg [1:0] present_state, next_state;

  //present state logic

  always @(posedge PCLK or negedge PRESETn) begin
    if (~PRESETn) begin
      present_state <= IDLE;
    end else begin
      present_state <= next_state;
    end
  end

  // next state logic, comb_logic

  always @(*) begin
    case (present_state)
      IDLE: begin
        if (PSEL && !PENABLE) begin
          next_state = SETUP;
        end else begin
          next_state = IDLE;
        end
      end
      SETUP: begin
        if (PSEL && PENABLE) begin
          next_state = ENABLE;
        end //else if (PSEL && !PENABLE) begin
          //next_state = SETUP;
        //end
         else begin
        next_state = SETUP;
        end
      end
      ENABLE: begin
        if (!PSEL) begin
          next_state = IDLE;
        end else begin
          next_state = SETUP;
        end
      end
      default: begin
        next_state = IDLE;
      end
    endcase
  end
  //output logic
  always @(*) begin
    PREADY = (present_state == ENABLE);
  end
endmodule
