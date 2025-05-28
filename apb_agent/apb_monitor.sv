class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  virtual interface_apb vif;
  apb_agent_config a_cfg;

  apb_xtn xtn;

  uvm_analysis_port #(apb_xtn) ana_port;

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

  xtn = apb_xtn::type_id::create("xtn");
  ana_port = new("ana_port", this);
endfunction

function void apb_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name(), "in the connect phase of monitor", UVM_LOW);
  vif = a_cfg.vif;
endfunction

task apb_monitor::monitor();
  `uvm_info(get_type_name(), "monitor task invoked", UVM_LOW);
  while (!(vif.mon_cb.PSEL && !vif.mon_cb.PENABLE)) begin
    @(vif.mon_cb);
  end
  //NOTE: Starting to moniter the signals when setup state is entered
  xtn.PWRITE = vif.mon_cb.PWRITE;
  xtn.PWDATA = vif.mon_cb.PWDATA;
  xtn.PADDR  = vif.mon_cb.PADDR;
  if (xtn.PWRITE) xtn.PWDATA = vif.mon_cb.PWDATA;

  while (!vif.mon_cb.PREADY) @(vif.mon_cb);
  if (!xtn.PWRITE) xtn.PRDATA = vif.mon_cb.PRDATA;

  `uvm_info("APB_MON", $sformatf("Printing from APB_MONITOR \n %s", xtn.sprint()), UVM_LOW)

  ana_port.write(xtn);
endtask

task apb_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name(), "in run phase of apb_monitor", UVM_LOW);
  forever monitor;
endtask
