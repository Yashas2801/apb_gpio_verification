class apb_sequencer extends apb_sequencer #(apb_sequencer);
  `uvm_component_utils(apb_sequencer)
  extern function new(string name, uvm_component parent);
endclass

function apb_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
