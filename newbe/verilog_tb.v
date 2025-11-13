module alu(
  input wire clk,
  input wire rst,
  input wire [3:0]a,
  input wire [3:0]b,
  input wire [2:0]sel,
  output reg [3:0]y
);

always@(posedge clk or posedge rst)begin
  if(rst)begin
    y <= 4'b0000;
  end
  else begin
    case(sel)
       3'b000: y <= a + b;
       3'b001: y <= a - b;
       3'b010: y <= a * b;
       3'b011: y <= (b == 0) ? 4'b0000: a/b;
       3'b100: y <= a & b;
       3'b101: y <= ~a;
       3'b110: y <= a | b;
       3'b111: y <= a ^ b;
       default: y <= 4'b0000;
    endcase
  end
end

endmodule
module bfm_driver(
  input wire clk,
  input wire rst_in,
  output reg [3:0]a,
  output reg [3:0]b,
  output reg [2:0]sel,
  output wire rst

);
assign rst = rst_in;

initial begin
  a = 4'b0;
  b = 4'b0;
  sel = 3'b0;
end

task drive(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in
);
  begin
    @(negedge clk);
    a = a_in;
    b = b_in;
    sel = sel_in;
    $display("Driving from DRIVER @ %0t | a = %4b b = %4b sel = %3b ",$time,a,b,sel);
  end
endtask


endmodule
module checker1;

function [3:0]ref_val(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in,
  input rst
);
  begin
    if(rst)begin
      ref_val = 4'b0; 
    end
    else begin
        case(sel_in)
      3'b000:begin
         ref_val = a_in + b_in;
       end
       3'b001:begin
         ref_val = a_in - b_in;
       end
       3'b010:begin
         ref_val = a_in * b_in;
       end
       3'b011:begin
         ref_val = (b_in == 0) ? 4'b0000: a_in/b_in;
       end
       3'b100:begin
         ref_val = a_in & b_in;
       end
       3'b101:begin
         ref_val = ~a_in;
       end
       3'b110:begin
         ref_val = a_in | b_in;
       end
       3'b111:begin
         ref_val = a_in ^ b_in;
       end
       default: ref_val = 4'b0000;
    endcase
    end
  end
endfunction

task compare_result(
  input [3:0]expected,
  input [3:0]actual,
  input [3:0]a,
  input [3:0]b,
  input [2:0]sel,
  input rst
  ); 
  begin
    if(expected != actual)begin
      $display("From CHECKER");
      $display("FAIL | Time = %0t |rst = %0b a = %4b b = %4b sel= %3b | Expected = %4b actual = %4b ",$time,rst,a,b,sel,expected,actual);
      $display("--------------------------------------------------------------------");
    end
    else begin
      $display("From CHECKER");
      $display("PASS | Time = %0t |rst = %0b a = %4b b = %4b sel= %3b | Expected = %4b actual = %4b",$time,rst,a,b,sel,expected,actual);
      $display("--------------------------------------------------------------------");
    end
  end
endtask

endmodule
module alu(
  input wire clk,
  input wire rst,
  input wire [3:0]a,
  input wire [3:0]b,
  input wire [2:0]sel,
  output reg [3:0]y
);

always@(posedge clk or posedge rst)begin
  if(rst)begin
    y <= 4'b0000;
  end
  else begin
    case(sel)
       3'b000: y <= a + b;
       3'b001: y <= a - b;
       3'b010: y <= a * b;
       3'b011: y <= (b == 0) ? 4'b0000: a/b;
       3'b100: y <= a & b;
       3'b101: y <= ~a;
       3'b110: y <= a | b;
       3'b111: y <= a ^ b;
       default: y <= 4'b0000;
    endcase
  end
end

endmodule
module bfm_driver(
  input wire clk,
  input wire rst_in,
  output reg [3:0]a,
  output reg [3:0]b,
  output reg [2:0]sel,
  output wire rst

);
assign rst = rst_in;

initial begin
  a = 4'b0;
  b = 4'b0;
  sel = 3'b0;
end

task drive(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in
);
  begin
    @(negedge clk);
    a = a_in;
    b = b_in;
    sel = sel_in;
    $display("Driving from DRIVER @ %0t | a = %4b b = %4b sel = %3b ",$time,a,b,sel);
  end
endtask


endmodule
module checker1;

