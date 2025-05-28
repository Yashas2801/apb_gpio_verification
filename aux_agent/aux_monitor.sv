class aux_monitor extends uvm_monitor;
  `uvm_component_utils(aux_monitor)

  virtual interface_aux vif;
  aux_agent_config a_cfg;

  aux_xtn xtn;

  uvm_analysis_port #(aux_xtn) ana_port;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task monitor;
  extern task run_phase(uvm_phase phase);
endclass


function aux_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void aux_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build phase of aux_monitor", UVM_LOW)
  if (!uvm_config_db#(aux_agent_config)::get(this, "", "aux_agent_config", a_cfg))
    `uvm_fatal(get_type_name, "failed to get agent config in monitor")
  xtn = aux_xtn::type_id::create("xtn");
  ana_port = new("ana_port", this);

endfunction

function void aux_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "in the connect phase of monitor", UVM_LOW)
  vif = a_cfg.vif;
endfunction

task aux_monitor::monitor;
  `uvm_info(get_type_name, "monitor task invoked", UVM_LOW)
  @(vif.mon_cb);
  xtn.aux_in = vif.mon_cb.aux_in;
  `uvm_info(get_type_name, $sformatf("Sampled aux_in = %h", xtn.aux_in), UVM_LOW)
  ana_port.write(xtn);
endtask

task aux_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name, "in run phase of aux_monitor", UVM_LOW)
  forever monitor;
endtask
