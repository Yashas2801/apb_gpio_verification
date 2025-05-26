class aux_sequence_base extends uvm_sequence #(aux_xtn);
	`uvm_object_utils(aux_sequence_base)
	
	env_config e_cfg;

	extern function new(string name = "aux_sequence_base");
	extern task body;
endclass

function aux_sequence::new(string name = "aux_sequence_base");
	super.new(name);
endfunction

task aux_sequence::body();
	`uvm_info(get_type_name,"In the body of aux_seq_base",UVM_LOW)
	if(!uvm_config_db#(env_config)::get(null,get_full_name,"env_config",e_cfg))
	`uvm_fatal(get_type_name,"failed to get env_config in aux_seqs")
endtask
