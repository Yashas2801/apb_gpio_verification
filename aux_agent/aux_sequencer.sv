class aux_sequencer extends uvm_sequencer #(aux_xtn);
  `uvm_component_utils(aux_sequencer)
  extern function new(string name, uvm_component parent);
endclass

function aux_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
