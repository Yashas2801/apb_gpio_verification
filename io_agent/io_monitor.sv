class io_monitor extends uvm_monitor;

  `uvm_component_utils(io_monitor)

  virtual interface_io vif;
  io_agent_config a_cfg;

  io_xtn xtn;

  uvm_analysis_port #(io_xtn) ana_port;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task monitor();
  extern task run_phase(uvm_phase phase);

endclass

function io_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void io_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build phase of io_monitor", UVM_LOW)
  if (!uvm_config_db#(io_agent_config)::get(this, "", "io_agent_config", a_cfg))
    `uvm_fatal(get_type_name, "failed to get agent config in monitor")
  xtn = io_xtn::type_id::create("xtn");
  ana_port = new("ana_port", this);
endfunction

function void io_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "in the connect phase of monitor", UVM_LOW)
  vif = a_cfg.vif;
endfunction

task io_monitor::monitor;
  `uvm_info(get_type_name, "monitor task invoked", UVM_LOW)
  @(vif.mon_cb);
  xtn.io_pad = vif.mon_cb.io_pad;
  xtn.io_dir = vif.mon_cb.io_en;
  xtn.test_var = vif.mon_cb.test_var;
  `uvm_info(get_type_name, $sformatf("Printing from io_monitor \n %s", xtn.sprint), UVM_LOW)
  ana_port.write(xtn);
endtask

task io_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name, "in run phase of io_monitor", UVM_LOW)
  forever monitor;
endtask
