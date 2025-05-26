class io_agent_config extends uvm_object;
  `uvm_object_utils(io_agent_config)

  virtual interface_io vif;
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "io_agent_config");
    super.new(name);
  endfunction
endclass
