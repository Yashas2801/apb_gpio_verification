class virtual_seqs_base extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(virtual_seqs_base)

  env_config e_cfg;
  virtual_sequencer vseqrh;

  apb_sequencer apb_seqrh;
  aux_sequencer aux_seqrh;
  io_sequencer io_seqrh;

  extern function new(string name = "virtual_seqs_base");
  extern task body;
endclass

function virtual_seqs_base::new(string name = "virtual_seqs_base");
  super.new(name);
endfunction

task virtual_seqs_base::body;
	if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	`uvm_fatal(get_type_name,"failed to get e_cfg in v_seqs")
	
	assert($cast(vseqrh, m_sequencer));
	else `uvm_error(get_type_name,"error while asserting m_seqr")

	apb_seqrh = vseqrh.apb_seqrh; 	
	io_seqrh = io.apb_seqrh; 	
	aux_seqrh = aux.apb_seqrh; 	
endtask
