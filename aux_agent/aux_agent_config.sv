class aux_agent_config extends uvm_object;
  `uvm_object_utils(aux_agent_config)

  virtual interface_aux   vif;
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "aux_agent_config");
    super.new(name);
  endfunction
endclass
