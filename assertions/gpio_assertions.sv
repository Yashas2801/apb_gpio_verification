module gpio_assertions (
    input bit PCLK,
    input bit PRESETn,
    input bit PSEL,
    input bit PENABLE,
    input bit PWRITE,
    input bit PREADY,
    input bit [31:0] PADDR,
    input bit [31:0] PWDATA
);

  property p1;
    @(posedge PCLK) disable iff (~PRESETn) (!PENABLE && PSEL) |=> $stable(
        PSEL
    );
  endproperty


  property p2;
    @(posedge PCLK) disable iff (~PRESETn) (PENABLE) |-> (PSEL);
  endproperty

  property p3;
    @(posedge PCLK) disable iff (~PRESETn) (PREADY) |-> $stable(
        PWRITE
    );
  endproperty

  property p4;
    @(posedge PCLK) disable iff (~PRESETn) (PREADY) |-> $stable(
        PADDR
    );
  endproperty

  property p5;
    @(posedge PCLK) disable iff (~PRESETn) (PREADY) |-> $stable(
        PWDATA
    );
  endproperty

  property p6;
    @(posedge PCLK) disable iff (~PRESETn) (PREADY) |=> !PENABLE;
  endproperty

  property p7;
    @(posedge PCLK) disable iff (~PRESETn) (!PSEL) && (!PENABLE) |-> !PREADY;
  endproperty

  property p8;
    @(posedge PCLK) disable iff (~PRESETn) PENABLE |-> ~$past(
        PREADY, 1
    );
  endproperty

  P1 :
  assert property (p1) $display("assertion pass for p1");
  else $display("assertion fail for p1");

  P2 :
  assert property (p2) $display("assertion pass for p2");
  else $display("assertion fail for p2");

  P3 :
  assert property (p3) $display("assertion pass for p3");
  else $display("assertion fail for p3");

  P4 :
  assert property (p4) $display("assertion pass for p4");
  else $display("assertion fail for p4");

  P5 :
  assert property (p5) $display("assertion pass for p5");
  else $display("assertion fail for p5");

  P6 :
  assert property (p6) $display("assertion pass for p6");
  else $display("assertion fail for p6");

  P7 :
  assert property (p7) $display("assertion pass for p7");
  else $display("assertion fail for p7");

  P8 :
  assert property (p8) $display("assertion pass for p8");
  else $display("assertion fail for p8");

  C1 :
  cover property (p1);
  C2 :
  cover property (p2);
  C3 :
  cover property (p3);
  C4 :
  cover property (p4);
  C5 :
  cover property (p5);
  C6 :
  cover property (p6);
  C7 :
  cover property (p7);
  C8 :
  cover property (p8);




endmodule
