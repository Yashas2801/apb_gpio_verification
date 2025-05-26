class io_sequencer extends io_sequencer #(io_sequencer);
  `uvm_component_utils(io_sequencer)
  extern function new(string name, uvm_component parent);
endclass

function io_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
