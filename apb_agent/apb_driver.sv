class apb_driver extends uvm_driver #(apb_xtn);
  `uvm_component_utils(apb_driver);
  virtual apb_if vif;
  agent_config   a_cfg;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phsae);
  extern task drive_task(apb_xtn xtn);
  extern task run_phase(uvm_phase phase);
endclass

function apb_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void apb_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build_phase of apb_driver", UVM_LOW)
endfunction

function void apb_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In the connect_phase of apb_driver", UVM_LOW);
  vif = a_cfg.vif;
endfunction

task apb_driver::drive_task(apb_xtn xtn);
  `uvm_info(get_type_name, "drive task enabled", UVM_LOW)
  `uvm_info("APB_DRV_XTN", $sformatf("printing from apb_driver \n , %s", xtn.sprint), UVM_LOW)
endtask

task apb_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  #10;  //WARN:dummy delay, remove this
  `uvm_info(get_type_name, "In the run phase of apb_driver", UVM_LOW)
endtask
