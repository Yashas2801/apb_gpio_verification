class apb_sequencer extends uvm_sequencer #(apb_xtn);
  `uvm_component_utils(apb_sequencer)
  extern function new(string name, uvm_component parent);
endclass

function apb_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
