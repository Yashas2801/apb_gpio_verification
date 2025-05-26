class env_config extends uvm_object;
  `uvm_object_utils(env_config)

  bit has_virtual_sequencer;
  bit has_scoreboard;

  apb_agent_config apb_cfg;
  io_agent_config io_cfg;
  aux_agent_config aux_cfg;

  function new(string name = "env_config");
    super.new(name);
  endfunction

endclass