function [3:0]ref_val(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in,
  input rst
);
  begin
    if(rst)begin
      ref_val = 4'b0; 
    end
    else begin
        case(sel_in)
      3'b000:begin
         ref_val = a_in + b_in;
       end
       3'b001:begin
         ref_val = a_in - b_in;
       end
       3'b010:begin
         ref_val = a_in * b_in;
       end
       3'b011:begin
         ref_val = (b_in == 0) ? 4'b0000: a_in/b_in;
       end
       3'b100:begin
         ref_val = a_in & b_in;
       end
       3'b101:begin
         ref_val = ~a_in;
       end
       3'b110:begin
         ref_val = a_in | b_in;
       end
       3'b111:begin
         ref_val = a_in ^ b_in;
       end
       default: ref_val = 4'b0000;
    endcase
    end
  end
endfunction

task compare_result(
  input [3:0]expected,
  input [3:0]actual,
  input [3:0]a,
  input [3:0]b,
  input [2:0]sel,
  input rst
  ); 
  begin
    if(expected != actual)begin
      $display("From CHECKER");
      $display("FAIL | Time = %0t |rst = %0b a = %4b b = %4b sel= %3b | Expected = %4b actual = %4b ",$time,rst,a,b,sel,expected,actual);
      $display("--------------------------------------------------------------------");
    end
    else begin
      $display("From CHECKER");
      $display("PASS | Time = %0t |rst = %0b a = %4b b = %4b sel= %3b | Expected = %4b actual = %4b",$time,rst,a,b,sel,expected,actual);
      $display("--------------------------------------------------------------------");
    end
  end
endtask

endmodule
module monitor(
  input wire clk,
  input wire [3:0]y,
  input wire [3:0]a,
  input wire [3:0]b,
  input wire [2:0]sel,
  input wire rst,
  output reg [3:0]captured_y,
  output reg [3:0]captured_a,
  output reg [3:0]captured_b,
  output reg [2:0]captured_sel,
  output reg captured_rst,
  output reg xtn_done
);

task init_monitor;
  begin
    captured_y = 0;
    captured_a = 0;
    captured_b = 0;
    captured_sel = 0;
    captured_rst = 0;
    xtn_done = 0;
  end
endtask

task capture_output;
  begin
    @(negedge clk);
    captured_y = y;
    captured_a = a;
    captured_b = b;
    captured_sel = sel;
    captured_rst = rst;
    $display("Monitering in MONITOR @ %0t |rst = %4b a = %4b b = %4b sel = %3b y = %4b ",$time,captured_rst,captured_a,captured_b,captured_sel,captured_y);
    xtn_done = ~xtn_done;// we can trigger the tasks of checker 
  end
endtask

endmodule
module stimulus(
  input wire clk,
  output reg rst,
  output reg [3:0]a,
  output reg [3:0]b,
  output reg [2:0]sel,
  input wire [3:0]y

);

reg [3:0]expected;
reg [13*8 -1:0]operation;

function [3:0]ref_val(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in
);
  begin
        case(sel)
      3'b000:begin
         operation = "Ar Addn";
         ref_val = a + b;
       end
       3'b001:begin
         operation = "Ar Subb"; 
         ref_val = a - b;
       end
       3'b010:begin
         operation = "Ar Mult";
         ref_val = a * b;
       end
       3'b011:begin
         operation = "Ar division";
         ref_val = (b == 0) ? 4'b0000: a/b;
       end
       3'b100:begin
         operation = "AND"; 
         ref_val = a & b;
       end
       3'b101:begin
         operation = "NOT"; 
         ref_val = ~a;
       end
       3'b110:begin
         operation = "OR"; 
         ref_val = a | b;
       end
       3'b111:begin
         operation = "XOR"; 
         ref_val = a ^ b;
       end
       default: ref_val = 4'b0000;
    endcase


  end
endfunction

task drive_and_check(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in
);
  begin
    @(negedge clk); 
    a = a_in;
    b = b_in;
    sel = sel_in;
    expected = ref_val(a_in,b_in,sel_in);
    @(negedge clk);
    if(expected != y)begin
      $display("FAIL_%0s| a = %4b b = %4b sel = %3b y = %4b | expected = %4b",operation,a,b,sel,y,expected);
      end
      else begin 
        $display("PASS_%0s | a = %4b b = %4b sel = %3b y = %4b | expected = %4b",operation,a,b,sel,y,expected);
      end
  end
