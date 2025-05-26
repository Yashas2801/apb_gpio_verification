class env_config extends uvm_object;
  `uvm_object_utils(env_config)

  bit has_virtual_sequencer;

  apb_agent_config apb_a_cfg;
  io_agent_config io_a_cfg;
  aux_agent_config aux_a_cfg;

  function new(string name = "env_config");
    super.new(name);
  endfunction

endclass
