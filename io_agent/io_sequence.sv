class io_sequence_base extends uvm_sequence #(io_xtn);
  `uvm_object_utils(io_sequence_base)

  env_config e_cfg;

  extern function new(string name = "io_sequence_base");
  extern task body;
endclass

function io_sequence::new(string name = "io_sequence_base");
  super.new(name);
endfunction

task io_sequence::body();
  `uvm_info(get_type_name, "In the body of io_seq_base", UVM_LOW)
  if (!uvm_config_db#(env_config)::get(null, get_full_name, "env_config", e_cfg))
    `uvm_fatal(get_type_name, "failed to get env_config in io_seqs")
endtask
