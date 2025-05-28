class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo #(apb_xtn) apb_fifo;
	uvm_tlm_analysis_fifo #(aux_xtn) aux_fifo;
	uvm_tlm_analysis_fifo #(io_xtn) io_fifo;

  extern function new(string name, uvm_component parent);
endclass

function scoreboard::new(string name, uvm_component parent);
  super.new(name, parent);
  apb_fifo = new("apb_fifo",this);
  aux_fifo = new("aux_fifo",this);
  io_fifo = new("io_fifo",this);
endfunction
