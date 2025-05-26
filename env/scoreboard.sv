class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  extern function new(string name, uvm_component parent);
endclass

function scoreboard::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