endtask

initial begin
  rst = 1'b0;
  a = 4'b0;
  b = 4'b0;
  sel = 3'b0;
end

integer i;
initial begin
  #9;
  rst = 1'b1;
  #31;
  rst = 1'b0;
  drive_and_check(4'h5,4'h4,3'b000);
  drive_and_check(4'hA,4'h6,3'b001);
  drive_and_check(4'h5,4'h4,3'b111);
  drive_and_check(4'hF,4'hE,3'b011);
  drive_and_check(4'hB,4'hE,3'b101);

  for(i = 0; i <5;i = i+1)begin
    reg [3:0]a_r;
    reg [3:0]b_r;
    reg [2:0]sel_r;
    a_r = $random%16;
    b_r = $random%16;
    sel_r = $random%8;
    drive_and_check(a_r,b_r,sel_r);
  end
  #30 $finish;
  
end
endmodule
module tb_alu;
  reg clk;
  reg rst;
  reg [3:0]a;
  reg [3:0]b;
  reg [2:0]sel;
  wire [3:0]y;

  alu dut(
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
  );

  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  reg [3:0]expected;
  reg [13*8 -1:0]operation;
  always@(*)begin
    case(sel)
      3'b000:begin
         operation <= "Ar Addn";
         expected <= a + b;
       end
       3'b001:begin
         operation <= "Ar Subb"; 
         expected <= a - b;
       end
       3'b010:begin
         operation <= "Ar Mult";
         expected <= a * b;
       end
       3'b011:begin
         operation <= "Ar division";
         expected <= (b == 0) ? 4'b0000: a/b;
       end
       3'b100:begin
         operation <= "AND"; 
         expected <= a & b;
       end
       3'b101:begin
         operation <= "NOT"; 
         expected <= ~a;
       end
       3'b110:begin
         operation <= "OR"; 
         expected <= a | b;
       end
       3'b111:begin
         operation <= "XOR"; 
         expected <= a ^ b;
       end
       default: expected <= 4'b0000;
    endcase

  end

  task check(
    input [3:0]a1,
    input [3:0]b1,
    input [2:0]sel1
    );
    begin
      @(negedge clk);
      $display("Check task invoked");
      a = a1;
      b = b1;
      sel = sel1;
      @(negedge clk);
      if(expected != y)begin
        $display("FAIL | y = %4b | expected = %4b",y,expected);
      end
        else $display("PASS");
    end
  endtask
  initial begin
    $monitor("rst = %0b | a = %4b | b = %4b | sel = %3b | operation = %0s | y = %4b ",rst,a,b,sel,operation,y);
  end

  initial begin
    rst = 1'b0;
    a = 4'b0;
    b = 4'b0;
    sel = 3'b0;
  end

  initial begin
    #9;
    rst = 1'b1;
    #27;
    rst = 1'b0;
    check(4'b1010,4'b1111,3'b000);
    check(4'b1111,4'b1111,3'b001);
    check(4'b1010,4'b1111,3'b010);
    check(4'b1010,4'b1111,3'b011);
    check(4'b1010,4'b1111,3'b100);
    check(4'b1010,4'b1111,3'b101);
    check(4'b1010,4'b1111,3'b110);
    check(4'b1010,4'b1111,3'b111);
    check(4'b1010,4'b1011,3'b000);
    check(4'b1111,4'b1001,3'b001);
    #20 $finish;
  end
endmodule
module tb_top;
 reg clk;

 initial begin
   clk = 1'b0;
   forever #10 clk = ~clk;
 end

 wire rst_con;
 wire [3:0]a_con;
 wire [3:0]b_con;
 wire [2:0]sel_con;
 wire [3:0]y_con;

alu dut(
  .clk(clk),
  .rst(rst_con),
  .a(a_con),
  .b(b_con),
  .sel(sel_con),
  .y(y_con)
);

stimulus st1(
  .clk(clk),
  .rst(rst_con),
  .a(a_con),
  .b(b_con),
  .sel(sel_con),
  .y(y_con)
);

endmodule
module testcase(
  input wire clk,
  output reg rst
);

task run_directed;
  begin
    @(negedge clk);
    rst = 1;
    repeat(2) @(negedge clk);
    rst = 0;
    //addn
    top.driver_inst.drive(4'd5,4'd3,3'b000);
    top.monitor_inst.capture_output;
    @(negedge clk);
    //sub
    top.driver_inst.drive(4'hA,4'h7,3'b001);
    top.monitor_inst.capture_output;
    //mul
    top.driver_inst.drive(4'h3,4'h4,3'b010);
    top.monitor_inst.capture_output;
    //div
    top.driver_inst.drive(4'hF,4'h3,3'b011);
    top.monitor_inst.capture_output;
    //and
    top.driver_inst.drive(4'b1111,4'b1010,3'b100);
    top.monitor_inst.capture_output;
    //not
    top.driver_inst.drive(4'b1100,4'b0011,3'b101);
    top.monitor_inst.capture_output;
    //or
    top.driver_inst.drive(4'b1010,4'b0101,3'b011);
    top.monitor_inst.capture_output;
    //xor
    top.driver_inst.drive(4'b1111,4'b1010,3'b011);
    top.monitor_inst.capture_output;
    
  end
endtask

task run_random;
  integer i;
  reg [3:0]a;
  reg [3:0]b;
 
begin
  a = 4'b1100;
  b = 4'b1010;
  @(negedge clk);
  rst = 1;
  repeat(2) @(negedge clk);
  rst = 0;
    
  //Random operations
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive(a, b, $random%8);
    top.monitor_inst.capture_output;
  end

  //Randomize a and b , operation => multiplication
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, 3'b010);
    top.monitor_inst.capture_output;
  end

  
  //Randomize a and b , operation => subtraction
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, 3'b001);
    top.monitor_inst.capture_output;
  end

  //random a,b,sel
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, $random%8);
    top.monitor_inst.capture_output;
  end

  //random reset
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, $random%8);
    //after the inputs are driven at next negedge, rst is randomized at next
    //posedge
    @(posedge clk);
    rst = $random%2;
    //eather the operation will succeed or the output will be 0 due to
    //assertion of rst
    @(negedge clk);
    top.monitor_inst.capture_output;
  end
  #20;
end

endtask


task run_corner;
  begin
    @(negedge clk);
    rst = 1;
    repeat(2) @(negedge clk);
    rst = 0;
    //Max value for Addn
    top.driver_inst.drive(4'hF,4'hF,3'b000);
    top.monitor_inst.capture_output;
    
    //Min value for sub
    top.driver_inst.drive(4'h0,4'hF,3'b001);
    top.monitor_inst.capture_output;

    //divide by 0
    top.driver_inst.drive(4'hA,4'h0,3'b011);
    top.monitor_inst.capture_output;

    //Multiplication overflow
    top.driver_inst.drive(4'hF,4'hF,3'b010);
    top.monitor_inst.capture_output;

    //NOT operation of 0
    top.driver_inst.drive(4'h0,4'hA,3'b101);
    top.monitor_inst.capture_output;

  end
endtask

endmodule
module top;

  reg clk;
  wire rst;
  wire [3:0]y;
  wire [3:0]dut_a;
  wire [3:0]dut_b;
  wire [2:0]dut_sel;
  wire dut_rst;
  wire [3:0]captured_y;
  wire [3:0]captured_a;
  wire [3:0]captured_b;
  wire [2:0]captured_sel;
  wire captured_rst;
  wire xtn_done;
  reg [3:0]expected;
  
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
 
  alu alu_inst(
    .clk(clk),
    .rst(dut_rst),
    .a(dut_a),
    .b(dut_b),
    .sel(dut_sel),
    .y(y)
  );

  bfm_driver driver_inst(
    .clk(clk),
    .rst_in(rst),
    .a(dut_a),
    .b(dut_b),
    .sel(dut_sel),
    .rst(dut_rst)
  );

  monitor monitor_inst(
    .clk(clk),
    .y(y),
    .a(dut_a),
    .b(dut_b),
    .sel(dut_sel),
    .rst(dut_rst),
    .captured_y(captured_y),
    .captured_a(captured_a),
    .captured_b(captured_b),
    .captured_sel(captured_sel),
    .captured_rst(captured_rst),
    .xtn_done(xtn_done)
  );

  testcase testcase_inst(
    .clk(clk),
    .rst(rst)
  );

  checker1 checker_inst();
 
  initial begin
    monitor_inst.init_monitor;
    if($test$plusargs("DIRECTED"))begin
      testcase_inst.run_directed;
    end
    else if($test$plusargs("CORNER"))begin
      testcase_inst.run_corner;
    end
    else if($test$plusargs("RANDOM"))begin
      testcase_inst.run_random;
    end
    else begin
      testcase_inst.run_directed;
    end
    #20 $finish;
  end

  always@(xtn_done)begin
    #2;
    expected = checker_inst.ref_val(captured_a,captured_b,captured_sel,captured_rst); 
    checker_inst.compare_result(expected,captured_y,captured_a,captured_b,captured_sel,captured_rst);
  end
endmodule
module monitor(
  input wire clk,
  input wire [3:0]y,
  input wire [3:0]a,
  input wire [3:0]b,
  input wire [2:0]sel,
  input wire rst,
  output reg [3:0]captured_y,
  output reg [3:0]captured_a,
  output reg [3:0]captured_b,
  output reg [2:0]captured_sel,
  output reg captured_rst,
  output reg xtn_done
);

task init_monitor;
  begin
    captured_y = 0;
    captured_a = 0;
    captured_b = 0;
    captured_sel = 0;
    captured_rst = 0;
    xtn_done = 0;
  end
endtask

task capture_output;
  begin
    @(negedge clk);
    captured_y = y;
    captured_a = a;
    captured_b = b;
    captured_sel = sel;
    captured_rst = rst;
    $display("Monitering in MONITOR @ %0t |rst = %4b a = %4b b = %4b sel = %3b y = %4b ",$time,captured_rst,captured_a,captured_b,captured_sel,captured_y);
    xtn_done = ~xtn_done;// we can trigger the tasks of checker 
  end
endtask

endmodule
module stimulus(
  input wire clk,
  output reg rst,
  output reg [3:0]a,
  output reg [3:0]b,
  output reg [2:0]sel,
  input wire [3:0]y

);

reg [3:0]expected;
reg [13*8 -1:0]operation;

function [3:0]ref_val(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in
);
  begin
        case(sel)
      3'b000:begin
         operation = "Ar Addn";
         ref_val = a + b;
       end
       3'b001:begin
         operation = "Ar Subb"; 
         ref_val = a - b;
       end
       3'b010:begin
         operation = "Ar Mult";
         ref_val = a * b;
       end
       3'b011:begin
         operation = "Ar division";
         ref_val = (b == 0) ? 4'b0000: a/b;
       end
       3'b100:begin
         operation = "AND"; 
         ref_val = a & b;
       end
       3'b101:begin
         operation = "NOT"; 
         ref_val = ~a;
       end
       3'b110:begin
         operation = "OR"; 
         ref_val = a | b;
       end
       3'b111:begin
         operation = "XOR"; 
         ref_val = a ^ b;
       end
       default: ref_val = 4'b0000;
    endcase


  end
endfunction

task drive_and_check(
  input [3:0]a_in,
  input [3:0]b_in,
  input [2:0]sel_in
);
  begin
    @(negedge clk); 
    a = a_in;
    b = b_in;
    sel = sel_in;
    expected = ref_val(a_in,b_in,sel_in);
    @(negedge clk);
    if(expected != y)begin
      $display("FAIL_%0s| a = %4b b = %4b sel = %3b y = %4b | expected = %4b",operation,a,b,sel,y,expected);
      end
      else begin 
        $display("PASS_%0s | a = %4b b = %4b sel = %3b y = %4b | expected = %4b",operation,a,b,sel,y,expected);
      end
  end
endtask

initial begin
  rst = 1'b0;
  a = 4'b0;
  b = 4'b0;
  sel = 3'b0;
end

integer i;
initial begin
  #9;
  rst = 1'b1;
  #31;
  rst = 1'b0;
  drive_and_check(4'h5,4'h4,3'b000);
  drive_and_check(4'hA,4'h6,3'b001);
  drive_and_check(4'h5,4'h4,3'b111);
  drive_and_check(4'hF,4'hE,3'b011);
  drive_and_check(4'hB,4'hE,3'b101);

  for(i = 0; i <5;i = i+1)begin
    reg [3:0]a_r;
    reg [3:0]b_r;
    reg [2:0]sel_r;
    a_r = $random%16;
    b_r = $random%16;
    sel_r = $random%8;
    drive_and_check(a_r,b_r,sel_r);
  end
  #30 $finish;
  
end
endmodule
module tb_alu;
  reg clk;
  reg rst;
  reg [3:0]a;
  reg [3:0]b;
  reg [2:0]sel;
  wire [3:0]y;

  alu dut(
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
  );

  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  reg [3:0]expected;
  reg [13*8 -1:0]operation;
  always@(*)begin
    case(sel)
      3'b000:begin
         operation <= "Ar Addn";
         expected <= a + b;
       end
       3'b001:begin
         operation <= "Ar Subb"; 
         expected <= a - b;
       end
       3'b010:begin
         operation <= "Ar Mult";
         expected <= a * b;
       end
       3'b011:begin
         operation <= "Ar division";
         expected <= (b == 0) ? 4'b0000: a/b;
       end
       3'b100:begin
         operation <= "AND"; 
         expected <= a & b;
       end
       3'b101:begin
         operation <= "NOT"; 
         expected <= ~a;
       end
       3'b110:begin
         operation <= "OR"; 
         expected <= a | b;
       end
       3'b111:begin
         operation <= "XOR"; 
         expected <= a ^ b;
       end
       default: expected <= 4'b0000;
    endcase

  end

  task check(
    input [3:0]a1,
    input [3:0]b1,
    input [2:0]sel1
    );
    begin
      @(negedge clk);
      $display("Check task invoked");
      a = a1;
      b = b1;
      sel = sel1;
      @(negedge clk);
      if(expected != y)begin
        $display("FAIL | y = %4b | expected = %4b",y,expected);
      end
        else $display("PASS");
    end
  endtask
  initial begin
    $monitor("rst = %0b | a = %4b | b = %4b | sel = %3b | operation = %0s | y = %4b ",rst,a,b,sel,operation,y);
  end

  initial begin
    rst = 1'b0;
    a = 4'b0;
    b = 4'b0;
    sel = 3'b0;
  end

  initial begin
    #9;
    rst = 1'b1;
    #27;
    rst = 1'b0;
    check(4'b1010,4'b1111,3'b000);
    check(4'b1111,4'b1111,3'b001);
    check(4'b1010,4'b1111,3'b010);
    check(4'b1010,4'b1111,3'b011);
    check(4'b1010,4'b1111,3'b100);
    check(4'b1010,4'b1111,3'b101);
    check(4'b1010,4'b1111,3'b110);
    check(4'b1010,4'b1111,3'b111);
    check(4'b1010,4'b1011,3'b000);
    check(4'b1111,4'b1001,3'b001);
    #20 $finish;
  end
endmodule
module tb_top;
 reg clk;

 initial begin
   clk = 1'b0;
   forever #10 clk = ~clk;
 end

 wire rst_con;
 wire [3:0]a_con;
 wire [3:0]b_con;
 wire [2:0]sel_con;
 wire [3:0]y_con;

alu dut(
  .clk(clk),
  .rst(rst_con),
  .a(a_con),
  .b(b_con),
  .sel(sel_con),
  .y(y_con)
);

stimulus st1(
  .clk(clk),
  .rst(rst_con),
  .a(a_con),
  .b(b_con),
  .sel(sel_con),
  .y(y_con)
);

endmodule
module testcase(
  input wire clk,
  output reg rst
);

task run_directed;
  begin
    @(negedge clk);
    rst = 1;
    repeat(2) @(negedge clk);
    rst = 0;
    //addn
    top.driver_inst.drive(4'd5,4'd3,3'b000);
    top.monitor_inst.capture_output;
    @(negedge clk);
    //sub
    top.driver_inst.drive(4'hA,4'h7,3'b001);
    top.monitor_inst.capture_output;
    //mul
    top.driver_inst.drive(4'h3,4'h4,3'b010);
    top.monitor_inst.capture_output;
    //div
    top.driver_inst.drive(4'hF,4'h3,3'b011);
    top.monitor_inst.capture_output;
    //and
    top.driver_inst.drive(4'b1111,4'b1010,3'b100);
    top.monitor_inst.capture_output;
    //not
    top.driver_inst.drive(4'b1100,4'b0011,3'b101);
    top.monitor_inst.capture_output;
    //or
    top.driver_inst.drive(4'b1010,4'b0101,3'b011);
    top.monitor_inst.capture_output;
    //xor
    top.driver_inst.drive(4'b1111,4'b1010,3'b011);
    top.monitor_inst.capture_output;
    
  end
endtask

task run_random;
  integer i;
  reg [3:0]a;
  reg [3:0]b;
 
begin
  a = 4'b1100;
  b = 4'b1010;
  @(negedge clk);
  rst = 1;
  repeat(2) @(negedge clk);
  rst = 0;
    
  //Random operations
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive(a, b, $random%8);
    top.monitor_inst.capture_output;
  end

  //Randomize a and b , operation => multiplication
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, 3'b010);
    top.monitor_inst.capture_output;
  end

  
  //Randomize a and b , operation => subtraction
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, 3'b001);
    top.monitor_inst.capture_output;
  end

  //random a,b,sel
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, $random%8);
    top.monitor_inst.capture_output;
  end

  //random reset
  for(i = 0;i < 5 ;i = i+1)begin
    top.driver_inst.drive($random%16, $random%16, $random%8);
    //after the inputs are driven at next negedge, rst is randomized at next
    //posedge
    @(posedge clk);
    rst = $random%2;
    //eather the operation will succeed or the output will be 0 due to
    //assertion of rst
    @(negedge clk);
    top.monitor_inst.capture_output;
  end
  #20;
end

endtask


task run_corner;
  begin
    @(negedge clk);
    rst = 1;
    repeat(2) @(negedge clk);
    rst = 0;
    //Max value for Addn
    top.driver_inst.drive(4'hF,4'hF,3'b000);
    top.monitor_inst.capture_output;
    
    //Min value for sub
    top.driver_inst.drive(4'h0,4'hF,3'b001);
    top.monitor_inst.capture_output;

    //divide by 0
    top.driver_inst.drive(4'hA,4'h0,3'b011);
    top.monitor_inst.capture_output;

    //Multiplication overflow
    top.driver_inst.drive(4'hF,4'hF,3'b010);
    top.monitor_inst.capture_output;

    //NOT operation of 0
    top.driver_inst.drive(4'h0,4'hA,3'b101);
    top.monitor_inst.capture_output;

  end
endtask

endmodule
module top;

  reg clk;
  wire rst;
  wire [3:0]y;
  wire [3:0]dut_a;
  wire [3:0]dut_b;
  wire [2:0]dut_sel;
  wire dut_rst;
  wire [3:0]captured_y;
  wire [3:0]captured_a;
  wire [3:0]captured_b;
  wire [2:0]captured_sel;
  wire captured_rst;
  wire xtn_done;
  reg [3:0]expected;
  
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
 
  alu alu_inst(
    .clk(clk),
    .rst(dut_rst),
    .a(dut_a),
    .b(dut_b),
    .sel(dut_sel),
    .y(y)
  );

  bfm_driver driver_inst(
    .clk(clk),
    .rst_in(rst),
    .a(dut_a),
    .b(dut_b),
    .sel(dut_sel),
    .rst(dut_rst)
  );

  monitor monitor_inst(
    .clk(clk),
    .y(y),
    .a(dut_a),
    .b(dut_b),
    .sel(dut_sel),
    .rst(dut_rst),
    .captured_y(captured_y),
    .captured_a(captured_a),
    .captured_b(captured_b),
    .captured_sel(captured_sel),
    .captured_rst(captured_rst),
    .xtn_done(xtn_done)
  );

  testcase testcase_inst(
    .clk(clk),
    .rst(rst)
  );

  checker1 checker_inst();
 
  initial begin
    monitor_inst.init_monitor;
    if($test$plusargs("DIRECTED"))begin
      testcase_inst.run_directed;
    end
    else if($test$plusargs("CORNER"))begin
      testcase_inst.run_corner;
    end
    else if($test$plusargs("RANDOM"))begin
      testcase_inst.run_random;
    end
    else begin
      testcase_inst.run_directed;
    end
    #20 $finish;
  end

  always@(xtn_done)begin
    #2;
    expected = checker_inst.ref_val(captured_a,captured_b,captured_sel,captured_rst); 
    checker_inst.compare_result(expected,captured_y,captured_a,captured_b,captured_sel,captured_rst);
  end
endmodule
