class io_xtn extends uvm_sequence_item;
  `uvm_object_utils(io_xtn)

  rand bit [31:0] io_pad;
  rand bit [31:0] io_dir;
  bit [1:0] test_var;

  extern function new(string name = "io_xtn");
  extern function void do_print(uvm_printer printer);
endclass

function io_xtn::new(string name = "io_xtn");
  super.new(name);
endfunction

function void io_xtn::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field("io_pad", this.io_pad, 32, UVM_HEX);
  printer.print_field("io_dir", this.io_dir, 32, UVM_HEX);
  printer.print_field("test_var", this.test_var, 2, UVM_BIN);
endfunction
