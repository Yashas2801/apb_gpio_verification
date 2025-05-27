class apb_xtn extends uvm_sequence_item;
  `uvm_object_utils(apb_xtn)

  rand bit PRESETn;
  bit PSEL;
  rand bit PENABLE;
  rand bit PWRITE;
  bit PREADY;
  rand bit [31:0] PADDR;
  rand bit [31:0] PWDATA;
  bit [31:0] PRDATA;
  bit IRQ;

  extern function new(string name = "apb_xtn");
  extern function void do_print(uvm_printer printer);
endclass

function apb_xtn::new(string name = "apb_xtn");
  super.new(name);
endfunction

function void apb_xtn::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field("PRESETn", this.PRESETn, 1, UVM_BIN);
  printer.print_field("PSEL", this.PSEL, 1, UVM_BIN);
  printer.print_field("PENABLE", this.PENABLE, 1, UVM_BIN);
  printer.print_field("PWRITE", this.PWRITE, 1, UVM_BIN);
  printer.print_field("PADDR", this.PADDR, 32, UVM_HEX);
  printer.print_field("PWDATA", this.PWDATA, 32, UVM_HEX);
  printer.print_field("PRDATA", this.PRDATA, 32, UVM_HEX);
  printer.print_field("PREADY", this.PREADY, 1, UVM_BIN);
  printer.print_field("IRQ", this.IRQ, 1, UVM_BIN);
endfunction


