class virtual_sequencer extends uvm_sequencer;
	`uvm_component_utils(virtual_sequencer)

	apb_sequencer apb_seqrh;
	io_sequencer io_seqrh;
	aux_sequencer aux_seqrh;

	extern function new(string name, uvm_component parent);
endclass

function virtual_sequencer::new(string name, uvm_component parent);
	super.new(name,parent);
endfunction
