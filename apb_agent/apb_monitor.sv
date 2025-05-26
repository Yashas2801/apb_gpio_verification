class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  virtual apb_if   vif;
  apb_agent_config a_cfg;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task monitor();
  extern task run_phase(uvm_phase phase);
endclass

function apb_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void apb_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name(), "In the build phase of apb_monitor", UVM_LOW);
  if (!uvm_config_db#(apb_agent_config)::get(this, "", "apb_agent_config", a_cfg)) begin
    `uvm_fatal(get_type_name(), "failed to get agent config in monitor");
  end
endfunction

function void apb_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name(), "in the connect phase of monitor", UVM_LOW);
  vif = a_cfg.vif;
endfunction

task apb_monitor::monitor();
  `uvm_info(get_type_name(), "monitor task invoked", UVM_LOW);
endtask

task apb_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name(), "in run phase of apb_monitor", UVM_LOW);
endtask
