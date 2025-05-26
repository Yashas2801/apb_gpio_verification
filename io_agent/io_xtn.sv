class io_xtn extends uvm_sequence_item;
  `uvm_object_utils(io_xtn)

  rand bit [31:0] io_pad;

  extern function new(string name = "io_xtn");
  extern function void do_print(uvm_printer printer);
endclass

function io_xtn::new(string name = "io_xtn");
  super.new(name);
endfunction

function void io_xtn::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field("io_pad", this.io_pad, 32, UVM_HEX);
endfunction
